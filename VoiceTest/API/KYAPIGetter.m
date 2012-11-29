//
//  KYAPIGetter.m
//  Kuyun
//
//  Created by Pang Zhenyu on 11-9-21.
//  Copyright 2011年 Tenfen Inc. All rights reserved.
//

#import "KYAPIGetter.h"
#import "Context.h"
#import "Encodings.h"
#import "DaemonWorker.h"
#import "DataCacheService.h"
#import "NSObject+JSON.h"


@interface KYAPIGetter()

-(NSData*) configModelParams:(NSDictionary*)partialParams shouldCarryLog:(BOOL)carryLog;

@end


@implementation KYAPIGetter

@synthesize apiVersion = _apiVersion;
@synthesize timeStamp = _timeStamp;
@synthesize shouldCarryLog;
-(id)init
{
	self = [super init];
	if (self)
	{
		self.shouldCarryLog = YES;
	}
	return self;
}

-(void) dealloc
{
	if (_isLogCarrier)
	{
		// This case shouldn't happen. But we just add this logic to avoid losing of logs. By Pang Zhenyu
		_isLogCarrier = NO;
		[Context sharedContext].isUploadingLog = NO;
	}
	
	[_apiVersion release];
	[_timeStamp release];
	[super dealloc];
}

-(NSDictionary*) params
{
	return nil;
}

-(NSString*) apiHost
{
	return nil;
}

- (BOOL)isFailureProcessed
{
	return NO;
}

-(NSURLRequest*) _createRequest:(KYHttpCachePolicy)cachePolicy
{
	NSString* apiHost = self.apiHost;
	NSDictionary* paramDic = [self params];
	if (paramDic == nil || apiHost.length <= 0)
		return nil;
	
	Config* config = [Context sharedContext].config;
	NSURL* url = [NSURL URLWithString:apiHost];
	NSData* body = [self configModelParams:paramDic shouldCarryLog:(cachePolicy == KYHttpCachePolicyIgnoreCache && self.shouldCarryLog)];
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
														   cachePolicy:NSURLRequestReloadIgnoringCacheData
													   timeoutInterval:config.networkTimeout];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:body];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:config.clientAgent forHTTPHeaderField:@"User-Agent"];
	[request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
	return request;
}

-(NSInteger) _fillModelWithData:(NSData*)data
{
	NSInteger retCode = KYResultCodeParseError;
	
	id json = [data JSONValue];
	if ([json isKindOfClass:[NSDictionary class]])
	{
        
		id response = [(NSDictionary*)json objectForKey:@"Response"];
		if ([response isKindOfClass:[NSDictionary class]])
		{
			NSDictionary* dic = (NSDictionary*)response;
			NSString* result = [dic objectForKey:@"result-code"];
			if ([result isEqualToString:@"0"])
				retCode = KYResultCodeSuccess;
			else
				retCode = [result intValue];
			
			self.apiVersion = [dic objectForKey:@"APIVersion"];
			self.timeStamp = [(NSString*)[dic objectForKey:@"TimeStamp"] dateFromString:DateFormatYMDHMS];
			if (retCode == KYResultCodeSuccess)
			{
				NSString* uid = [dic objectForKey:@"user_id"];
				if (uid.length > 0)
				{
					[Context sharedContext].loginInfo.userId = uid;
					[[Context sharedContext] saveLoginInfo];
                    
                    [[Context sharedContext].daemonWorker updateDeviceToken];
				}
				retCode = [self _parseJSON:dic];
			}
			else if (self.isFailureProcessed) 
			{
				[self _parseJSON:dic];
			}
		}
	}
	
	return retCode;
}

-(void) sendNotification
{
	if (_isLogCarrier)
	{
		_isLogCarrier = NO;
		[Context sharedContext].isUploadingLog = NO;

		if (_tempResultCode == KYResultCodeUnInit || _tempResultCode == KYResultCodeTimeout || _tempResultCode == KYResultCodeNetworkError  || _tempResultCode == KYResultCodeCanceled || _tempResultCode == KYResultCodeCacheNotFound || _tempResultCode == KYResultCodeInvalidRequest)
		{
		}
		else
		{
			[[DataCacheService cacheWithType:DataCacheServicePermanence] saveData:KYLogStorageKey data:nil];
		}
		
		NSData* data = [[DataCacheService cacheWithType:DataCacheServicePermanence] getData:KYLogTempStorageKey];
		[[DataCacheService cacheWithType:DataCacheServicePermanence] saveData:KYLogTempStorageKey data:nil];
		if (data)
		{
			NSString* str = [[[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
			if (str.length > 0)
				[[Context sharedContext].daemonWorker addLogWithRawString:str];
		}
	}
	[super sendNotification];
}

-(NSInteger) _parseJSON:(NSDictionary*)result
{
	return KYResultCodeSuccess;
}

-(NSData*) configModelParams:(NSDictionary*)partialParams shouldCarryLog:(BOOL)carryLog
{
	NSMutableDictionary* params = [partialParams mutableCopy];
	
	Config* config = [Context sharedContext].config;
	[params setValue:config.apiVersion forKey:@"APIVersion"];
	[params setValue:config.clientAgent forKey:@"Client-Agent"];
	[params setValue:config.clientType forKey:@"Client-Type"];
	[params setValue:config.clientVersionType forKey:@"Client-Version-Type"];
	[params setValue:config.productId forKey:@"copyRightId"];

	// If user_id exists, send user_id, or send IMEI(UDID)
	if ([Context sharedContext].userId.length > 0)
		[params setValue:[Context sharedContext].userId forKey:@"user_id"];
	else
		[params setValue:[NSString stringWithFormat:@"%@|%@", config.imei, config.macAddress] forKey:@"IMEI"];
	
	// Calculate cache key
	NSArray* keys = [[params allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSMutableString* buffer = [[NSMutableString alloc] initWithCapacity:0];
	for (NSUInteger i = 0; i < keys.count; ++i)
	{
		NSString* key = [keys objectAtIndex:i];
		[buffer appendFormat:@"&%@=%@", key, [params objectForKey:key]];
	}
	self.cacheKey = buffer;
	[buffer release];
	
	// Rtime shouldn't use for calculating cache key. Add it after calculation.
	double dTime = [[NSDate date] timeIntervalSince1970];
	[params setValue:[NSString stringWithFormat:@"%.0f", dTime] forKey:@"Rtime"];
	
	[params setValue:[NSString stringWithFormat:@"%d", [Context sharedContext].networkStatus] forKey:@"NetState"];
	
	// Check should add user action log, and add it to request
	if (carryLog && ![Context sharedContext].isUploadingLog)
	{
		NSData* data = [[DataCacheService cacheWithType:DataCacheServicePermanence] getData:KYLogStorageKey];
		if (data)
		{
			NSString* log = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
			if (log.length > 0)
			{
				[Context sharedContext].isUploadingLog = YES;
				_isLogCarrier = YES;
				[params setObject:log forKey:@"signflag"];
			}
		}
	}
	
	// Calculate sig and body data.
	keys = [[params allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	buffer = [[NSMutableString alloc] initWithCapacity:0];
	for (NSUInteger i = 0; i < keys.count; ++i)
	{
		if (i > 0)
			[buffer appendString:@"&"];
		NSString* key = [keys objectAtIndex:i];
		[buffer appendFormat:@"%@=%@", key, [(NSString*)[params objectForKey:key] urlEncode:NSUTF8StringEncoding]];
	}
	
	[params release];
	
	NSString* bodyStr = [NSString stringWithString:buffer];
	
	[buffer appendString:config.secretKey];
	NSString* sig = [buffer sha1];
	[buffer release];
	
	bodyStr = [bodyStr stringByAppendingFormat:@"&Sign=%@", sig];
	
	LOG_debug(@"%@?%@", self.apiHost, bodyStr);
	
	return [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
}

@end
