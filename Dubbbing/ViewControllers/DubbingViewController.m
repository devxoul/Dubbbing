//
//  MoviePlayerViewController.m
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 22..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "DubbingViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AudioVideoMixer.h"

@implementation DubbingViewController

- (id)initWithURL:(NSURL *)url
{
	self = [super init];
	self.view.backgroundColor = [UIColor blackColor];
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];
	
    _isRecording = NO;
    _url = [url retain];
    
    _avPlayer = [AVPlayer playerWithURL:url];
    AVPlayerLayer* avplayerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    [avplayerLayer setFrame:CGRectMake(0,0,400,225)];
    avplayerLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:avplayerLayer];
    [_avPlayer play];
    
	

	_recordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	_recordButton.frame = CGRectMake( 410, 130, 60, 60 );
	[_recordButton addTarget:self action:@selector(recordButtonDidTouhDown) forControlEvents:UIControlEventTouchDown];
	[_recordButton addTarget:self action:@selector(recordButtonDidTouhUp) forControlEvents:UIControlEventTouchUpInside];
	[_recordButton addTarget:self action:@selector(recordButtonDidTouhUp) forControlEvents:UIControlEventTouchUpOutside];
	[self.view addSubview:_recordButton];
    
    _mixButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	_mixButton.frame = CGRectMake( 410, 10, 60, 60 );
    [_mixButton setTitle:@"mix" forState:UIControlStateNormal];
	[_mixButton addTarget:self action:@selector(mixButtonDidTouhUp) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:_mixButton];

    
    _audioRecorder = [[AudioRecorder alloc] init];
       
	return self;
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


- (void)mixButtonDidTouhUp
{
    [self mixVideoAndAudio];
}


- (void)mixVideoAndAudio
{    
    // Create a player for our composition of audio tracks. We observe the status so
    // we know when the player is ready to play
    
    NSMutableArray* audioInfoList = _audioRecorder.audioInfoList;
    
    
    AudioVideoMixer* audioVideoMixer = [[AudioVideoMixer alloc] init];
    [audioVideoMixer mixVideoURL:_url audioInfoList:audioInfoList];
    
    AVPlayerItem* playerItem = [[AVPlayerItem alloc] initWithAsset:[audioVideoMixer.composition copy]];
    [playerItem addObserver:self
                 forKeyPath:@"status"
                    options:0
                    context:NULL];
    
    _avPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer* avplayerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    [avplayerLayer setFrame:CGRectMake(0,0,270,180)];
    
    avplayerLayer.backgroundColor = [UIColor orangeColor].CGColor;
    
    [self.view.layer addSublayer:avplayerLayer];
    [_avPlayer play];
    
    
    [audioVideoMixer exportAudioFile];
    

    [audioInfoList release];
    [audioVideoMixer release];
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

@end
