//
//  SettingsGetter.h
//  Kuyun
//
//  Created by Sun Yuan on 11-11-16.
//  Copyright (c) 2011年 Tenfen Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYAPIGetter.h"
#import "KYAPIImageGetter.h"

@interface SendFeedbackGetter : KYAPIGetter
@property (nonatomic, copy) NSString *content;
@end

@interface MoreAppsGetter : KYAPIGetter 
{
	NSArray* _appInfo;
}

@property (nonatomic,retain) NSArray* appInfo;
@end

@interface MoreAppsFeed : NSObject
{
	KYAPIImageGetter* _icon;
	NSString* _appName;
	NSString* _appDescrip;
	NSString* _downloadUrl;
}
@property (readonly) KYAPIImageGetter* icon;
@property (retain) NSString* appName;
@property (retain) NSString* appDescrip;
@property (retain) NSString* downloadUrl;
@end

@interface FavGetter : KYAPIGetter
@property (nonatomic, strong) NSArray* favList;
@property (nonatomic, assign) NSInteger lastFavId;
@end

@interface SettingsGetter : KYAPIGetter
@property (nonatomic, assign) BOOL allowNotification;
@end