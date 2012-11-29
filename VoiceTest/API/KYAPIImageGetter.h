//
//  KYAPIImageGetter.h
//  Kuyun
//
//  Created by Pang Zhenyu on 11-9-22.
//  Copyright 2011年 Tenfen Inc. All rights reserved.
//

#import "HttpGetter.h"



@interface KYAPIImageGetter : HttpGetter
{
	NSString* _imageId;
	NSString* _referUrl;
	UIImage* _image;
	NSInteger _width;
	BOOL _useImageGateway;
	CGSize _imageSize;
}

@property (nonatomic, copy) NSString* imageId;
@property (nonatomic, copy) NSString* referUrl;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, retain) UIImage* image;
@property (nonatomic, assign) BOOL useImageGateway;
@property (nonatomic, assign) CGSize imageSize;

@end
