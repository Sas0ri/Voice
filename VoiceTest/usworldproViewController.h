//
//  usworldproViewController.h
//  usworldpro
//
//  Created by 石  on 12-7-24.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import "SCListener.h"

@interface usworldproViewController : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate> {
@private
	
    AVAudioPlayer *_player;//播放器
	
	
    NSURL *_recorderTmpFile; //录音的临时文件路径
	NSString *audioPath;
	NSString* mp3AudioPath;
	AVAudioRecorder *_recorder;      //use record
	
	//用来检测的布尔值
    BOOL isRecording;
	BOOL isPlaying;
	BOOL ISRECORDED;
	
	NSInteger _lowTimes;
	NSInteger _playTimes;
	
    AVAudioSession *_audioSession;
	
	
	NSURL *inUrl;
	NSURL *outUrl;
	float percent;
	NSTimer *_timer;
}
@property (nonatomic, retain)AVAudioSession *audioSession;

@end

@interface TVInfo : NSObject
@property (nonatomic, copy) NSString* tvId;
@property (nonatomic, copy) NSString* score;
-(id) initWithDic:(NSDictionary*)dic;
@end

