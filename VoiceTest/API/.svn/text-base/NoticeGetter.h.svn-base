//
//  NoticeGetter.h
//  KuyunTV
//
//  Created by CaoQuan on 12-5-29.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "KYAPIGetter.h"

@interface NoticeGetter : KYAPIGetter
@property (nonatomic, copy) NSString* clientStatus;//0正常，1待机
@property (nonatomic, strong) NSString* lastNoticeId;
@property (nonatomic, strong) NSString* columnId;
@property (nonatomic, strong) NSArray* noticeArr;
@property (nonatomic, strong) NSString* columnActivityId;
@property (nonatomic, assign) NSInteger columnActivityStatus;
@property (nonatomic, assign) BOOL autoEnter;
@property (nonatomic, strong) NSString* activityHost;
@property (nonatomic, assign) NSInteger interval;
@property (nonatomic, assign) NSInteger unreadCount;
@property (nonatomic, strong) NSString* recColumns;
@end

@interface NotificationGetter : KYAPIGetter
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSArray* notificationList;
@end

@interface ActivityGetter : KYAPIGetter
@property (nonatomic, copy) NSString* activityId;
@property (nonatomic, assign) BOOL playSound;

@end