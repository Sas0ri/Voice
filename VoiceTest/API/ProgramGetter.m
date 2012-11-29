//
//  ProgramGetter.m
//  KuyunTV
//
//  Created by CaoQuan on 12-5-17.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "ProgramGetter.h"
#import "Context.h"
#import "WeiboInfoData.h"
#import "ProgramInfoData.h"
#import "Encodings.h"

@implementation ProgramPageGetter
@synthesize userId, tvColumnId, lastInfoFlowTime, infoFlowPageType, tvId, clientStatus;
@synthesize programInfo;

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
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"tvColumnMain", @"Action",
			self.userId, @"user_id",
			self.tvColumnId, @"tv_column_id",
			self.lastInfoFlowTime, @"last_infoflow_time",
			self.infoFlowPageType, @"infoflow_page_type",
			self.tvId, @"tv_id",
			self.clientStatus, @"client_status",
			nil];
}

-(NSInteger) _parseJSON:(NSDictionary*)result
{
	self.programInfo = [[ProgramPageInfo alloc] initWithDic:result];
	return KYResultCodeSuccess;
}
@end

@implementation RecomendProgramGetter
@synthesize userId, programArr, lastUpdateDate;
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
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"recommendTvColumns", @"Action",
			self.userId, @"user_id",
			nil];
}

-(NSInteger) _parseJSON:(NSDictionary*)result
{
	self.lastUpdateDate = [(NSString*)[result objectForKey:@"rec_latest_time"] dateFromString:DateFormatYMDHMS];
	NSArray* proArr = [result objectForKey:@"rtvc_list"];
	NSMutableArray* tempArr = [[NSMutableArray alloc] init];
	for (NSDictionary* dic in proArr)
	{
		ProgramPageInfo* info = [[ProgramPageInfo alloc] initWithDic:dic];
		info.curTime = self.timeStamp;
		[tempArr addObject:info];
	}
	self.programArr = tempArr;
	return KYResultCodeSuccess;
}
@end

@implementation ProgramDetailGetter

@synthesize programId = programId_,detailInfo = detailInfo_;

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"tvColumnInfo",@"Action",self.programId,@"tv_column_id", nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.detailInfo = [[ProgramDetailInfo alloc] initWithDictionary:result];
	return KYResultCodeSuccess;
}

@end


@implementation ProgramFocusGetter
@synthesize tvColumnId, focus;

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
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"userAttention", @"Action",
			self.focus ? @"add" : @"del", @"cmd",
			self.tvColumnId, @"tv_column_id",
			nil];
}
@end

@implementation ProgramOrderGetter
@synthesize tvColumnId, order;

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
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"userOrder", @"Action",
			self.order ? @"add" : @"del", @"cmd",
			self.tvColumnId, @"tv_column_id",
			nil];
}
@end


@implementation ProgramShare
@synthesize columnId, sinaExpire, qqExpire,qzExpire;

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
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"userShare", @"Action",
			self.columnId, @"tv_column_id",
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
	self.qzExpire = qzExpireStr != nil && ([qzExpireStr intValue] == 1);
	//	self.sinaExpire = [[result objectForKey:@"sina_out"] boolValue];
//	self.qqExpire = [[result objectForKey:@"qq_out"] boolValue];
	return KYResultCodeSuccess;
}
@end

@implementation ProgramUserCommentGetter
@synthesize toWeibo, snsGetterType, columnId, content, sinaExpire, qqExpire,qzExpire;

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
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"userComment", @"Action",
			[NSString stringWithFormat:@"%d", self.snsGetterType], @"weibo_type",
			@"1", @"to_weibo",
			self.content, @"content",
			self.columnId, @"tv_column_id",
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
	NSString *qqExpireStr = [result objectForKey:@"sina_out"];
	self.qqExpire = (qqExpireStr != nil && [qqExpireStr intValue] == 1) ? YES:NO;
	NSString* qzExpireStr = [result objectForKey:@"qzone_out"];
	self.qzExpire = qzExpireStr != nil && ([qzExpireStr intValue] == 1);
	return KYResultCodeSuccess;
}
@end

@implementation TagCollectionGetter
@synthesize giftId, msgContent, isFav, title, columnId, type, msgId;

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
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"userFav", @"Action",
			self.isFav ? @"add" : @"del", @"cmd",
			self.columnId, @"tv_column_id",
			[NSString stringWithFormat:@"%d", self.type], @"type",
			self.giftId, @"goods_gift_id",
//			self.title, @"res_title",
//			self.msgContent, @"res_content",
			nil];
}
@end

@implementation TagCollectionDelGetter
@synthesize favIds;
-(id)init
{
	self = [super init];
	if (self)
	{
		self.shouldStoreResult = NO;
	}
	return self;
}

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary *)params
{
	NSMutableString* ids = [[NSMutableString alloc] init];
	for (NSString* str in self.favIds)
	{
		[ids appendString:str];
		if (![ids isEqualToString:self.favIds.lastObject]) 
		{
			[ids appendString:@","];
		}
	}
	return [NSDictionary dictionaryWithObjectsAndKeys:@"userFav",@"Action",@"batch_del",@"cmd",ids,@"user_fav_ids", nil];
}

@end

@implementation ProgramCommentGetter

@synthesize comments, columnId, topic;

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary*) params
{
	if (self.columnId.length <= 0)
		return nil;
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"tvColumnComments", @"Action",
			self.columnId, @"tv_column_id",
			nil];
}

-(NSInteger) _parseJSON:(NSDictionary *)result
{
	self.topic = [result objectForKey:@"topic"];
	NSArray* jsonList = [result objectForKey:@"comment_list"];
	NSMutableArray* commentList = [NSMutableArray arrayWithCapacity:jsonList.count];
	for (NSInteger i = 0; i < jsonList.count; ++i)
	{
		NSDictionary* weiboDic = [jsonList objectAtIndex:i];
		WeiboFeed* info = [[WeiboFeed alloc] initWithDictionary:weiboDic withType:0];
		[commentList addObject:info];
		info = nil;
	}
	self.comments = commentList;
	return KYResultCodeSuccess;
}

@end

@implementation ColumnRecognizeGetter

@synthesize keyword,columnId;

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"identifyTvColumn",@"Action",self.keyword,@"key_words", nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.columnId = [result objectForKey:@"tv_column_id"];
	return KYResultCodeSuccess;
}

@end


@implementation FocusListGetter
@synthesize focusList = focusList_,page = page_;

-(id)init
{
	self = [super init];
	if (self)
	{
		self.page = 1;
	}
	return self;
}

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"userAttention", @"Action",
			 @"get", @"cmd",[NSString stringWithFormat:@"%d",self.page],@"page",nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.focusList = [result objectForKey:@"attention_list"];
	NSMutableArray* arr = [NSMutableArray arrayWithCapacity:0];
	for (int i = 0; i < self.focusList.count; i++)
	{
		SingleProgram* sp = [[SingleProgram alloc] initWithDictionary:[self.focusList objectAtIndex:i]];
		[arr addObject:sp];
	}
	self.focusList = arr;
	return KYResultCodeSuccess;
}

@end

@implementation OrderListGetter
@synthesize orderList = orderList_,page = page_;

-(id)init
{
	self = [super init];
	if (self)
	{
		self.page = 1;
	}
	return self;
}

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostProgram;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"userOrder", @"Action",
			@"get", @"cmd",[NSString stringWithFormat:@"%d",self.page],@"page",nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.orderList = [result objectForKey:@"order_list"];
	NSMutableArray* arr = [NSMutableArray arrayWithCapacity:0];
	for (int i = 0; i < self.orderList.count; i++)
	{
		SingleProgram* sp = [[SingleProgram alloc] initWithDictionary:[self.orderList objectAtIndex:i]];
		[arr addObject:sp];
	}
	self.orderList = arr;
	return KYResultCodeSuccess;
}

@end
