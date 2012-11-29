//
//  usworldproViewController.m
//  usworldpro
//
//  Created by 石 on 12-7-24.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "usworldproViewController.h"
#include <stdio.h>
#include <sys/time.h>
#include "lame.h"
#import "JSONKit.h"

typedef enum{
	RecordStatusCanRecord,
	RecordStatusPaused,
	RecordStatusStop,
} RecordStatus;

static NSString* MP3_File_Name = @"audio";
//static NSTimeInterval timeout = 20;
static NSTimeInterval recordInterval = 6;

@interface usworldproViewController ()
- (void)record;
- (void)stopRecord;
- (void)play;
- (BOOL)canRecord;
- (void)updateMeters:(NSTimer *)sender;
- (void) uploadVoice:(NSData*)data;
- (void) convertFromPCM:(NSString*)pcmPath toMP3:(NSString*)mp3Path;
- (void) recordTimerFired:(id)sender;
-(void) startOrStop:(id)sender;
@property (nonatomic, assign) BOOL isUploading;
@property (nonatomic, strong) NSMutableData* rawData;
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, copy) NSMutableString* string;
@property (nonatomic, assign) RecordStatus recordStatus;
@property (nonatomic, assign) NSUInteger fileSuffix;
@property (nonatomic, assign) NSUInteger currentUploadIndex;
@property (nonatomic, copy) NSString* pcmPath;
@property (nonatomic, strong) NSArray* dataSource;
@property (nonatomic, strong) UITableView* table;
@end

@implementation TVInfo
@synthesize tvId,score;

-(id)initWithDic:(NSDictionary*)dic
{
	if (self = [super init]) {
		self.tvId = [dic objectForKey:@"tv_id"];
		self.score = [dic objectForKey:@"score"];
	}
	return self;
}

@end

@implementation usworldproViewController
@synthesize audioSession = _audioSession;

-(void)convertFromPCM:(NSString*)pcmPath toMP3:(NSString*)mp3Path;
{
	NSTimeInterval date = [NSDate timeIntervalSinceReferenceDate];
	int read, write;
    
	FILE *pcm =fopen([pcmPath cStringUsingEncoding:1],"rb");//被转换的文件
	FILE *mp3 =fopen([mp3Path cStringUsingEncoding:1],"wb");//转换后文件的存放位置
	const int PCM_SIZE =8192;
	const int MP3_SIZE =8192;
	short int pcm_buffer[PCM_SIZE*2];
	unsigned char mp3_buffer[MP3_SIZE];
	
	lame_t lame = lame_init();
	
	lame_set_in_samplerate(lame, 8000);
	lame_set_num_channels(lame, 1);
	
	lame_set_VBR(lame, vbr_default);
	
	lame_init_params(lame);
    
	fseek(pcm, 4*1024, SEEK_CUR);
	

    do {
        
        read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
		
        if (read == 0)
            
            write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
        
        else
            
            write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
	
        
        fwrite(mp3_buffer, write, 1, mp3);
        
    } while (read != 0);
    lame_close(lame);
    fclose(mp3);
    fclose(pcm);
	NSTimeInterval interval = [NSDate timeIntervalSinceReferenceDate];
	NSLog(@"time consuming %f",interval - date);
}

-(void)recordTimerFired:(id)sender
{
	[self stopRecord];
}

- (void)record {
    
    if ([self canRecord]) {
        NSError *error;
        
        NSMutableDictionary *_recordSetting = [[NSMutableDictionary alloc] init];
        
        [_recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [_recordSetting setValue:[NSNumber numberWithFloat:8000] forKey:AVSampleRateKey];
        [_recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
		[_recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
		[_recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
		[_recordSetting setValue:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];

//		_recordSetting = [NSDictionary
//										dictionaryWithObjectsAndKeys:
//										[NSNumber numberWithInt:AVAudioQualityMin],
//										AVEncoderAudioQualityKey,
//										[NSNumber numberWithInt:16],
//										AVEncoderBitRateKey,
//										[NSNumber numberWithInt:2],
//										AVNumberOfChannelsKey,
//										[NSNumber numberWithFloat:8000],
//										AVSampleRateKey,
//										nil];
		
				
		if (_recorder == NULL) {
			_recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:audioPath] settings:_recordSetting error:&error];
		}else {
			_recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:audioPath] settings:_recordSetting error:&error];
		}

		
		[_recorder setMeteringEnabled:YES];
		[_recorder setDelegate:self];
        [_recorder prepareToRecord];
    }else {
        NSLog(@"不能录制！！！！");
    }
	
}

#define KRecordingTag 12141
#define kRecordedTag 12142

-(void)startOrStop:(id)sender
{
	UIButton* btn = (UIButton*)sender;
	if (btn.tag == kRecordedTag)
	{
		btn.tag = KRecordingTag;
		[btn setTitle:@"正在录音" forState:UIControlStateNormal];
		self.recordStatus = RecordStatusCanRecord;
		_textView.text = @"";
	}
	if (btn.tag == KRecordingTag) {
			
		if (isRecording) {
				
				NSLog(@"停止录制内容");
				btn.tag = kRecordedTag;
				[btn setTitle:@"开始录音" forState:UIControlStateNormal];
				self.recordStatus = RecordStatusStop;
		}
	}
}

- (void)updateMeters:(NSTimer *)sender {
	
//	if ([[SCListener sharedListener] averagePower] > -1 && self.recordStatus == RecordStatusCanRecord)
	if (self.recordStatus == RecordStatusCanRecord)
	{
			if (!isRecording) {
				NSLog(@"1开始录制");
				isRecording = YES;
				
				NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:recordInterval target:self selector:@selector(recordTimerFired:) userInfo:nil repeats:NO];
				[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
				[_recorder prepareToRecord];
				[_recorder record];
			}
	}
	
//	if ([[SCListener sharedListener] averagePower] < 0.1) {
	else{
//		_lowTimes++;
//		
//		if (_lowTimes >= 5) {  //5  次  0.5s=======
//			_lowTimes = 0;
			if (isRecording) {
//
//				if (ISRECORDED) {
//					
//					if (_playTimes < 1) {
//						_playTimes++;
						
						NSLog(@"停止录制内容");
						[self stopRecord];
//						isPlaying = YES;
//					}
					
//				}

				
//			}
			
		}
	}
}

- (void)stopRecord {
	if (!isRecording) {
		return;
	}
	isRecording = NO;
    [_recorder stop];
}


- (void)play {
	NSLog(@"播放录制内容");
    NSError *error;
   // NSString *_filePath = [[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithString:@"out.aif"]] retain];

    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:outUrl error:&error];
	_player.delegate = self;
    [_player play];
}


- (BOOL)canRecord {
    NSError *error;
    self.audioSession = [AVAudioSession sharedInstance];
    
    if (![self.audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error]) {
        NSLog(@"Error %@", [error localizedDescription]);
        return  NO;
    }
    
    if (![self.audioSession setActive:YES error:&error]) {
		NSLog(@"Error %@", [error localizedDescription]);
        return  NO;
    }
    
    return self.audioSession.inputIsAvailable;
}

-(id)init
{
	if (self = [super init]) {
		_rawData = [[NSMutableData alloc] init];
		_string = [[NSMutableString alloc] init];
		_recordStatus = RecordStatusStop;
	}
	return self;
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	

	UITableView* table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 400) style:UITableViewStylePlain];
	table.delegate = self;
	table.dataSource = self;
	[self.view addSubview:table];
	self.table = table;
	
	
	_textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 400, 320, 60)];
	[self.view addSubview:_textView];
	
	_lowTimes = 0;
	_playTimes = 0;
	
	
	//设置路径
    NSArray *searchPaths =  NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    audioPath = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:@"audio.caf"];
	mp3AudioPath = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:MP3_File_Name];
//    outUrl = [[NSURL alloc] initFileURLWithPath:[[searchPaths objectAtIndex:0] stringByAppendingPathComponent:@"target.mp3"]];
	_pcmPath = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:@"PCMFile.caf"];
	
	[self record];

    //启用监听
//	[[SCListener sharedListener] listen];
	_timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateMeters:) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
		
	UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 420, 100, 50)];
	[btn setTitle:@"开始录音" forState:UIControlStateNormal];
	btn.tag = kRecordedTag;
	[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(startOrStop:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btn];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
}

#define kBoundary @"KCuQJmvbcAU9lGs05FU0N9uX7u5Pmo6N"

-(void)uploadVoice:(NSData *)data
{
	NSURL* url = [NSURL URLWithString:@"http://192.168.1.6:8080/tv_audio/audioIdentify"];
//	NSURL* url = [NSURL URLWithString:@"http://192.168.1.77:8081/TVAudio/audioIdentify"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
														   cachePolicy:NSURLRequestReloadIgnoringCacheData
													   timeoutInterval:10];
	
	NSMutableData *body = [NSMutableData data];
	NSData *boundary = [[NSString stringWithFormat:@"--%@\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding];
	[body appendData:boundary];
	NSString* formString = @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n";
	
	[body appendData:[[NSString stringWithFormat:formString, @"user_id",@"1206085"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:boundary];
	
	
	[body appendData:[[NSString stringWithFormat:formString, @"Action", @"user"]
					  dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:boundary];
	
	[body appendData:[[NSString stringWithFormat:formString, @"test", @"tenfen"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:boundary];
	
	NSData *imageData = data;//, [Context sharedContext].config.photoCompressionQuality);
	
	
	
	//	[body appendData:@""]
	NSString* dispostion = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Audio\"; filename=\"%@.mp3\"\r\n",MP3_File_Name];
	[body appendData:[dispostion dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Length: %d\r\n", imageData.length] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[@"Content-Type: Audio/mp3\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:imageData];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	
	NSLog(@"length is %d",imageData.length);
	
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:body];
	[request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", kBoundary] forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"1206085" forHTTPHeaderField:@"user_id"];
//	[request setValue:[NSString stringWithFormat:@"%d",body.length] forHTTPHeaderField:@"Content-Length"];
	NSURLConnection* con = [NSURLConnection connectionWithRequest:request delegate:self];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		[con start];
	});
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_rawData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//	NSLog(@"Response is %@",response);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"%@",error);
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//	self.isUploading = NO;
	NSString* str = [[NSString alloc] initWithData:_rawData encoding:NSUTF8StringEncoding];
	NSLog(@"-----%@-----",str);
	
	[self scheduleUploadQueue];
	NSDictionary* dic = [_rawData objectFromJSONData];
	self.dataSource = [dic objectForKey:@"tv_column_list"];
	NSString* confirm = [dic objectForKey:@"confirm"];
	NSString* maxTime = [dic objectForKey:@"max_time"];
	
	_textView.text = [NSString stringWithFormat:@"confirm:%@    max_time:%@",confirm,maxTime];
	NSMutableArray* arr = [NSMutableArray arrayWithCapacity:0];
	for (NSDictionary* dict in self.dataSource)
	{
		TVInfo* info = [[TVInfo alloc] initWithDic:dict];
		[arr addObject:info];
	}
	self.dataSource = [NSArray arrayWithArray:arr];
	[self.table reloadData];


	[_rawData setData:nil];
}

static NSString* const identifier = @"__sdfaf__";

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell* cell = [_table dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	TVInfo* info = [self.dataSource objectAtIndex:indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"tv_id:%@  置信度:%@",info.tvId,info.score];
	return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return  self.dataSource.count;
}

-(NSString*)createOriginMP3Path
{
	NSArray *searchPaths =  NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.mp3",MP3_File_Name,self.fileSuffix++]];
	return path;
}

-(NSString*)createUploadMP3Path
{
	NSArray *searchPaths =  NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%d.mp3",MP3_File_Name,self.currentUploadIndex++]];
	return path;
}

-(void)scheduleUploadQueue
{
	if (self.recordStatus == RecordStatusStop) {
		return;
	}
	NSString* mp3Path = [self createUploadMP3Path];
	NSData* ndata = [NSData dataWithContentsOfFile:mp3Path];
	if (ndata == nil) {
		self.currentUploadIndex--;
		return;
	}
	NSLog(@"path is %@",mp3Path);
	NSFileManager* man = [NSFileManager defaultManager];
	[man removeItemAtPath:mp3Path error:nil];
	self.isUploading = YES;
//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		[self uploadVoice:ndata];
//	});
}


- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
	
    NSLog(@"录音结束并且成功  ～～～～～@@～～～～～～");
//	self.recordStatus = RecordStatusPaused;
	NSString* mp3Path = [self createOriginMP3Path];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSData *data = [NSData dataWithContentsOfURL:_recorder.url];
//		dispatch_async(dispatch_get_main_queue(), ^{
//			self.recordStatus = RecordStatusCanRecord;
//		});
		NSLog(@"before length is %d",data.length);
		[data writeToFile:_pcmPath atomically:YES];

		[self convertFromPCM:_pcmPath toMP3:mp3Path];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self scheduleUploadQueue];
		});
	});
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    NSLog(@"录音失败");
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"播放结束！！！～～～@@～～～～");
	isPlaying = NO;
	[self record];
}


@end
