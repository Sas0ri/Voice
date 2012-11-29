//
//  KYAPIVerifications.m
//  Kuyun
//
//  Created by Pang Zhenyu on 11-9-21.
//  Copyright 2011年 Tenfen Inc. All rights reserved.
//

#import "KYAPIVerifications.h"
#import "Context.h"




@implementation KYAPIGetClientUpdateInfo

@synthesize hasNewVersion, mustUpdate, updateUrl, updateMessage, updateVersion,rateUrl, whatIsHot, channelFilter;

-(void) dealloc
{
	self.updateUrl = nil;
	self.rateUrl = nil;
	self.updateMessage = nil;
	self.updateVersion = nil;
	self.whatIsHot = nil;
	[super dealloc];
}

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostAdmin;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"clientVerify", @"Action", nil];
}

-(NSInteger) _parseJSON:(NSDictionary*)result
{
	self.updateVersion = [result objectForKey:@"updateVersion"];
	self.updateUrl = [result objectForKey:@"updateURL"];
	self.updateMessage = [result objectForKey:@"updateMessage"];
	self.hasNewVersion = [[result objectForKey:@"newVersion"] isEqualToString:@"1"];
	self.mustUpdate = [[result objectForKey:@""] isEqualToString:@"1"];
	self.rateUrl = [result objectForKey:@"appstoreURL"];
	self.whatIsHot = [result objectForKey:@"hot_words"];
	self.channelFilter = [[result objectForKey:@"ipad"] boolValue];
	self.newlyOnSale = [[result objectForKey:@"score_new"] boolValue];
	self.mallUlr = [result objectForKey:@"score_path"];
	return KYResultCodeSuccess;
}

@end




@implementation KYAPILogin

@synthesize account, password, loginInfo;

-(void) dealloc
{
	[loginInfo release];
	[account release];
	[password release];
	[super dealloc];
}

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary*) params
{
	if (account.length <= 0 || password.length <= 0)
		return nil;
	return [NSDictionary dictionaryWithObjectsAndKeys:@"user", @"Action", account, @"account", password, @"password", @"login", @"cmd", nil];
}

-(NSInteger) _parseJSON:(NSDictionary*)result
{
	LoginUserInfo* lInfo = [[LoginUserInfo alloc] init];
	lInfo.userId = [result objectForKey:@"user_id"];
	lInfo.userName = [result objectForKey:@"nick_name"];
	lInfo.sinaWeiboToken = [result objectForKey:@"sweibo_token"];
	lInfo.sinaWeiboTokenSecret = [result objectForKey:@"sweibo_token_secret"];
	lInfo.tencentWeiboToken = [result objectForKey:@"qweibo_token"];
	lInfo.tencentWeiboTokenSecret = [result objectForKey:@"qweibo_token_secret"];
	lInfo.hasSetUserInfo = [(NSString*)[result objectForKey:@"is_saved_info"] isEqualToString:@"1"];
	self.loginInfo = lInfo;
	[lInfo release];
	return KYResultCodeSuccess;
}

@end



@implementation KYAPIEmailRegister

@synthesize email, password, userId;

-(void) dealloc
{
	[email release];
	[password release];
	[userId release];
	[super dealloc];
}

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary*) params
{
	if (email.length <= 0 || password.length <= 0)
		return nil;
	return [NSDictionary dictionaryWithObjectsAndKeys:@"user", @"Action", email, @"email", password, @"password", @"email", @"register_type", @"register", @"cmd", nil];
}

-(NSInteger) _parseJSON:(NSDictionary*)result
{
	self.userId = [result objectForKey:@"user_id"];
	return KYResultCodeSuccess;
}

@end



@implementation KYAPIPhoneRegister

@synthesize phone, password, verifyCode, userId;

-(void) dealloc
{
	[phone release];
	[password release];
	[verifyCode release];
	[userId release];
	[super dealloc];
}

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary*) params
{
	if (phone.length <= 0 || password.length <= 0)
		return nil;
		return [NSDictionary dictionaryWithObjectsAndKeys:@"user", @"Action", self.phone, @"phone", password, @"password", @"phone", @"register_type", @"register", @"cmd", self.verifyCode, @"verify_code", nil];
}

-(NSInteger) _parseJSON:(NSDictionary*)result
{
	self.userId = [result objectForKey:@"user_id"];
	return KYResultCodeSuccess;
}

@end



@implementation KYAPIVerifyPhone

@synthesize phone;

-(void) dealloc
{
	[phone release];
	[super dealloc];
}

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary*) params
{
	if (phone.length <= 0)
		return nil;
	return [NSDictionary dictionaryWithObjectsAndKeys:@"user", @"Action", phone, @"phone", @"verify_code", @"cmd", nil];
}

@end



@implementation KYAPIFinishTutorial

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary*) params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"user", @"Action", @"read_new_required", @"cmd", nil];
}

@end



@implementation KYAPISNSLogin

@synthesize weiboType;
@synthesize tokenKey, tokenSecret;
@synthesize loginInfo;
@synthesize oauthId;

-(void) dealloc
{
	self.loginInfo = nil;
	[tokenKey release];
	[tokenSecret release];
	[oauthId release];
	[super dealloc];
}

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary*) params
{
//	if (self.tokenKey.length <= 0)
//		return nil;
//	if(self.tokenSecret.length <= 0)
//		return nil;
	
	NSString *typeStr = [NSString stringWithFormat:@"%d", self.weiboType];
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"user", @"Action", 
			@"login_weibo", @"cmd",
			KYStringIsNullToEmpty(self.tokenKey), @"weibo_token",
			KYStringIsNullToEmpty(self.oauthId), @"oauth_id",
			KYStringIsNullToEmpty(self.tokenSecret),@"weibo_tokenSecret",
			typeStr, @"weibo_type",
			nil];
}

- (int)_parseJSON:(NSDictionary *)result
{
	LoginUserInfo* lInfo = [[LoginUserInfo alloc] init];
	lInfo.userId = [result objectForKey:@"user_id"];
	lInfo.userName = [result objectForKey:@"nick_name"];
    
    lInfo.hasSelectedChannel = [[NSString stringWithFormat:@"%@",[result objectForKey:@"is_selected_channel"]] isEqualToString:@"1"];
    lInfo.hasReadNewRequired = [[NSString stringWithFormat:@"%@",[result objectForKey:@"is_read_new_required"]] isEqualToString:@"1"];
    lInfo.isFirstRegister = [[NSString stringWithFormat:@"%@",[result objectForKey:@"first_register"]] isEqualToString:@"1"];
    lInfo.hasSetUserInfo = [(NSString*)[result objectForKey:@"is_saved_info"] isEqualToString:@"1"];

    lInfo.hasBindedSinaWeibo = [[NSString stringWithFormat:@"%@",[result objectForKey:@"is_sweibo_check"]] isEqualToString:@"1"];
	lInfo.hasBindedQZone = [(NSString*)[result objectForKey:@"is_qzweibo_check"] isEqualToString:@"1"];

	lInfo.sinaWeiboToken = [result objectForKey:@"sweibo_token"];
	lInfo.sinaWeiboTokenSecret = [result objectForKey:@"sweibo_token_secret"];
    lInfo.hasBindedTencentWeibo = [[NSString stringWithFormat:@"%@",[result objectForKey:@"is_qweibo_check"]] isEqualToString:@"1"];
	lInfo.tencentWeiboToken = [result objectForKey:@"qweibo_token"];
	lInfo.tencentWeiboTokenSecret = [result objectForKey:@"qweibo_token_secret"];
	lInfo.qqToken = [result objectForKey:@"qzweibo_token"];
	lInfo.qqTokenSecret = [result objectForKey:@"qzweibo_token_secret"];

	self.loginInfo = lInfo;
	[lInfo release];
	return KYResultCodeSuccess;
}

@end


@implementation KYAPISNSBind

@synthesize bindType;
@synthesize tokenKey,tokenSecret,weiboType;
@synthesize hasBindWeibo;
@synthesize oauthId;
- (id)initWithBindType:(KYSNSBindType)type
{
    if (self = [super init]) {
        bindType = type;
    }
    return self;
}

-(void) dealloc
{
	[tokenKey release];
	[tokenSecret release];
	[oauthId release];
	[super dealloc];
}

-(NSString*) apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary*) params
{
//	if (self.tokenKey.length <= 0)
//		return nil;
    //	if(self.tokenSecret.length <= 0)
    //		return nil;
    NSDictionary *dict = nil;
    NSString *typeStr = [NSString stringWithFormat:@"%d", self.weiboType];

    switch (bindType) {
        case KYSNSBindTypeIsBinded:
            dict = [NSDictionary dictionaryWithObjectsAndKeys:
                    @"userWeibo", @"Action", 
                    @"is_weibo_check", @"cmd",
                    typeStr, @"weibo_type",
                    nil];
            break;
        case KYSNSBindTypeBindWeibo:
            dict = [NSDictionary dictionaryWithObjectsAndKeys:
             @"userWeibo", @"Action", 
             @"weibo_check", @"cmd",
			 KYStringIsNullToEmpty(self.tokenKey), @"weibo_token",
			 KYStringIsNullToEmpty(self.oauthId), @"oauth_id",
			 KYStringIsNullToEmpty(self.tokenSecret),@"weibo_tokenSecret",
             typeStr, @"weibo_type",
                    nil];
            break;
        case KYSNSBindTypeGetToken:
            dict = [NSDictionary dictionaryWithObjectsAndKeys:
                    @"userWeibo", @"Action", 
                    @"get_weibo_info", @"cmd",
                    typeStr, @"weibo_type",
                    nil];
            break;
        case KYSNSBindTypeCancelBinded:
            dict = [NSDictionary dictionaryWithObjectsAndKeys:
                    @"userWeibo", @"Action", 
                    @"delete_weibo", @"cmd",
                    typeStr, @"weibo_type",
                    nil];
            break;
            
        default:
            break;
    }
	
	return dict;
}

- (int)_parseJSON:(NSDictionary *)result
{
    self.hasBindWeibo = [[NSString stringWithFormat:@"%@",[result objectForKey:@"is_sweibo_check"]] isEqualToString:@"1"];
    
	return KYResultCodeSuccess;
}

@end

@implementation KYUpdateDeviceToken
@synthesize deviceToken = _deviceToken;

-(void)dealloc
{
	[_deviceToken release];
	[super dealloc];
}

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"user",@"Action",@"device_token",@"cmd",_deviceToken,@"device_token", nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	return KYResultCodeSuccess;
}
@end

@implementation SNSCheckExpireGetter

@synthesize isSinaExpire,isQQExpire,isQzExpire;

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"userWeiboOauth",@"Action", nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	NSString* sinaStr = [result objectForKey:@"sina_out"];
	self.isSinaExpire = sinaStr != nil && sinaStr.intValue == 1;
	NSString* qqStr = [result objectForKey:@"qq_out"];
	self.isQQExpire = qqStr != nil && qqStr.intValue == 1;
	NSString* qzStr = [result objectForKey:@"qzone_out"];
	self.isQzExpire = qzStr != nil && qzStr.intValue == 1;
	return KYResultCodeSuccess;
}

@end
