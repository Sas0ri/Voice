//
//  NoticeGetter.m
//  KuyunTV
//
//  Created by CaoQuan on 12-5-29.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "NoticeGetter.h"
#import "Context.h"
#import "NoticeData.h"

@implementation NoticeGetter
@synthesize lastNoticeId, columnId, noticeArr, columnActivityId, columnActivityStatus, interval, unreadCount, recColumns, clientStatus, autoEnter, activityHost;

-(id) init
{
	self = [super init];
	if (self)
	{
		self.shouldStoreResult = NO;
		self.shouldAffectNetworkIndicator = NO;
	}
	return self;
}

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostTvNotice;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"notice", @"Action",
			@"getLatestNotices", @"cmd",
			self.lastNoticeId, @"notice_id",
			self.columnId, @"tv_column_id",
			self.clientStatus, @"client_status",
			nil];
}

-(NSInteger) _parseJSON:(NSDictionary*)result
{
	self.unreadCount = [[result objectForKey:@"count"] intValue];
	self.columnActivityId = [result objectForKey:@"column_activity_id"];
	self.columnActivityStatus = [[result objectForKey:@"column_activity_status"] intValue];
	self.autoEnter = [[result objectForKey:@"activity_enter"] boolValue];
	self.activityHost = [result objectForKey:@"api_domain"];
	self.interval = [[result objectForKey:@"notice_time"] intValue];
	self.recColumns = [result objectForKey:@"rec_columns"];
	NSArray* dicArr = [result objectForKey:@"notice_list"];
	NSMutableArray* tempArr = [[NSMutableArray alloc] init];
	for (NSDictionary* dic in dicArr)
	{
		NoticeData* info = [[NoticeData alloc] initWithDic:dic];
		[tempArr addObject:info];
	}
	self.noticeArr = tempArr;
	return KYResultCodeSuccess;
}
@end

@implementation NotificationGetter

@synthesize page,notificationList;

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostTvNotice;
}

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"notice", @"Action",
			@"getNotices", @"cmd",
			[NSString stringWithFormat:@"%d",self.page], @"page",
			nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.notificationList = [result objectForKey:@"notice_list"];
	NSMutableArray* arr = [NSMutableArray arrayWithCapacity:0];
	for (NSDictionary* dic in self.notificationList)
	{
		NoticeData* nd = [[NoticeData alloc] initWithDic:dic];
		[arr  addObject:nd];
	}
	self.notificationList = arr;
	return KYResultCodeSuccess;
}

@end

@implementation ActivityGetter

@synthesize activityId,playSound;

-(id)init
{
	self = [super init];
	if (self)
	{
		self.playSound = [Context sharedContext].settings.shouldPlaySound;
	}
	return self;
}

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostActivity;
}

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:self.activityId, @"id",@"get",@"cmd",@"activity",@"Action",self.playSound?@"1":@"0",@"playSound", nil];
}

@end
