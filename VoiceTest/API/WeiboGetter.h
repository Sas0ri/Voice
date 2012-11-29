//
//  WeiboGetter.h
//  KuyunTV
//
//  Created by Sasori on 12-5-25.
//  Copyright (c) 2012年 tenfen Inc. All rights reserved.
//

#import "KYAPIGetter.h"
#import "WeiboInfoData.h"

@interface WeiboGetter : KYAPIGetter
@property (nonatomic, copy) NSString* weiboType;
@property (nonatomic, copy) NSString* weiboName;
@property (nonatomic, copy) NSString* weiboId;
@property (nonatomic, strong) WeiboInfoData* weiboData;
@end
