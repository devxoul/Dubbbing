//
//  MoviePlayerViewController.m
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 22..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "DubbingViewController.h"
#import "DubbbingBarButtonItem.h"
#import <MediaPlayer/MediaPlayer.h>
#import "DejalActivityView.h"

@implementation DubbingViewController

@synthesize delegate;

- (id)initWithURL:(NSURL *)url
{
	self = [super init];
	self.view.backgroundColor = [UIColor blackColor];
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];
	
	DubbbingBarButtonItem *cancelButton = [[DubbbingBarButtonItem alloc] initWithType:DubbbingBarButtonItemTypeNormal title:NSLocalizedString( @"CANCEL", @"취소" ) target:self action:@selector(cancelButtonHandler)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	
	self.navigationItem.title = NSLocalizedString( @"POSTING", @"포스팅" );
	
	DubbbingBarButtonItem *previewButtonHandler = [[DubbbingBarButtonItem alloc] initWithType:DubbbingBarButtonItemTypeNormal title:NSLocalizedString( @"PREVIEW", @"미리보기" ) target:self action:@selector(previewButtonHandler)];
	self.navigationItem.rightBarButtonItem = previewButtonHandler;
	
//	DubbbingBarButtonItem *doneButton = [[DubbbingBarButtonItem alloc] initWithType:DubbbingBarButtonItemTypeNormal title:NSLocalizedString( @"DONE", @"완료" ) target:self action:@selector(doneButtonHandler)];
//	self.navigationItem.rightBarButtonItem = doneButton;
//	[doneButton release];
	
    _isRecording = NO;
    _url = [url retain];
    
    _avPlayer = [AVPlayer playerWithURL:url];
    AVPlayerLayer* avplayerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    [avplayerLayer setFrame:CGRectMake(0,44,400,225)];
    avplayerLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:avplayerLayer];
    [_avPlayer play];
    
	

	_recordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	_recordButton.frame = CGRectMake( 410, 120, 60, 60 );
	[_recordButton addTarget:self action:@selector(recordButtonDidTouhDown) forControlEvents:UIControlEventTouchDown];
	[_recordButton addTarget:self action:@selector(recordButtonDidTouhUp) forControlEvents:UIControlEventTouchUpInside];
	[_recordButton addTarget:self action:@selector(recordButtonDidTouhUp) forControlEvents:UIControlEventTouchUpOutside];
	[self.view addSubview:_recordButton];
    
    _audioRecorder = [[AudioRecorder alloc] init];
       
	return self;
}


#pragma mark -
#pragma mark Navigation Item Handlers

- (void)cancelButtonHandler
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)previewButtonHandler
{
	[self mixVideoAndAudio];
	
	DubbbingBarButtonItem *doneButton = [[DubbbingBarButtonItem alloc] initWithType:DubbbingBarButtonItemTypeNormal title:NSLocalizedString( @"DONE", @"완료" ) target:self action:@selector(doneButtonHandler)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
}

- (void)doneButtonHandler
{
	[delegate dubbingDidFinishWithURL:_exportURL];
	[DejalBezelActivityView activityViewForView:self.view];
	[self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark -
#pragma mark UIButton Handlers

- (void)recordButtonDidTouhDown
{
    if( _isRecording == NO )
    {
//        Float64 startTimeSecond = CMTimeGetSeconds([_avPlayer currentTime]);
        CMTime startTime = [_avPlayer currentTime];// CMTimeMakeWithSeconds(startTimeSecond, 44100);
        [_audioRecorder recordAudioWithStartTime:startTime];
        _isRecording = YES;
    }
}

- (void)recordButtonDidTouhUp
{
    if( _isRecording == YES )
    {
        _isRecording = NO;
        [_audioRecorder stop];
    }
}

- (void)mixVideoAndAudio
{    
    // Create a player for our composition of audio tracks. We observe the status so
    // we know when the player is ready to play
    
    NSMutableArray* audioInfoList = _audioRecorder.audioInfoList;
    
    
    _audioVideoMixer = [[AudioVideoMixer alloc] init];
	_audioVideoMixer.delegate = self;
    [_audioVideoMixer mixVideoURL:_url audioInfoList:[audioInfoList retain]];
    
    AVPlayerItem* playerItem = [[AVPlayerItem alloc] initWithAsset:[_audioVideoMixer.composition copy]];
    [playerItem addObserver:self
                 forKeyPath:@"status"
                    options:0
                    context:NULL];
    
    _avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer* avplayerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    [avplayerLayer setFrame:CGRectMake(0,44,400,225)];
    
    avplayerLayer.backgroundColor = [UIColor orangeColor].CGColor;
    
    [self.view.layer addSublayer:avplayerLayer];
    [_avPlayer play];
    
	[_audioVideoMixer exportAudioFile];
//    [audioInfoList release];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"status"])
    {
        for (AVPlayerItemTrack* track in _avPlayer.currentItem.tracks)
        {
            if ([track.assetTrack.mediaType isEqual:AVMediaTypeAudio])
            {
                // Audio track available
            }
            if ([track.assetTrack.mediaType isEqual:AVMediaTypeVideo])
            {
                // Video track available
            }
        }
    }
}


#pragma mark -
#pragma mark AudioVideoMixerDelegate

- (void)mixerDidFinishMixingWithURL:(NSURL *)url
{
	_exportURL = url;
	
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
	[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
	
	[DejalBezelActivityView removeView];
	[delegate dubbingDidFinishWithURL:url];
	[self dismissViewControllerAnimated:YES completion:nil];
}


@end
