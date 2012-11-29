//
//  PreloadGetter.m
//  CCTV5
//
//  Created by CaoQuan on 12-7-2.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "PreloadGetter.h"
#import "Context.h"

@implementation PreloadGetter
@synthesize activityId, templetId, zipUrl, templetName, activityHost, activitySocketHost;

-(id) init
{
	self = [super init];
	if (self)
	{
		self.shouldStoreResult = NO;
	}
	return self;
}

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostActivity;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"activity", @"Action",
			@"getActivityZip", @"cmd",
			self.activityId, @"id",
			nil];
}

-(NSInteger) _parseJSON:(NSDictionary *)result
{
	self.templetId = [result objectForKey:@"templet_id"];
	self.zipUrl = [result objectForKey:@"zip_url"];
	self.templetName = [result objectForKey:@"file_name"];
	self.activityHost = [result objectForKey:@"api_domain"];
	self.activitySocketHost = [result objectForKey:@"socket_host_port"];
	return KYResultCodeSuccess;
}
@end


@implementation KYAPIZipGetter
@synthesize fileName, zipURL, localPath;

- (id)init
{
	if (self = [super init]) {
		self.cachePolicy = KYHttpCachePolicyIgnoreCache;
		self.shouldStoreResult = YES;
	}
	return self;
}

- (NSURLRequest *)_createRequest:(KYHttpCachePolicy)cachePolicy
{
	if (self.zipURL.length <= 0) {
		return nil;
	}
	
	NSURL *url = [NSURL URLWithString:self.zipURL];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:[Context sharedContext].config.networkTimeout];
	[request setHTTPMethod:@"GET"];
	[request setValue:[Context sharedContext].config.clientAgent forHTTPHeaderField:@"User-Agent"];
	return request;
}

- (NSInteger)_fillModelWithData:(NSData *)data
{
	NSString *docPath = [Theme onlineSkinPath];
	NSFileManager *fman = [NSFileManager defaultManager];
	self.localPath = [[docPath stringByAppendingPathComponent:self.fileName] stringByAppendingString:@".zip"];
	if ([fman fileExistsAtPath:self.localPath]) {
		NSError* error = nil;
		[fman removeItemAtPath:self.localPath error:&error];
	}
	[fman createFileAtPath:self.localPath contents:data attributes:nil];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:self.localPath])
		return KYResultCodeSuccess;
	else
		return KYResultCodeCacheNotFound;
}

@end