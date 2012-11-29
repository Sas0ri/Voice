//
//  KYAPIImageGetter.m
//  Kuyun
//
//  Created by Pang Zhenyu on 11-9-22.
//  Copyright 2011年 Tenfen Inc. All rights reserved.
//

#import "KYAPIImageGetter.h"
#import "Context.h"
#import "Encodings.h"


@implementation KYAPIImageGetter

@synthesize width = _width;
@synthesize useImageGateway = _useImageGateway;
@synthesize image = _image;
@synthesize referUrl = _referUrl;
@synthesize imageId = _imageId;
@synthesize imageSize = _imageSize;

-(id) init
{
	self = [super init];
	if (self)
	{
		self.cachePolicy = KYHttpCachePolicyUseIfAvailable;
		self.shouldStoreResult = YES;
		self.imageSize = CGSizeZero;
	}
	return self;
}

-(void) dealloc
{
	self.image = nil;
	self.referUrl = nil;
	self.imageId = nil;
	[super dealloc];
}

-(NSURLRequest*) _createRequest:(KYHttpCachePolicy)cachePolicy
{
	if (_imageId.length <= 0)
		return nil;
	
	Config* config = [Context sharedContext].config;
	
	NSURL* url = nil;
	if (self.useImageGateway)
	{
//		NSInteger q = [[Context sharedContext].appSettings.imageQuality intValue];
		NSInteger quality = 80;//(q == 1 ? 50 : (q == 2 ? 30 : 80));
		NSString* ustr = [NSString stringWithFormat:@"%@?d=1&q=%d&u=%@", config.apiHostImage, quality, [self.imageId urlEncode:NSUTF8StringEncoding]];
		self.cacheKey = self.imageId;
		if (self.width > 0)
		{
			NSInteger w = ([UIScreen mainScreen].scale >= 2.0f ? self.width * 2 : self.width);
			ustr = [ustr stringByAppendingFormat:@"&w=%d", w];
			self.cacheKey = [self.cacheKey stringByAppendingFormat:@"&w=%d", w];
		}
		url = [NSURL URLWithString:ustr];
	}
	else
	{
		url = [NSURL URLWithString:self.imageId];
	}
	
	LOG_info(@"%@", url);
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
														   cachePolicy:NSURLRequestReloadIgnoringCacheData
													   timeoutInterval:config.networkTimeout];
	
	[request setHTTPMethod:@"GET"];
	[request setValue:config.clientAgent forHTTPHeaderField:@"User-Agent"];
	if (self.referUrl.length > 0)
		[request setValue:self.referUrl forHTTPHeaderField:@"referer"];
	return request;
}

-(NSInteger) _fillModelWithData:(NSData *)data
{
	UIImage* im = [UIImage imageWithData:data];
	if (im != nil)
	{
		self.image = [UIImage imageWithCGImage:im.CGImage scale:[UIScreen mainScreen].scale orientation:im.imageOrientation];
//		self.image = im;
		self.imageSize = im.size;
		return KYResultCodeSuccess;
	}
	return KYResultCodeParseError;
}

-(void) _didReceiveResponse:(NSURLResponse *)response
{
	if (self.useImageGateway)
	{
		NSDictionary* headers = [(NSHTTPURLResponse*)response allHeaderFields];
		NSString* sizeStr = [headers objectForKey:@"Original-Image-Size"];
		if (sizeStr.length > 0)
		{
//			NSLog(@"Original Image Size: %@", sizeStr);
			NSUInteger location = [sizeStr rangeOfString:@"*"].location;
			if (location != NSNotFound && location > 0 && location < sizeStr.length - 1)
			{
				CGFloat width = [[sizeStr substringToIndex:location] floatValue];
				CGFloat height = [[sizeStr substringFromIndex:location + 1] floatValue];
				self.imageSize = CGSizeMake(width, height);
			}
		}
		NSString* faceStr = [headers objectForKey:@"Face-Coordinate"];
		if (faceStr.length > 0)
		{
//			NSLog(@"Face Coordinate: %@", faceStr);
		}
	}
}

@end
