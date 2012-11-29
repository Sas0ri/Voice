//
//  KYAPIGetter.h
//  Kuyun
//
//  Created by Pang Zhenyu on 11-9-21.
//  Copyright 2011年 Tenfen Inc. All rights reserved.
//

#import "HttpGetter.h"

#define NILEQUALTOEMPTY(obj) (((obj) == nil) ? @"":(obj))
#define KYLogStorageKey @"__KYLogStorageKey__"
#define KYLogTempStorageKey @"__KYLogTempStorageKey__"

@interface KYAPIGetter : HttpGetter
{
	NSString* _apiVersion;
	NSDate* _timeStamp;
	BOOL _isLogCarrier;
}

@property (nonatomic, copy) NSString* apiVersion;
@property (nonatomic, copy) NSDate* timeStamp;

@property (readonly) NSDictionary* params;
@property (readonly) NSString* apiHost;
@property (nonatomic, assign) BOOL shouldCarryLog;
@property (readonly) BOOL isFailureProcessed;
-(NSInteger) _parseJSON:(NSDictionary*)result;

@end
