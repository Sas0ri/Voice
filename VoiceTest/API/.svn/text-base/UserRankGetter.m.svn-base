//
//  UserRankGetter.m
//  KuyunTV
//
//  Created by Sasori on 12-6-6.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "UserRankGetter.h"
#import "Context.h"
#import "UserRankInfo.h"

@implementation UserRankGetter

@synthesize rankList,page;

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"activity",@"Action",@"userItemRank",@"cmd",[NSString stringWithFormat:@"%d",self.page],@"page", nil];
}

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostActivity;
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.rankList = [result objectForKey:@"rank_list"];
	NSMutableArray* arr = [NSMutableArray arrayWithCapacity:0];
	for (int i = 0; i < self.rankList.count; i++)
	{
		UserRankInfo* ri = [[UserRankInfo alloc] initWithDictionary:[self.rankList objectAtIndex:i]];
		[arr addObject:ri];
	}
	self.rankList = arr;
	return KYResultCodeSuccess;
}

@end


@implementation UserItemRankGetter

@synthesize rankList,page,itemId;

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"activity",@"Action",@"userActivityRank",@"cmd",self.itemId,@"item_id",[NSString stringWithFormat:@"%d",self.page],@"page", nil];
}

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostActivity;
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.rankList = [result objectForKey:@"rank_list"];
	NSMutableArray* arr = [NSMutableArray arrayWithCapacity:0];
	for (int i = 0; i < self.rankList.count; i++)
	{
		UserItemRankInfo* ri = [[UserItemRankInfo alloc] initWithDictionary:[self.rankList objectAtIndex:i]];
		[arr addObject:ri];
	}
	self.rankList = arr;
	return KYResultCodeSuccess;
}

@end
