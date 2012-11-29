//
//  SettingsGetter.m
//  Kuyun
//
//  Created by Sun Yuan on 11-11-16.
//  Copyright (c) 2011年 Tenfen Inc. All rights reserved.
//

#import "SettingsGetter.h"
#import "Context.h"
#import "ProgramInfoData.h"

@implementation SendFeedbackGetter
@synthesize content;
- (void)dealloc
{
    [content release];
    [super dealloc];
}
- (NSString *)apiHost
{
    return [Context sharedContext].config.apiHostUser;
}
- (NSDictionary *)params
{
    if(self.content == nil || self.content.length <= 0)
        return nil;
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"userAdvice", @"Action",
            self.content, @"content",
            nil];
}

@end

@implementation MoreAppsGetter
@synthesize appInfo = _appInfo;
-(void)dealloc
{	
	[_appInfo release];
	[super dealloc];
}

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"partnerApp",@"Action", nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	NSArray* temp = (NSArray*)[result objectForKey:@"app_list"];
	NSMutableArray* feeds = [[NSMutableArray alloc] initWithCapacity:0];
	for (NSDictionary* dic in temp)
	{
		MoreAppsFeed* feed = [[MoreAppsFeed alloc] init];
		feed.appName = [dic objectForKey:@"name"];
		feed.icon.imageId = [dic objectForKey:@"appLogo"];
		feed.appDescrip = [dic objectForKey:@"description"];
		feed.downloadUrl = [dic objectForKey:@"appstoreURL"];
		[feeds addObject:feed];
		[feed release];
	}
	_appInfo = [[NSArray alloc] initWithArray:feeds];
	[feeds release];
	return KYResultCodeSuccess;
}

@end

@implementation MoreAppsFeed

@synthesize icon = _icon, appName = _appName, appDescrip = _appDescrip, downloadUrl = _downloadUrl;

-(void)dealloc
{
	[_icon release];
	[_appName release];
	[_appDescrip release];
	[_downloadUrl release];
	[super dealloc];
}

-(KYAPIImageGetter *)icon
{
	if (!_icon)
		_icon = [[KYAPIImageGetter alloc] init];
	return _icon;
}

@end

@implementation FavGetter
@synthesize favList,lastFavId;

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"userFav",@"Action",@"get",@"cmd",self.lastFavId ? [NSString stringWithFormat:@"%d",self.lastFavId] : nil,@"user_fav_id", nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	self.favList = [result objectForKey:@"fav_list"];
	NSMutableArray* arr = [NSMutableArray arrayWithCapacity:0];
	for (NSDictionary* dic in self.favList)
	{
		ProgramMsgInfo* mi = [[[ProgramMsgInfo alloc] initWithDic:dic] autorelease];
		[arr addObject:mi];
	}
	self.favList = arr;
	return KYResultCodeSuccess;
}

-(void)dealloc
{
	self.favList = nil;
	[super dealloc];
}

@end

@implementation SettingsGetter

@synthesize allowNotification;

-(NSString *)apiHost
{
	return [Context sharedContext].config.apiHostUser;
}

-(NSDictionary *)params
{
	return [NSDictionary dictionaryWithObjectsAndKeys:@"userSetting",@"Action",@"update",@"cmd",[NSString stringWithFormat:@"1_%@",self.allowNotification?@"1":@"0"],@"setting", nil];
}

-(NSInteger)_parseJSON:(NSDictionary *)result
{
	return KYResultCodeSuccess;
}

@end