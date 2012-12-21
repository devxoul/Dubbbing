//
//  RecordViewController.h
//  Dubbbing
//
//  Created by Sinhyub Kim on 12/22/12.
//  Copyright (c) 2012 Joyfl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AudioRecorder.h"

@interface RecordViewController : UIViewController
@property (strong, nonatomic) AudioRecorder* audioRecorder;
@property (strong, nonatomic) UIButton* playButton;
@property (strong, nonatomic) UIButton* recordButton;
@property (strong, nonatomic) UIButton* stopButton;
@property (strong, nonatomic) UIButton* testButton;

@end
