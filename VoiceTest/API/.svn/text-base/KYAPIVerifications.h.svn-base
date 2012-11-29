//
//  KYAPIVerifications.h
//  Kuyun
//
//  Created by Pang Zhenyu on 11-9-21.
//  Copyright 2011年 Tenfen Inc. All rights reserved.
//

#import "KYAPIGetter.h"
#import "SNSGetter.h"



@interface KYAPIGetClientUpdateInfo : KYAPIGetter

@property (nonatomic, assign) BOOL hasNewVersion;
@property (nonatomic, copy) NSString* updateVersion;
@property (nonatomic, copy) NSString* updateUrl;
@property (nonatomic, assign) BOOL mustUpdate;
@property (nonatomic, copy) NSString* updateMessage;
@property (nonatomic, copy) NSString* rateUrl;
@property (nonatomic, copy) NSString* whatIsHot;
@property (nonatomic, assign) BOOL channelFilter;
@property (nonatomic, assign) BOOL newlyOnSale;
@property (nonatomic, copy) NSString* mallUlr;

@end



// 登录接口
@class LoginUserInfo;
@interface KYAPILogin : KYAPIGetter
{
	// 请求的参数
	NSString* account;
	NSString* password;
	
	// 响应的信息存到这里面
	LoginUserInfo* loginInfo;
}

@property (nonatomic, copy) NSString* account;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, retain) LoginUserInfo* loginInfo;

@end



// 邮箱注册接口
@interface KYAPIEmailRegister : KYAPIGetter
{
	// 请求的参数
	NSString* email;
	NSString* password;
	
	//响应的信息
	NSString* userId;
}

@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, copy) NSString* userId;

@end



// 手机注册接口
@interface KYAPIPhoneRegister : KYAPIGetter
{
	// 请求的参数
	NSString* phone;
	NSString* password;
	NSString* verifyCode;
	
	//响应的信息
	NSString* userId;
}

@property (nonatomic, copy) NSString* phone;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, copy) NSString* verifyCode;
@property (nonatomic, copy) NSString* userId;

@end



// 获取验证码接口
@interface KYAPIVerifyPhone : KYAPIGetter
{
	// 请求参数
	NSString* phone;
}

@property (nonatomic, copy) NSString* phone;

@end



//微博登录接口
@interface KYAPISNSLogin : KYAPIGetter

@property (nonatomic, assign) SNSGetterType weiboType;
@property (nonatomic, copy) NSString *tokenKey;
@property (nonatomic, copy) NSString *tokenSecret;
@property (nonatomic, copy) NSString* oauthId;
//result
@property (nonatomic, retain) LoginUserInfo* loginInfo;

@end



//微博绑定接口
typedef enum {
    KYSNSBindTypeIsBinded,
    KYSNSBindTypeBindWeibo,
    KYSNSBindTypeGetToken,
    KYSNSBindTypeCancelBinded
} KYSNSBindType;

@interface KYAPISNSBind : KYAPIGetter

@property (nonatomic, assign) KYSNSBindType bindType;

@property (nonatomic, assign) SNSGetterType weiboType;
@property (nonatomic, assign) BOOL hasBindWeibo;
@property (nonatomic, copy) NSString *tokenKey;
@property (nonatomic, copy) NSString *tokenSecret;
@property (nonatomic, copy) NSString *oauthId;
//result
- (id)initWithBindType:(KYSNSBindType)type;

@end



//找回密码
@interface KYAPIForgotPassword : KYAPIGetter
@end



// 完成新手必读
@interface KYAPIFinishTutorial : KYAPIGetter
@end


@interface KYUpdateDeviceToken : KYAPIGetter 
{
	NSString* _deviceToken;
}
@property (nonatomic,copy) NSString* deviceToken;
@end

@interface SNSCheckExpireGetter : KYAPIGetter
@property (nonatomic, assign) BOOL isSinaExpire;
@property (nonatomic, assign) BOOL isQQExpire;
@property (nonatomic, assign) BOOL isQzExpire;
@end
