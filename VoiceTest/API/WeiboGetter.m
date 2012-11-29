//
//  WeiboGetter.m
//  KuyunTV
//
//  Created by Sasori on 12-5-25.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "WeiboGetter.h"
#import "Context.h"

@implementation WeiboGetter
@synthesize weiboName = weiboName_,weiboType = weiboType_,weiboData = weiboData_,weiboId = weiboId_;

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"msg_list",@"cmd",@"userWeibo",@"Action",self.weiboName,@"weibo_name",self.weiboType,@"weibo_type",self.weiboId,@"weibo_id",nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.weiboData = [[WeiboInfoData alloc] initWithDictionary:result];
	return KYResultCodeSuccess;
}

@end
