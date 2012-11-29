//
//  PreloadGetter.h
//  CCTV5
//
//  Created by CaoQuan on 12-7-2.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "KYAPIGetter.h"

@interface PreloadGetter : KYAPIGetter
@property (nonatomic, strong) NSString* activityId;
@property (nonatomic, strong) NSString* templetId;
@property (nonatomic, strong) NSString* zipUrl;
@property (nonatomic, strong) NSString *templetName;
@property (nonatomic, strong) NSString* activityHost;
@property (nonatomic, strong) NSString* activitySocketHost;
@end


@interface KYAPIZipGetter : HttpGetter
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *zipURL;
@property (nonatomic, strong) NSString *localPath;
@end