//
//  SNSGetter.h
//  Kuyun
//
//  Created by sunyuan on 11-10-10.
//  Copyright 2011年 Tenfen Inc. All rights reserved.
//

typedef enum _SNSGetterType
{
	SNSGetterTypeSinaWeibo = 1,
	SNSGetterTypeQWeibo,
	SNSGetterTypeRenren,
	SNSGetterTypeQZone = 5,
}SNSGetterType;


#import <Foundation/Foundation.h>
#import "KYAPIGetter.h"
//#import "FavoritesGetter.h"
//#import "FavoritesData.h"

#pragma mark - 微博相关接口
//------------------------------------------------------------------------------------------------
//@interface SNSGetterGetSelfTimeline : KYAPIGetter 
//@property (nonatomic, assign) SNSGetterType snsGetterType;
//@property (nonatomic, copy) NSString *tokenKey;
//@property (nonatomic, copy) NSString *tokenSecret;
////QWeibo Only
//@property (nonatomic, copy) NSString *qWeiboLastTime;
//@property (nonatomic, copy) NSString *qWeiboPageFlag;
////sina weibo only
//@property (nonatomic, copy) NSString* sinaWeiboMaxId;
////return msg
//@property (nonatomic, copy) NSArray *msgList;
//@end
//
//
//@interface SNSGetterGetSelfFriends : KYAPIGetter 
//@property (nonatomic, assign) SNSGetterType snsGetterType;
//@property (nonatomic, copy) NSString *tokenKey;
//@property (nonatomic, copy) NSString *tokenSecret;
////QWeibo only
//@property (nonatomic, assign) int qWeiboPage;
//@property (nonatomic, assign) int qWeiboPageSize;
////sina weibo only
//@property (nonatomic, assign) int sinaWeiboPage;
////result
//@property (nonatomic, copy) NSArray *friendList;
//@property (readonly) int sinaWeiboCursor;
//@end
//
//
//@interface SNSGetterTwitte : KYAPIGetter 
//@property (nonatomic, assign) SNSGetterType snsGetterType;
//@property (nonatomic, copy) NSString *tokenKey;
//@property (nonatomic, copy) NSString *tokenSecret;
//@property (nonatomic, copy) NSString *feedID;
//@property (nonatomic, copy) NSString *feedContent;
//@property (nonatomic, copy) NSString *imageUrl;
//@end
//
//@interface SNSGetterMsgForward : KYAPIGetter
//@property (nonatomic, assign) SNSGetterType snsGetterType;
//@property (nonatomic, copy) NSString *tokenKey;
//@property (nonatomic, copy) NSString *tokenSecret;
//@property (nonatomic, copy) NSString *msgID;
//@property (nonatomic, copy) NSString *content;
//@end
//
//@interface SNSGetterComment : KYAPIGetter
//@property (nonatomic, assign) SNSGetterType snsGetterType;
//@property (nonatomic, copy) NSString *tokenKey;
//@property (nonatomic, copy) NSString *tokenSecret;
//@property (nonatomic, copy) NSString *msgID;
//@property (nonatomic, copy) NSString *content;
//@end
//
//@class FeedInfoForShortUrl;
//@interface SNSGetterCheckShortUrls : KYAPIGetter
//// Input
//@property (nonatomic, copy) NSString* shortUrl;
//// Output
//@property (nonatomic, retain) FeedInfoForShortUrl* resourceInfo;
//@end
//
//
//@interface SNSGetterGetTweetComments : KYAPIGetter
//@property (nonatomic, assign) SNSGetterType snsGetterType;
//@property (nonatomic, copy) NSString *tokenKey;
//@property (nonatomic, copy) NSString *tokenSecret;
////QWeibo Only
//@property (nonatomic, copy) NSString *qWeiboLastTime;
//@property (nonatomic, copy) NSString *qWeiboPageFlag;
////sina weibo only
//@property (nonatomic, assign) int sinaWeiboPage;
//// Input
//@property (nonatomic, copy) NSString* tweetId;
//// Output
//@property (nonatomic, copy) NSArray *commentList;
//@end
//
////------------------------------------------------------------------------------------------------
//
//#pragma mark - 酷云社交
////------------------------------------------------------------------------------------------------
//typedef enum	
//{
//	DongtaiTypeComment = 1,
//	DongtaiTypeShareArticle,
//	DongtaiTypeShareVideo,
//	DongtaiTypeShareImage,
//	DongtaiTypeShareDuanzi,
//}DongtaiType;
//@interface KYSNSGetterGetPersonalTimeline : KYAPIGetter 
//@property (nonatomic, copy) NSString *targetUserID;
//@property (nonatomic, assign) int page;
//@property (nonatomic, copy) NSArray *feedList;
//@end
//
//@interface KYSNSGetterGetCommonTimeline : KYAPIGetter 
//@property (nonatomic) int page;
////result
//@property (nonatomic, copy) NSArray *feedList;
//@end
//
//typedef enum 
//{
//	DiscusstionTypeNew = 1,
//	DiscusstionTypeReply
//}DiscusstionType;
//@interface KYSNSGetterSendDiscussion : KYAPIGetter
//@property (nonatomic, copy) NSString *ownerID;
////@property (nonatomic, copy) NSString *feedID;
////@property (nonatomic, copy) NSString *feedTitle;
//@property (nonatomic) DiscusstionType discusstionType;
//@property (nonatomic, copy) NSString *dongtaiID;
//@property (nonatomic, copy) NSString *content;
//@end
//
//typedef enum 
//{
//	ShareTypeComment = 1,
//	ShareTypeArticle,
//	ShareTypeVideo,
//	ShareTypeImage,
//	ShareTypeDuanzi
//}ShareType;
//typedef enum 
//{
//	PrivacyTypePrivate = 0,
//	PrivacyTypePublic
//}PrivacyType;
//
//@interface KYSNSGetterShare : KYAPIGetter 
//@property (nonatomic) ShareType shareType;
//@property (nonatomic, copy) NSString *videoSource;
//@property (nonatomic, copy) NSString *imageID;
//@property (nonatomic, copy) NSArray *userIDs;
//@property (nonatomic, copy) NSString *feedTitle;
//@property (nonatomic, copy) NSString *feedID;
//@property (nonatomic) PrivacyType privacyType;
//@property (nonatomic, copy) NSString *actionContent;
//@property (nonatomic, copy) NSString *channelID;
//@property (nonatomic, assign) Refer refer;
//@end
//
//@interface KYSNSGetterGetDiscussionList : KYAPIGetter 
//@property (nonatomic, copy) NSString *dongtaiID;
//@property (nonatomic, assign) int page;
////result
//@property (readonly) NSArray *discussionList;
//@end
//
////上传通讯录
//@interface KYSNSGetterUploadContact : KYAPIGetter 
//@property (nonatomic, copy) NSArray *contacts;
//@end

@interface KYFollower : KYAPIGetter {
	NSInteger _weiboType;
	NSString* _weiboToken;
	NSString* _weiboTokenSecret;
}
@property (nonatomic,assign) NSInteger weiboType;
@property (nonatomic,copy) NSString* weiboToken;
@property (nonatomic,copy) NSString* weiboTokenSecret;
@property (nonatomic, assign) BOOL isSnsExpire;
@end

//------------------------------------------------------------------------------------------------
