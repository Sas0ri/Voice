//
//  InteractionGetter.m
//  CCTV5
//
//  Created by Pang Zhenyu on 12-7-3.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "InteractionGetter.h"
#import "Context.h"


@implementation InteractionGetter

@synthesize act, optionID, activityID, linkID, data;
@synthesize activityHost = _activityHost;

-(id) init
{
	self = [super init];
	if (self)
	{
		self.shouldAffectNetworkIndicator = NO;
		_activityHost = [Context sharedContext].config.apiHostActivity;
	}
	return self;
}

- (void)setActivityHost:(NSString *)activityHost
{
	if (activityHost.length > 0)
		_activityHost = [[NSString alloc] initWithFormat:@"%@tv_api/api/activity/", activityHost];
}

-(NSString *)apiHost
{
	return _activityHost;
}

-(NSDictionary *)params
{
	if (self.activityID.length <= 0)
		return nil;
	
	if (self.linkID == nil)
		self.linkID = @"";
	if (self.optionID == nil)
		self.optionID = @"";
	
	NSString* stepStr = (self.act == 0 ? @"" : [NSString stringWithFormat:@"%d", self.act]);
	
	return [NSDictionary dictionaryWithObjectsAndKeys:@"getUState", @"cmd", @"activity", @"Action",
			self.activityID, @"id", self.linkID, @"link_id", self.optionID, @"option_id", stepStr, @"act", nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.data = [[InteractionData alloc] initWithDictionary:result];
	return KYResultCodeSuccess;
}

@end



@implementation RuleGetter
@synthesize activityID, description;

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostActivity;
}

-(NSDictionary *)params
{
	if (self.activityID.length <= 0)
		return nil;
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"getActivityRule", @"cmd", 
			@"activity", @"Action",
			self.activityID, @"id", nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.description = [result objectForKey:@"description"];
	return KYResultCodeSuccess;
}
@end


@implementation RankingGetter
@synthesize activityID, activityScore, headURL, seasonScore, rate, topList;

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostActivity;
}

-(NSDictionary *)params
{
	if (self.activityID.length <= 0)
		return nil;
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"getRank", @"cmd", 
			@"activity", @"Action",
			self.activityID, @"id", nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.activityScore = [result objectForKey:@"activity_score"];
	self.headURL = [result objectForKey:@"avatar"];
	self.seasonScore = [result objectForKey:@"item_score"];
	self.rate = [result objectForKey:@"rate"];
	
	NSArray* jsonArr = [result objectForKey:@"top"];
	NSMutableArray* objArr = [NSMutableArray arrayWithCapacity:jsonArr.count];
	for (NSInteger i = 0; i < jsonArr.count; ++i)
	{
		TopRankItem* item = [[TopRankItem alloc] initWithDictionary:[jsonArr objectAtIndex:i]];
		[objArr addObject:item];
	}
	self.topList = objArr;
	return KYResultCodeSuccess;
}

@end


@implementation AcitivityShareGetter
@synthesize activityID, linkID, page, sinaExpire, qqExpire,qzExpire;

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostActivity;
}

-(NSDictionary *)params
{
	if (self.activityID.length <= 0)
		return nil;
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"share", @"cmd", 
			@"activity", @"Action",
			self.activityID, @"id",
			self.linkID, @"link_id",
			self.page, @"page",
			nil];
}

- (BOOL)isFailureProcessed
{
	return YES;
}

-(NSInteger) _parseJSON:(NSDictionary *)result
{
	NSString *sinaExpireStr = [result objectForKey:@"sina_out"];
	self.sinaExpire = (sinaExpireStr != nil && [sinaExpireStr intValue] == 1) ? YES:NO;
	NSString *qqExpireStr = [result objectForKey:@"qq_out"];
	self.qqExpire = (qqExpireStr != nil && [qqExpireStr intValue] == 1) ? YES:NO;
	NSString* qzExpireStr = [result objectForKey:@"qzone_out"];
	self.qzExpire = qzExpireStr != nil && qqExpireStr.intValue == 1;
	return KYResultCodeSuccess;
}
@end


@implementation InteractionSocket

@synthesize act, optionID, activityID, linkID, data;
@synthesize activityHost = _activityHost;

-(id) init
{
	self = [super init];
	if (self)
	{
		//_activityHost = [Context sharedContext].config.socketHostActivity;
	}
	return self;
}

- (void)setActivityHost:(NSString *)activityHost
{
	if (activityHost.length > 0)
		_activityHost = activityHost;
}

-(NSString *)apiHost
{
	return _activityHost;
}

-(NSDictionary *)params
{
	if (self.activityID.length <= 0)
		return nil;
	
	if (self.linkID == nil)
		self.linkID = @"";
	if (self.optionID == nil)
		self.optionID = @"";
	
	NSString* stepStr = (self.act == 0 ? @"" : [NSString stringWithFormat:@"%d", self.act]);
	
	return [NSDictionary dictionaryWithObjectsAndKeys:@"getUState", @"cmd", @"activity", @"Action",
			self.activityID, @"id", self.linkID, @"link_id", self.optionID, @"option_id", stepStr, @"act", nil];
}

-(KYResultCode)_parseJSON:(NSDictionary *)result
{
	self.data = [[InteractionData alloc] initWithDictionary:result];
	return KYResultCodeSuccess;
}

@end

