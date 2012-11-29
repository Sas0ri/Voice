//
//  ProgramGetter.h
//  KuyunTV
//
//  Created by CaoQuan on 12-5-17.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "KYAPIGetter.h"
#import "SNSGetter.h"

@class ProgramPageInfo;
@interface ProgramPageGetter : KYAPIGetter
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* tvColumnId;
@property (nonatomic, copy) NSString* lastInfoFlowTime;
@property (nonatomic, copy) NSString* infoFlowPageType;
@property (nonatomic, copy) NSString* tvId;
@property (nonatomic, copy) NSString* clientStatus;//0正常，1待机
@property (nonatomic, retain) ProgramPageInfo* programInfo;
@end


@interface  RecomendProgramGetter : KYAPIGetter
@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSArray* programArr;
@property (nonatomic, strong) NSDate* lastUpdateDate;
@end

@class ProgramDetailInfo;
@interface ProgramDetailGetter : KYAPIGetter
@property (nonatomic, copy) NSString* programId;
@property (nonatomic, strong) ProgramDetailInfo* detailInfo;

@end


@interface ProgramFocusGetter : KYAPIGetter
@property (nonatomic, copy) NSString* tvColumnId;
@property (nonatomic, assign) BOOL focus;
@end


@interface ProgramOrderGetter : KYAPIGetter
@property (nonatomic, copy) NSString* tvColumnId;
@property (nonatomic, assign) BOOL order;
@end


@interface ProgramShare : KYAPIGetter
@property (nonatomic, copy) NSString *columnId;

@property (nonatomic, assign) BOOL sinaExpire;
@property (nonatomic, assign) BOOL qqExpire;
@property (nonatomic, assign) BOOL qzExpire;
@end

@interface ProgramUserCommentGetter : KYAPIGetter
@property (nonatomic, assign) BOOL toWeibo;
//1:sina  2:qq 3:renren
@property (nonatomic, assign) SNSGetterType snsGetterType;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *columnId;

@property (nonatomic, assign) BOOL sinaExpire;
@property (nonatomic, assign) BOOL qqExpire;
@property (nonatomic, assign) BOOL qzExpire;
@end

@interface TagCollectionGetter : KYAPIGetter
@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, copy) NSString* columnId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString* giftId;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* msgContent;
@property (nonatomic, assign) NSInteger msgId;
@end

@interface TagCollectionDelGetter : KYAPIGetter
@property (nonatomic, copy) NSArray* favIds;	//array of NSString
@end

@interface ProgramCommentGetter : KYAPIGetter
// Input
@property (nonatomic, copy) NSString* columnId;
// Output
@property (nonatomic, copy) NSArray* comments;		// Instances of WeiboFeed
@property (nonatomic, copy) NSString* topic;
@end

@interface ColumnRecognizeGetter : KYAPIGetter
@property (nonatomic, copy) NSString* keyword;
@property (nonatomic, copy) NSString* columnId;
@end

@interface FocusListGetter : KYAPIGetter
@property (nonatomic, strong) NSArray* focusList;
@property (nonatomic, assign) NSUInteger page;
@end

@interface OrderListGetter : KYAPIGetter
@property (nonatomic, strong) NSArray* orderList;
@property (nonatomic, assign) NSUInteger page;
@end
