//
//  PersonalInfoGetter.m
//  Kuyun
//
//  Created by Sun Yuan on 11-10-17.
//  Copyright 2011年 Tenfen Inc. All rights reserved.
//

#import "PersonalInfoGetter.h"
#import "Context.h"

@implementation PersonalInfoGetter
@synthesize targetUserID;
@synthesize info;
@synthesize isSinaWeiboChecked, sinaWeiboTokenKey, sinaWeiboTokenSecret;
@synthesize isQWeiboChecked, qWeiboTokenKey, qWeiboTokenSecret;
@synthesize qZoneTokenKey,qZoneTokenSecret;
- (void)dealloc
{
	[targetUserID release];
    [info release];
	[sinaWeiboTokenKey release];
	[sinaWeiboTokenSecret release];
	[qWeiboTokenKey release];
	[qWeiboTokenSecret release];
	[qZoneTokenKey release];
	[qZoneTokenSecret release];
	[super dealloc];
}
- (NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}
- (NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"user", @"Action",
			@"get", @"cmd",
			self.targetUserID, @"target_user_id",
			nil];
}
- (NSInteger)_parseJSON:(NSDictionary *)result
{
	NSDictionary *tmpDic = [result objectForKey:@"info"];
	PersonalInfoData *_info = [[PersonalInfoData alloc] initWithDictionary:tmpDic];
	self.info = _info;
	[_info release];
	
	int sinaWeiboCheckStatus = [[tmpDic objectForKey:@"is_sweibo_check"] intValue];
	self.isSinaWeiboChecked = (sinaWeiboCheckStatus == 1);
	self.sinaWeiboTokenKey = [tmpDic objectForKey:@"sweibo_token"];
	self.sinaWeiboTokenSecret = [tmpDic objectForKey:@"sweibo_token_secret"];
	
	int qWeiboCheckStatus = [[tmpDic objectForKey:@"is_qweibo_check"] intValue];
	self.isQWeiboChecked = (qWeiboCheckStatus == 1);
	self.qWeiboTokenKey = [tmpDic objectForKey:@"qweibo_token"];
	self.qWeiboTokenSecret = [tmpDic objectForKey:@"qweibo_token_secret"];
	
	int qZoneCheckStatus = [[tmpDic objectForKey:@"is_qzweibo_check"] intValue];
	self.isQzoneChecked = (qZoneCheckStatus == 1);
	self.qZoneTokenKey = [tmpDic objectForKey:@"qzweibo_token"];
	self.qZoneTokenSecret = [tmpDic objectForKey:@"qzweibo_token_secret"];
	
	return KYResultCodeSuccess;
}
@end

@implementation PersonalInfoGetterUpdate
@synthesize nickName, autograph, company, school;
@synthesize genderType;
@synthesize birthday, province, city;
@synthesize remark;
@synthesize email,phone;
@synthesize trueName,IDType,IDNumber,deliveryAddress,postcode;
- (void)dealloc
{
	[nickName release];
	[autograph release];
	[company release];
	[school release];
	[birthday release];
	[province release];
	[city release];
	[remark release];
    [email release];
    [phone release];
    [trueName release];
    [IDNumber release];
    [deliveryAddress release];
    [postcode release];
	[super dealloc];
}
//- (id)initWithDictionary:(NSDictionary *)dictionary
//{
//	self = [super init];
//	if(self)
//	{
//		self.nickName = [dictionary objectForKey:@""];
//	}
//	return self;
//}
- (NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}
- (NSDictionary *)params
{
//	if(!nickName || self.nickName.length <= 0)
//		self.nickName = @"";
//	if(!autograph || self.autograph.length <= 0)
//		self.autograph = @"";
//	if(!company || self.company.length <= 0)
//		self.company = @"";
//	if(!school || self.school.length <= 0)
//		self.school = @"";
//	if(!birthday || self.birthday.length <= 0)
//		self.birthday = @"";
//	if(!province || self.province.length <= 0)
//		self.province = @"";
//	if(!city || self.city.length <= 0)
//		self.city = @"";
//	if(!remark || self.remark.length <= 0)
//		self.remark = @"";
    self.nickName = KYStringIsNullToEmpty(self.nickName);
    self.trueName = KYStringIsNullToEmpty(self.trueName);
    self.birthday = KYStringIsNullToEmpty(self.birthday);
    self.province = KYStringIsNullToEmpty(self.province);
    self.city = KYStringIsNullToEmpty(self.city);
    self.IDNumber = KYStringIsNullToEmpty(self.IDNumber);
    self.deliveryAddress = KYStringIsNullToEmpty(self.deliveryAddress);
    self.postcode = KYStringIsNullToEmpty(self.postcode);

	if(!genderType)
		self.genderType = GenderTypeUnknown;
	
	NSString *genderStr = [NSString stringWithFormat:@"%d",self.genderType];
    NSString *IDTypeStr = [NSString stringWithFormat:@"%d",self.IDType];
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"user", @"Action",
			@"upd", @"cmd",
			self.nickName, @"nick_name",
            self.trueName,@"real_name",
            genderStr, @"sex",
            self.birthday, @"birthday",
			self.province, @"province",
			self.city, @"city",
			IDTypeStr, @"card_type",
			self.IDNumber, @"card_number",
			self.deliveryAddress, @"address",
			self.postcode, @"postalcode",
            self.email,@"email",
            
			nil];
}
- (NSInteger)_parseJSON:(NSDictionary *)result
{
	return KYResultCodeSuccess;
}
@end

@implementation PersonalInfoGetterChangePassword
@synthesize theNewPsw, oldPsw;
- (void)dealloc
{
	[theNewPsw release];
	[oldPsw release];
	[super dealloc];
}
- (NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}
- (NSDictionary *)params
{
	if (self.theNewPsw.length <= 0)
		return nil;
	if (self.oldPsw == nil)
		self.oldPsw = @"";
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"user", @"Action",
			@"change_pwd", @"cmd",
			self.oldPsw, @"password",
			self.theNewPsw, @"new_password",
			nil];
}
- (NSInteger)_parseJSON:(NSDictionary *)result
{
	return KYResultCodeSuccess;
}

@end

#define kBoundary @"KCuQJmvbcAU9lGs05FU0N9uX7u5Pmo6N"
@interface PersonalInfoGetterUpdateHeadImage ()
-(NSData *)multipartBody;
@end
@implementation PersonalInfoGetterUpdateHeadImage
@synthesize image = _image;
- (void)dealloc
{
	[_image release];
	[super dealloc];
}

-(NSURLRequest*) _createRequest:(KYHttpCachePolicy)cachePolicy
{
	
	if (_image == nil)
		return nil;
	
	Config *config = [Context sharedContext].config;
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?Action=user&test=tenfen&user_id=%@", 
									   config.apiHostUser,
									   [Context sharedContext].userId]];
	
	NSData *body = [self multipartBody];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
														   cachePolicy:NSURLRequestReloadIgnoringCacheData
													   timeoutInterval:config.networkTimeout];
	
	
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:body];
	[request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", kBoundary] forHTTPHeaderField:@"Content-Type"];
	[request setValue:[Context sharedContext].userId forHTTPHeaderField:@"user_id"];
	return request;
}

- (NSInteger)_fillModelWithData:(NSData *)data
{
	return KYResultCodeSuccess;
}

-(NSData *)multipartBody
{
	NSMutableData *body = [NSMutableData data];
	NSData *boundary = [[NSString stringWithFormat:@"--%@\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding];
	[body appendData:boundary];
	NSString* formString = @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n";
	
	[body appendData:[[NSString stringWithFormat:formString, @"user_id", [Context sharedContext].userId] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:boundary];
	
	
	[body appendData:[[NSString stringWithFormat:formString, @"Action", @"user"]
					  dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:boundary];
	
	[body appendData:[[NSString stringWithFormat:formString, @"test", @"tenfen"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:boundary];
	
	NSData *imageData = UIImagePNGRepresentation(self.image);//, [Context sharedContext].config.photoCompressionQuality);
	
	
	
//	[body appendData:@""]
	[body appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"image.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Length: %d\r\n", imageData.length] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:imageData];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	return body;
}
@end


@implementation PersonalInfoGetterSetSubAccount
@synthesize subAccount;
- (void)dealloc
{
	[subAccount release];
	[super dealloc];
}
- (NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}
- (NSDictionary *)params
{
	if(!subAccount || self.subAccount.length <= 0)
		return nil;
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"user", @"Action",
			@"set_subAccount", @"cmd",
			self.subAccount, @"sub_account",
			nil];
}
- (NSInteger)_parseJSON:(NSDictionary *)result
{
	return KYResultCodeSuccess;
}

@end


//@implementation PersonalInfoPageGetter
//@synthesize targetUserID;
//@synthesize personalPageInfo;
//-(id) init
//{
//	self = [super init];
//	if (self)
//	{
//		self.shouldStoreResult = YES;
//	}
//	return self;
//}
//- (void)dealloc
//{
//	[targetUserID release];
//	[personalPageInfo release];
//	[super dealloc];
//}
//- (NSString *)apiHost
//{
//	return [Context sharedContext].config.apiHostUser;
//}
//- (NSDictionary *)params
//{
//	if(!targetUserID || self.targetUserID.length <= 0)
//		self.targetUserID = @"";
//	
//	return [NSDictionary dictionaryWithObjectsAndKeys:
//			@"userProfile", @"Action",
//			self.targetUserID, @"target_user_id",
//			nil];
//}
//- (NSInteger)_parseJSON:(NSDictionary *)result
//{
//	PersonalPageInfo *_per = [[PersonalPageInfo alloc] initWithDictionary:result];
//	_per.userID = self.targetUserID;
//	self.personalPageInfo = _per;
//	[_per release];
//	return KYResultCodeSuccess;
//}
//@end

@implementation PersonalInfoPhoneBundle
@synthesize phone, verifyCode;
- (void)dealloc
{
	[phone release];
	[verifyCode release];
	[super dealloc];
}
- (NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}
- (NSDictionary *)params
{
	if(!self.phone && self.phone.length <= 0)
		return nil;
	if(!self.verifyCode && self.verifyCode.length <= 0)
		return nil;
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"user", @"Action",
			@"mobile_check", @"cmd",
			self.phone, @"mobile",
			self.verifyCode, @"verify_code",
			nil];
}
- (NSInteger)_parseJSON:(NSDictionary *)result
{
	return KYResultCodeSuccess;
}
@end

@implementation PersonalInfoEmailBundle
@synthesize email;
- (void)dealloc
{
	[email release];
	[super dealloc];
}

- (NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

- (NSDictionary *)params
{
	if(!self.email || self.email.length <= 0)
		return nil;
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"user", @"Action",
			@"email_check", @"cmd",
			self.email, @"email",
			nil];
}

- (NSInteger)_parseJSON:(NSDictionary *)result
{
	return KYResultCodeSuccess;
}
@end

@implementation PersonalInfoWeiboBundle
@synthesize weiboType;
@synthesize tokenKey, tokenSecret;
- (void)dealloc
{
	[tokenKey release];
	[tokenSecret release];
	[super dealloc];
}
- (NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}
- (NSDictionary *)params
{
	if(!self.tokenKey && self.tokenKey.length <= 0)
		return nil;
	if(!self.tokenSecret && self.tokenSecret.length <= 0)
		return nil;
	NSString *weiboTypeStr = [NSString stringWithFormat:@"%d",self.weiboType];
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"userWeibo", @"Action",
			@"weibo_check", @"cmd",
			weiboTypeStr, @"weibo_type",
			self.tokenKey, @"weibo_token",
			self.tokenSecret, @"weibo_tokenSecret",
			nil];
}
@end



@implementation PersonalInfoWeiboLogout
@synthesize weiboType;
- (NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}
- (NSDictionary *)params
{
	NSString *weiboTypeStr = [NSString stringWithFormat:@"%d", self.weiboType];
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"userWeibo", @"Action",
			@"delete_weibo", @"cmd",
			weiboTypeStr, @"weibo_type",
			nil];
}
@end


