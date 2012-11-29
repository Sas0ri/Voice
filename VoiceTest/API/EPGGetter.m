//
//  EPGGetter.m
//  KuyunTV
//
//  Created by Sasori on 12-5-17.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "EPGGetter.h"
#import "EPGInfoData.h"
#import "Context.h"

@implementation EPGGetter

@synthesize tvID = tvID_;
@synthesize epgList = epgList_;
@synthesize epgTime = epgTime_;
@synthesize sortType = sortType_;
@synthesize typeList = typeList_;
-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostEPG;
}

-(NSDictionary *)params
{
//	 @"Action=EPG&test=tenfen&time=2012-05-14%2002:13:00&user_id=100000";
	NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"EPG",@"Action",self.epgTime,@"time",nil];
	if (self.tvID)
		[dic setObject:self.tvID forKey:@"tv_id"];
	if (self.sortType)
		[dic setObject:self.sortType forKey:@"column_type_id"];
	return dic;
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	NSArray* EPGs = [result objectForKey:@"epgs"];
	NSString* timeStamp = [result objectForKey:@"TimeStamp"];
	NSMutableArray* arr = [NSMutableArray arrayWithCapacity:0];

	if (self.tvID)
	{
		if (EPGs.count > 0)
		{
			EPGInfoData* info = [[EPGInfoData alloc] initWithDictionary:[EPGs objectAtIndex:0]];
			for (int i = 0; i < info.feedList.count; i++) 
			{
				EPGInfoData* sinfo = [[EPGInfoData alloc] init];
				sinfo.channelID = info.channelID;
				sinfo.channelIcon = info.channelIcon;
				sinfo.channelTitle = info.channelTitle;
				sinfo.timeStamp = timeStamp;
				sinfo.feedList = [NSArray arrayWithObject:[info.feedList objectAtIndex:i]];
				[arr addObject:sinfo];
			}
		}
	}
	else
	{
		for (int i = 0; i < EPGs.count; i++)
		{
			EPGInfoData* info = [[EPGInfoData alloc] initWithDictionary:[EPGs objectAtIndex:i]];
			info.timeStamp = timeStamp;
			[arr addObject:info];
		}
	}
	self.epgList = arr;

	arr = [NSMutableArray arrayWithCapacity:0];
	NSArray* typeArr = [result objectForKey:@"type_list"];
	for (int i = 0; i < typeArr.count; i++)
	{
		EPGFeedType* et = [[EPGFeedType alloc] initWithDictionary:[typeArr objectAtIndex:i]];
		[arr addObject:et];
	}
	self.typeList = arr;

	return KYResultCodeSuccess;
}

@end
