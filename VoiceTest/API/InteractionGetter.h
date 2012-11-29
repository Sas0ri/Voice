//
//  InteractionGetter.h
//  CCTV5
//
//  Created by Pang Zhenyu on 12-7-3.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "KYAPIGetter.h"
#import "InteractionData.h"
#import "SocketGetter.h"

@interface InteractionGetter : KYAPIGetter
@property (nonatomic, copy) NSString* activityHost;

// Input
@property (nonatomic, copy) NSString* activityID;
@property (nonatomic, copy) NSString* linkID;
@property (nonatomic, copy) NSString* optionID;
@property (nonatomic, assign) InteractionAct act;

// Output
@property (nonatomic, strong) InteractionData* data;

@end


@interface RuleGetter : KYAPIGetter
@property (nonatomic, copy) NSString* activityID;
@property (nonatomic, strong) NSString* description;
@end


@interface RankingGetter : KYAPIGetter
@property (nonatomic, copy) NSString* activityID;

@property (nonatomic, strong) NSString* activityScore;
@property (nonatomic, strong) NSString* headURL;
@property (nonatomic, strong) NSString* seasonScore;
@property (nonatomic, strong) NSString* rate;
@property (nonatomic, strong) NSArray* topList;			// Instances of TopRankItem
@end



@interface AcitivityShareGetter : KYAPIGetter
@property (nonatomic, copy) NSString* activityID;
@property (nonatomic, copy) NSString* linkID;
@property (nonatomic, copy) NSString* page;
@property (nonatomic, assign) BOOL sinaExpire;
@property (nonatomic, assign) BOOL qqExpire;
@property (nonatomic, assign) BOOL qzExpire;
@end

@interface InteractionSocket : SocketGetter
@property (nonatomic, copy) NSString* activityHost;

// Input
@property (nonatomic, copy) NSString* activityID;
@property (nonatomic, copy) NSString* linkID;
@property (nonatomic, copy) NSString* optionID;
@property (nonatomic, assign) InteractionAct act;

// Output
@property (nonatomic, strong) InteractionData* data;
@end