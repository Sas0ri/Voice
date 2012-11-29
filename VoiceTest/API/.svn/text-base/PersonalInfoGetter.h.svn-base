//
//  PersonalInfoGetter.h
//  Kuyun
//
//  Created by Sun Yuan on 11-10-17.
//  Copyright 2011年 Tenfen Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KYAPIGetter.h"
#import "PersonalInfoData.h"
#import "SNSGetter.h"

@interface PersonalInfoGetter : KYAPIGetter
@property (nonatomic, copy) NSString *targetUserID;
//result
@property (nonatomic, retain) PersonalInfoData *info;
@property (nonatomic, assign) BOOL isSinaWeiboChecked;
@property (nonatomic, copy) NSString *sinaWeiboTokenKey;
@property (nonatomic, copy) NSString *sinaWeiboTokenSecret;
@property (nonatomic, assign) BOOL isQWeiboChecked;
@property (nonatomic, copy) NSString *qWeiboTokenKey;
@property (nonatomic, copy) NSString *qWeiboTokenSecret;
@property (nonatomic, assign) BOOL isQzoneChecked;
@property (nonatomic, copy) NSString* qZoneTokenKey;
@property (nonatomic, copy) NSString* qZoneTokenSecret;
@end

@interface PersonalInfoGetterUpdate : KYAPIGetter 
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *autograph;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, assign) GenderType genderType;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, assign) IdentifyType IDType;
@property (nonatomic, copy) NSString *IDNumber;
@property (nonatomic, copy) NSString *deliveryAddress;
@property (nonatomic, copy) NSString *postcode;
@end

@interface PersonalInfoGetterChangePassword : KYAPIGetter 
@property (nonatomic, copy) NSString *oldPsw;
@property (nonatomic, copy) NSString *theNewPsw;
@end

@interface PersonalInfoGetterUpdateHeadImage : HttpGetter
@property (nonatomic, retain) UIImage *image;

@end

@interface PersonalInfoGetterSetSubAccount : KYAPIGetter 
@property (nonatomic, copy) NSString *subAccount;
@end


//@interface PersonalInfoPageGetter : KYAPIGetter 
//@property (nonatomic, copy) NSString *targetUserID;
//@property (nonatomic, retain) PersonalPageInfo *personalPageInfo;
//@end

//绑定手机
@interface PersonalInfoPhoneBundle : KYAPIGetter
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *verifyCode;
@end

//绑定邮箱
@interface PersonalInfoEmailBundle : KYAPIGetter
@property (nonatomic, copy) NSString *email;
@end

//绑定微博
@interface PersonalInfoWeiboBundle : KYAPIGetter
@property (nonatomic, assign) SNSGetterType weiboType;
@property (nonatomic, copy) NSString *tokenKey;
@property (nonatomic, copy) NSString *tokenSecret;
@end


// 解除绑定微博
@interface PersonalInfoWeiboLogout : KYAPIGetter
@property (nonatomic, assign) SNSGetterType weiboType;
@end

