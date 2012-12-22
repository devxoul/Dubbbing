//
//  MoviePlayerViewController.h
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 22..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>
#import "AudioRecorder.h"
#import "AudioVideoMixer.h"

@protocol DubbingViewControllerDelegate

- (void)dubbingDidFinishWithURL:(NSURL *)url;

@end


@interface DubbingViewController : UIViewController <AudioVideoMixerDelegate>
{
	id<DubbingViewControllerDelegate> delegate;
	
	NSURL *_url;
	
	UIButton *_recordButton;
    UIButton *_mixButton;
    
    AudioRecorder* _audioRecorder;
	AudioVideoMixer* _audioVideoMixer;
    
    // Player
    AVPlayer* _avPlayer;
    BOOL    _isRecording;
	
	NSURL *_exportURL;
}

@property (nonatomic, retain) id<DubbingViewControllerDelegate> delegate;

- (id)initWithURL:(NSURL *)url;


@end
