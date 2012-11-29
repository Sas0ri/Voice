//
//  SNSGetter.m
//  Kuyun
//
//  Created by sunyuan on 11-10-10.
//  Copyright 2011年 Tenfen Inc. All rights reserved.
//

#import "SNSGetter.h"
#import "Context.h"
//#import "SNSData.h"
#import "NSObject+JSON.h"
#import "Encodings.h"


#pragma mark - 微博社交部分
//@implementation SNSGetterGetSelfTimeline
//@synthesize snsGetterType;
//@synthesize tokenKey, tokenSecret;
//@synthesize sinaWeiboMaxId;
//@synthesize msgList;
//@synthesize qWeiboLastTime, qWeiboPageFlag;
//-(id) init
//{
//	self = [super init];
//	if (self)
//	{
//		self.shouldStoreResult = YES;
//	}
//	return self;
//}
//-(void) dealloc
//{
//	self.sinaWeiboMaxId = nil;
//	[tokenKey release];
//	[tokenSecret release];
//	[msgList release];
//	[qWeiboLastTime release];
//	[qWeiboPageFlag release];
//	[super dealloc];
//}
//-(NSString*) apiHost
//{
//	return [Context sharedContext].config.apiHostUser;
//}
//-(NSDictionary*) params
//{	
//	NSString *typeStr = [NSString stringWithFormat:@"%d",self.snsGetterType];
//	
//	if(self.snsGetterType == SNSGetterTypeQWeibo)
//		self.sinaWeiboMaxId = nil;
//	if(self.snsGetterType == SNSGetterTypeSinaWeibo)
//	{
//		self.qWeiboLastTime = @"-100";
//		self.qWeiboPageFlag = @"-100";
//	}
//	
//	LoginUserInfo* linfo = [Context sharedContext].loginInfo;
//	if(self.snsGetterType == SNSGetterTypeSinaWeibo)
//	{
//		self.tokenKey = linfo.sinaWeiboToken;
//		self.tokenSecret = linfo.sinaWeiboTokenSecret;
//	}
//	if(self.snsGetterType == SNSGetterTypeQWeibo)
//	{
//		self.tokenKey = linfo.tencentWeiboToken;
//		self.tokenSecret = linfo.tencentWeiboTokenSecret;
//	}
//	if(!self.tokenKey || self.tokenKey.length <= 0)
//		return nil;
//	if(!self.tokenSecret || self.tokenSecret.length <= 0)
//		return nil;
//	if (self.sinaWeiboMaxId == nil) self.sinaWeiboMaxId = @"";
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"userWeibo", @"Action",
//			@"msg_list", @"cmd",
//			typeStr, @"weibo_type",
//			self.tokenKey, @"weibo_token",
//			self.tokenSecret, @"weibo_tokenSecret",
//			self.sinaWeiboMaxId, @"maxId",
//			self.qWeiboLastTime, @"pagetime",
//			self.qWeiboPageFlag, @"pageflag",
//			nil];
//}
//-(NSInteger) _parseJSON:(NSDictionary*)result
//{
//	if(self.snsGetterType == SNSGetterTypeQWeibo)
//		self.qWeiboLastTime = [NSString stringWithFormat:@"%d",((NSNumber *)[result objectForKey:@"last_time"]).intValue];
//	else
//		self.qWeiboLastTime = @"a000";
//	NSArray *tmpResultArr = [[result objectForKey:@"msg_list"] copy];
//	NSMutableArray *arr = [NSMutableArray array];
//	for(NSDictionary *tmpDic in tmpResultArr)
//	{
//		WeiboTwitteInfo *info = [[WeiboTwitteInfo alloc] initWithDictionary:tmpDic];
//		[arr addObject:info];
//		[info release];
//	}
//	[tmpResultArr release];
//	self.msgList = arr;
//	return KYResultCodeSuccess;
//}
//@end
//
//
//@implementation SNSGetterGetSelfFriends
//@synthesize snsGetterType;
//@synthesize tokenKey, tokenSecret;
//@synthesize sinaWeiboPage;
//@synthesize qWeiboPage, qWeiboPageSize;
//@synthesize friendList;
//@synthesize sinaWeiboCursor;
//- (void)dealloc
//{
//	[tokenKey release];
//	[tokenSecret release];
//	[friendList release];
//	[super dealloc];
//}
//- (NSString *)apiHost
//{
//	return [Context sharedContext].config.apiHostUser;
//}
//-(NSDictionary*) params
//{	
//	NSString *typeStr = [NSString stringWithFormat:@"%d",self.snsGetterType];
//	
//	if(self.snsGetterType == SNSGetterTypeQWeibo)
//	{
//		self.sinaWeiboPage = -100;
//	}
//	if(self.snsGetterType == SNSGetterTypeSinaWeibo)
//	{
//		self.qWeiboPage = -100;
//		self.qWeiboPageSize = -100;
//	}
//	NSString *sinaWeiboPageStr = [NSString stringWithFormat:@"%d",self.sinaWeiboPage];
//	NSString *qWeiboPageStr = [NSString stringWithFormat:@"%d",self.qWeiboPage];
//	NSString *qWeiboPageSizeStr = [NSString stringWithFormat:@"%d",self.qWeiboPageSize];
//	
//	LoginUserInfo* linfo = [Context sharedContext].loginInfo;
//	if(self.snsGetterType == SNSGetterTypeSinaWeibo)
//	{
//		self.tokenKey = linfo.sinaWeiboToken;
//		self.tokenSecret = linfo.sinaWeiboTokenSecret;
//	}
//	if(self.snsGetterType == SNSGetterTypeQWeibo)
//	{
//		self.tokenKey = linfo.tencentWeiboToken;
//		self.tokenSecret = linfo.tencentWeiboTokenSecret;
//	}
//	
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"userWeibo", @"Action",
//			@"friends", @"cmd",
//			typeStr, @"weibo_type",
//			self.tokenKey, @"weibo_token",
//			self.tokenSecret, @"weibo_tokenSecret",
//			sinaWeiboPageStr, @"next_cursor",
//			qWeiboPageStr, @"pageNum",
//			qWeiboPageSizeStr, @"pageSize",
//			nil];
//}
//-(NSInteger) _parseJSON:(NSDictionary*)result
//{
//	NSArray *tmpArr = [[result objectForKey:@"frined_list"] copy];
//	NSMutableArray *tmpResultArr = [NSMutableArray array];
//	for(NSDictionary *dic in tmpArr)
//	{
//		WeiboFriendInfo *info = [[WeiboFriendInfo alloc] initWithDictionary:dic];
//		[tmpResultArr addObject:info];
//		[info release];
//	}
//	[tmpArr release];
//	self.friendList = tmpResultArr;
//	if(self.snsGetterType == SNSGetterTypeSinaWeibo)
//	{
//		sinaWeiboCursor = [[result objectForKey:@"cursor"] intValue];
//	}
//	return KYResultCodeSuccess;
//}
//@end
//
//@implementation SNSGetterTwitte
//@synthesize snsGetterType;
//@synthesize tokenKey, tokenSecret;
//@synthesize feedID, feedContent;
//@synthesize imageUrl;
//- (void)dealloc
//{
//	[tokenKey release];
//	[tokenSecret release];
//	[feedID release];
//	[feedContent release];
//	[imageUrl release];
//	[super dealloc];
//}
//- (NSString *)apiHost
//{
//	return [Context sharedContext].config.apiHostUser;
//}
//-(NSDictionary*) params
//{	
//	NSString *typeStr = [NSString stringWithFormat:@"%d",self.snsGetterType];
//	
//	LoginUserInfo* linfo = [Context sharedContext].loginInfo;
//	if(self.snsGetterType == SNSGetterTypeSinaWeibo)
//	{
//		self.tokenKey = linfo.sinaWeiboToken;
//		self.tokenSecret = linfo.sinaWeiboTokenSecret;
//	}
//	if(self.snsGetterType == SNSGetterTypeQWeibo)
//	{
//		self.tokenKey = linfo.tencentWeiboToken;
//		self.tokenSecret = linfo.tencentWeiboTokenSecret;
//	}
//	if(!self.tokenKey || self.tokenKey.length <= 0)
//		return nil;
//	if(!self.tokenSecret || self.tokenSecret.length <= 0)
//		return nil;
//	if(!self.imageUrl || self.imageUrl.length <= 0)
//		self.imageUrl = @"";
//	if(!self.feedID || self.feedID.length <= 0)
//		self.feedID = @"";
//	if(!self.feedContent || self.feedContent.length <= 0)
//		self.feedContent = @"";
//	
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"userWeibo", @"Action",
//			@"send_msg", @"cmd",
//			typeStr, @"weibo_type",
//			self.tokenKey, @"weibo_token",
//			self.tokenSecret, @"weibo_tokenSecret",
//			self.feedID, @"res_id",
//			self.feedContent, @"content",
//			self.imageUrl, @"img_url",
//			nil];
//}
//-(NSInteger) _parseJSON:(NSDictionary*)result
//{
//	return KYResultCodeSuccess;
//}
//
//@end
//
//
//@implementation SNSGetterMsgForward
//@synthesize snsGetterType;
//@synthesize tokenKey, tokenSecret;
//@synthesize msgID;
//@synthesize content;
//- (void)dealloc
//{
//	[tokenKey release];
//	[tokenSecret release];
//	[msgID release];
//	[content release];
//	[super dealloc];
//}
//- (NSString *)apiHost
//{
//	return [Context sharedContext].config.apiHostUser;
//}
//- (NSDictionary *)params
//{
//	NSString *typeStr = [NSString stringWithFormat:@"%d",self.snsGetterType];
//	
//	LoginUserInfo* linfo = [Context sharedContext].loginInfo;
//	if(self.snsGetterType == SNSGetterTypeSinaWeibo)
//	{
//		self.tokenKey = linfo.sinaWeiboToken;
//		self.tokenSecret = linfo.sinaWeiboTokenSecret;
//	}
//	if(self.snsGetterType == SNSGetterTypeQWeibo)
//	{
//		self.tokenKey = linfo.tencentWeiboToken;
//		self.tokenSecret = linfo.tencentWeiboTokenSecret;
//	}
//	if(!self.tokenKey || self.tokenKey.length <= 0)
//		return nil;
//	if(!self.tokenSecret || self.tokenSecret.length <= 0)
//		return nil;
//	if(!self.content || self.content.length <= 0)
//		self.content = @"";
//	
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"userWeibo", @"Action",
//			@"forward_msg", @"cmd",
//			typeStr, @"weibo_type",
//			self.tokenKey, @"weibo_token",
//			self.tokenSecret, @"weibo_tokenSecret",
//			self.msgID, @"msg_id",
//			self.content, @"content",
//			nil];
//}
//- (NSInteger)_parseJSON:(NSDictionary *)result
//{
//	return KYResultCodeSuccess;
//}
//@end
//
//
//@implementation SNSGetterComment
//@synthesize snsGetterType;
//@synthesize tokenKey, tokenSecret;
//@synthesize msgID;
//@synthesize content;
//- (void)dealloc
//{
//	[tokenKey release];
//	[tokenSecret release];
//	[msgID release];
//	[content release];
//	[super dealloc];
//}
//- (NSString *)apiHost
//{
//	return [Context sharedContext].config.apiHostUser;
//}
//- (NSDictionary *)params
//{
//	NSString *typeStr = [NSString stringWithFormat:@"%d",self.snsGetterType];
//	
//	LoginUserInfo* linfo = [Context sharedContext].loginInfo;
//	if(self.snsGetterType == SNSGetterTypeSinaWeibo)
//	{
//		self.tokenKey = linfo.sinaWeiboToken;
//		self.tokenSecret = linfo.sinaWeiboTokenSecret;
//	}
//	if(self.snsGetterType == SNSGetterTypeQWeibo)
//	{
//		self.tokenKey = linfo.tencentWeiboToken;
//		self.tokenSecret = linfo.tencentWeiboTokenSecret;
//	}
//	if(!self.tokenKey || self.tokenKey.length <= 0)
//		return nil;
//	if(!self.tokenSecret || self.tokenSecret.length <= 0)
//		return nil;
//	
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"userWeibo", @"Action",
//			@"comment_msg", @"cmd",
//			typeStr, @"weibo_type",
//			self.tokenKey, @"weibo_token",
//			self.tokenSecret, @"weibo_tokenSecret",
//			self.msgID, @"msg_id",
//			self.content, @"comment",
//			nil];
//}
//- (NSInteger)_parseJSON:(NSDictionary *)result
//{
//	return KYResultCodeSuccess;
//}
//@end
//
//
//
//@implementation SNSGetterCheckShortUrls
//
//@synthesize shortUrl, resourceInfo;
//
//-(void) dealloc
//{
//	self.shortUrl = nil;
//	self.resourceInfo = nil;
//	[super dealloc];
//}
//
//-(NSString*) apiHost
//{
//	return [Context sharedContext].config.apiHostUser;
//}
//
//-(NSDictionary*) params
//{
//	if (self.shortUrl.length <= 0)
//		return nil;
//	return [NSDictionary dictionaryWithObjectsAndKeys:@"userWeibo", @"Action", @"get_res_by_surl", @"cmd", self.shortUrl, @"short_url", nil];
//}
//
//-(NSInteger) _parseJSON:(NSDictionary *)result
//{
//	NSDictionary* dic = [result objectForKey:@"res_info"];
//	FeedInfoForShortUrl* info = [[FeedInfoForShortUrl alloc] init];
//	info.feedId = [dic objectForKey:@"res_id"];
//	info.title = [dic objectForKey:@"title"];
//	info.sourceName = [dic objectForKey:@"source_name"];
//	info.imageUrl = [dic objectForKey:@"cover"];
//	info.time = [(NSString*)[dic objectForKey:@"time"] dateFromString:DateFormatYMDHMS];
//	info.commentCount = [[dic objectForKey:@"comment_number"] intValue];
//	info.channelId = [dic objectForKey:@"channel_id"];
//	info.resourceType = [[dic objectForKey:@"resType"] intValue];
//	self.resourceInfo = info;
//	[info release];
//	return KYResultCodeSuccess;
//}
//
//@end
//
//
//
//@implementation SNSGetterGetTweetComments
//@synthesize snsGetterType;
//@synthesize tokenKey, tokenSecret;
//@synthesize sinaWeiboPage;
//@synthesize tweetId, commentList;
//@synthesize qWeiboLastTime, qWeiboPageFlag;
//-(id) init
//{
//	self = [super init];
//	if (self)
//	{
//		self.shouldStoreResult = NO;
//	}
//	return self;
//}
//-(void) dealloc
//{
//	[tokenKey release];
//	[tokenSecret release];
//	[commentList release];
//	[tweetId release];
//	[qWeiboLastTime release];
//	[qWeiboPageFlag release];
//	[super dealloc];
//}
//-(NSString*) apiHost
//{
//	return [Context sharedContext].config.apiHostUser;
//}
//-(NSDictionary*) params
//{
//	NSString *typeStr = [NSString stringWithFormat:@"%d",self.snsGetterType];
//	
//	if(self.snsGetterType == SNSGetterTypeQWeibo)
//		self.sinaWeiboPage = -100;
//	if(self.snsGetterType == SNSGetterTypeSinaWeibo)
//	{
//		self.qWeiboLastTime = @"-100";
//		self.qWeiboPageFlag = @"-100";
//	}
//	
//	LoginUserInfo* linfo = [Context sharedContext].loginInfo;
//	if(self.snsGetterType == SNSGetterTypeSinaWeibo)
//	{
//		self.tokenKey = linfo.sinaWeiboToken;
//		self.tokenSecret = linfo.sinaWeiboTokenSecret;
//	}
//	if(self.snsGetterType == SNSGetterTypeQWeibo)
//	{
//		self.tokenKey = linfo.tencentWeiboToken;
//		self.tokenSecret = linfo.tencentWeiboTokenSecret;
//	}
//	if(!self.tokenKey || self.tokenKey.length <= 0)
//		return nil;
//	if(!self.tokenSecret || self.tokenSecret.length <= 0)
//		return nil;
//	if (self.tweetId.length <= 0)
//		return nil;
//	NSString *pageStr = [NSString stringWithFormat:@"%d",self.sinaWeiboPage];
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"userWeibo", @"Action",
//			@"get_comment_list", @"cmd",
//			typeStr, @"weibo_type",
//			self.tokenKey, @"weibo_token",
//			self.tokenSecret, @"weibo_tokenSecret",
//			pageStr, @"page",
//			self.qWeiboLastTime, @"pagetime",
//			self.qWeiboPageFlag, @"pageflag",
//			self.tweetId, @"msg_id",
//			nil];
//}
//-(NSInteger) _parseJSON:(NSDictionary*)result
//{
//	NSArray *tmpResultArr = [result objectForKey:@"comment_list"];
//	NSMutableArray *arr = [NSMutableArray array];
//	for(NSInteger i = 0; i < tmpResultArr.count; ++i)
//	{
//		NSDictionary* tmpDic = [tmpResultArr objectAtIndex:i];
//		WeiboTweetComment* comment = [[WeiboTweetComment alloc] init];
//		comment.commentId = [tmpDic objectForKey:@"id"];
//		comment.content = [tmpDic objectForKey:@"text"];
//		comment.userName = [tmpDic objectForKey:@"user_name"];
//		comment.userId = [tmpDic objectForKey:@"user_id"];
//		comment.tweetTimeStamp = [tmpDic objectForKey:@"timestamp"];
//		comment.time = [(NSString*)[tmpDic objectForKey:@"time"] dateFromString:DateFormatYMDHMS];
//		[arr addObject:comment];
//		[comment release];
//	}
//	self.commentList = arr;
//	
//	if(self.snsGetterType == SNSGetterTypeQWeibo)
//		self.qWeiboLastTime = ((WeiboTweetComment*)[arr lastObject]).tweetTimeStamp;
//	else
//		self.qWeiboLastTime = @"a000";
//	
//	return KYResultCodeSuccess;
//}
//@end
//
//
//
//#pragma mark - 酷云社交部分
//@implementation KYSNSGetterGetPersonalTimeline
//@synthesize targetUserID;
//@synthesize page;
//@synthesize feedList;
//-(id) init
//{
//	self = [super init];
//	if (self)
//	{
//		self.shouldStoreResult = YES;
//	}
//	return self;
//}
//- (void)dealloc
//{
//	[targetUserID release];
//	[super dealloc];
//}
//- (NSString *)apiHost
//{
//	return [Context sharedContext].config.apiHostFeed;
//}
//- (NSDictionary *)params
//{
//	NSString *pageStr = [NSString stringWithFormat:@"%d",self.page];
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"feed", @"Action",
//			@"getPersonFeed", @"cmd",
//			self.targetUserID, @"target_user_id",
//			pageStr, @"page",
//			nil];
//}
//- (NSInteger)_parseJSON:(NSDictionary *)result
//{
//	NSArray *resultFeedList = [[result objectForKey:@"feed_list"] copy];
//	NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
//	for(NSDictionary *dic in resultFeedList)
//	{
//		KYDongtaiInfo *dongtaiInfo = [[KYDongtaiInfo alloc] initWithDictionary:dic];
//		[tmpArr addObject:dongtaiInfo];
//		[dongtaiInfo release];
//		
//	}
//	self.feedList = tmpArr;
//	[tmpArr release];
//	[resultFeedList release];
//	return KYResultCodeSuccess;
//}
//@end
//
//@implementation KYSNSGetterGetCommonTimeline
//@synthesize page;
//@synthesize feedList;
//-(id) init
//{
//	self = [super init];
//	if (self)
//	{
//		self.shouldStoreResult = YES;
//	}
//	return self;
//}
//- (void)dealloc
//{
//	[feedList release];
//	[super dealloc];
//}
//- (NSString *)apiHost
//{
//	return [Context sharedContext].config.apiHostFeed;
//}
//- (NSDictionary *)params
//{
//	NSString *pageStr = [NSString stringWithFormat:@"%d",self.page];
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"feed", @"Action",
//			@"getFriendFeed", @"cmd",
//			pageStr, @"page",
//			nil];
//}
//- (NSInteger)_parseJSON:(NSDictionary *)result
//{
//	NSArray *resultFeedList = [[result objectForKey:@"feed_list"] copy];
//	NSMutableArray *tmpArr = [NSMutableArray array];
//	for(NSDictionary *dic in resultFeedList)
//	{
//		KYDongtaiInfo *dongtaiInfo = [[KYDongtaiInfo alloc] initWithDictionary:dic];
//		[tmpArr addObject:dongtaiInfo];
//		[dongtaiInfo release];
//		
//	}
//	self.feedList = tmpArr;
//	[resultFeedList release];
//	return KYResultCodeSuccess;
//}
//@end
//
//@implementation KYSNSGetterSendDiscussion
//@synthesize ownerID;
////@synthesize feedID, feedTitle;
//@synthesize discusstionType;
//@synthesize dongtaiID;
//@synthesize content;
//- (void)dealloc
//{
//	[ownerID release];
//	//	[feedID release];
//	//	[feedTitle release];
//	[dongtaiID release];
//	[content release];
//	[super dealloc];
//}
//- (NSString *)apiHost
//{
//	return [Context sharedContext].config.apiHostFeed;
//}
//- (NSDictionary *)params
//{
//	if(!ownerID || [ownerID isEqualToString:@""])
//		self.ownerID = @"";
//	if(!dongtaiID || [dongtaiID isEqualToString:@""])
//		self.dongtaiID = @"";
//	if(!content || [content isEqualToString:@""])
//		self.content = @"";
//	NSString *typeStr = [NSString stringWithFormat:@"%d",self.discusstionType];
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"feed", @"Action",
//			@"talk", @"cmd",
//			typeStr, @"action_type",
//			self.ownerID, @"owner_id",
//			//			self.feedID, @"feed_id",
//			//			self.feedTitle, @"feed_title",
//			self.dongtaiID, @"dongtai_id",
//			self.content, @"content",
//			nil];
//}
//- (NSInteger)_parseJSON:(NSDictionary *)result
//{
//	return KYResultCodeSuccess;
//}
//@end
//
//@implementation KYSNSGetterShare
//@synthesize shareType, privacyType;
//@synthesize videoSource;
//@synthesize imageID;
//@synthesize userIDs;
//@synthesize feedID, feedTitle;
//@synthesize actionContent;
//@synthesize channelID;
//@synthesize refer;
//- (void)dealloc
//{
//	[videoSource release];
//	[imageID release];
//	[userIDs release];
//	[feedID release];
//	[feedTitle release];
//	[actionContent release];
//	[channelID release];
//	[super dealloc];
//}
//- (NSString *)apiHost
//{
//	return [Context sharedContext].config.apiHostFeed;
//}
//- (NSDictionary *)params
//{
//	NSString *typeStr = [NSString stringWithFormat:@"%d",self.shareType];
//	NSString *privacyTypeStr = [NSString stringWithFormat:@"%d",self.privacyType];
//	NSMutableString *userIDsString = [NSMutableString string];
//	for(NSString *str in self.userIDs)
//	{
//		[userIDsString appendString:str];
//		[userIDsString appendString:@","];
//	}
//	NSString *referStr = [NSString stringWithFormat:@"%d",self.refer];
//	if(self.videoSource == nil)
//		self.videoSource = @"";
//	if(self.imageID == nil)
//		self.imageID = @"";
//	if(self.feedTitle == nil)
//		self.feedTitle = @"";
//	if(self.feedID == nil)
//		self.feedID = @"";
//	if(self.actionContent == nil)
//		self.actionContent = @"";
//	if(self.channelID == nil)
//		self.channelID = @"";
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"feed", @"Action",
//			@"share", @"cmd",
//			typeStr, @"action_type",
//			self.videoSource, @"video_src",
//			self.imageID, @"feed_image_id",
//			userIDsString, @"user_ids",
//			self.feedTitle, @"feed_title",
//			self.feedID, @"feed_id",
//			self.actionContent, @"action_content",
//			privacyTypeStr, @"privacy",
//			self.channelID, @"channel_id",
//			referStr, @"refer",
//			nil];
//}
//- (NSInteger)_parseJSON:(NSDictionary *)result
//{
//	return KYResultCodeSuccess;
//}
//@end
//
//@implementation KYSNSGetterGetDiscussionList
//@synthesize dongtaiID;
//@synthesize page;
//@synthesize discussionList;
//-(id) init
//{
//	self = [super init];
//	if (self)
//	{
//		self.shouldStoreResult = YES;
//	}
//	return self;
//}
//- (void)dealloc
//{
//	[dongtaiID release];
//	[discussionList release];
//	[super dealloc];
//}
//- (NSString *)apiHost
//{
//	return [Context sharedContext].config.apiHostFeed;
//}
//- (NSDictionary *)params
//{
//	NSString *pageStr = [NSString stringWithFormat:@"%d",self.page];
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"feed", @"Action",
//			@"getTalk", @"cmd",
//			self.dongtaiID, @"dongtai_id",
//			pageStr, @"page",
//			nil];
//}
//- (NSInteger)_parseJSON:(NSDictionary *)result
//{
//	NSArray *arr = [[result objectForKey:@"talk_list"] copy];
//	NSMutableArray *tmpArr = [NSMutableArray array];
//	for(NSDictionary *dic in arr)
//	{
//		KYDongtaiDiscussionInfo *info = [[KYDongtaiDiscussionInfo alloc] initWithDictionary:dic];
//		[tmpArr addObject:info];
//		[info release];
//	}
//	[arr release];
//	discussionList = [[NSArray alloc] initWithArray:tmpArr];
//	return KYResultCodeSuccess;
//}
//@end
//
//
//@implementation KYSNSGetterUploadContact
//@synthesize contacts;
//- (void)dealloc
//{
//	[contacts release];
//	[super dealloc];
//}
//- (NSString *)apiHost
//{
//	return [Context sharedContext].config.apiHostUser;
//}
//- (NSDictionary *)params
//{
//	NSString *jsonStr = [self.contacts JSONRepresentation];
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"user", @"Action",
//			@"upload_contact", @"cmd",
//			jsonStr, @"contacts",
//			@"tenfen", @"test",
//			nil];
//}
//
//@end

@implementation KYFollower
@synthesize weiboType = _weiboType,weiboToken = _weiboToken,weiboTokenSecret = _weiboTokenSecret;
@synthesize isSnsExpire = _isSnsExpire;

-(void)dealloc
{
	[_weiboToken release];
	[_weiboTokenSecret release];
	[super dealloc];
}

-(NSString *)apiHost
{
	return 	[Context sharedContext].config.apiHostUser;
}

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"userWeibo", @"Action",
			@"following", @"cmd",
			[NSString stringWithFormat:@"%d", self.weiboType], @"weibo_type",
			nil];
}

- (BOOL)isFailureProcessed
{
	return YES;
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	NSString *isOutStr = [result objectForKey:@"is_out"];
	self.isSnsExpire = (isOutStr != nil && [isOutStr intValue] == 1) ? YES:NO;
	return KYResultCodeSuccess;
}
@end