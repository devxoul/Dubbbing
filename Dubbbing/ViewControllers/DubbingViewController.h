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

@interface DubbingViewController : UIViewController
{
	NSURL *_url;
	
	UIButton *_recordButton;
    UIButton *_mixButton;
    
    AudioRecorder* _audioRecorder;    
    
    // Player
    AVPlayer* _avPlayer;
    BOOL    _isRecording;
}

- (id)initWithURL:(NSURL *)url;


@end
