//
//  RecordViewController.m
//  Dubbbing
//
//  Created by Sinhyub Kim on 12/22/12.
//  Copyright (c) 2012 Joyfl. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController
@synthesize audioRecorder;
@synthesize playButton;
@synthesize recordButton;
@synthesize stopButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playButton setFrame:CGRectMake(20.f, 20.f, 200.f, 30.f)];
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    recordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [recordButton setFrame:CGRectMake(20.f, 70.f, 200.f, 30.f)];
    [recordButton setTitle:@"Record" forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(recordAudio) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordButton];
    
    stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stopButton setFrame:CGRectMake(20.f, 120.f, 200.f, 30.f)];
    [stopButton setTitle:@"Stop" forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    
    audioRecorder = [[AudioRecorder alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) recordAudio
{
    playButton.enabled = NO;
    stopButton.enabled = YES;
    [self.audioRecorder recordAudio];
}
-(void)stop
{
    stopButton.enabled = NO;
    playButton.enabled = YES;
    recordButton.enabled = YES;
    
    [self.audioRecorder stop];
}
-(void) playAudio
{
    stopButton.enabled = YES;
    recordButton.enabled = NO;
    [self.audioRecorder playAudio];
}

//-(void)audioPlayerDidFinishPlaying:
//(AVAudioPlayer *)player successfully:(BOOL)flag
//{
//    recordButton.enabled = YES;
//    stopButton.enabled = NO;
//}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    audioRecorder = nil;
    stopButton = nil;
    recordButton = nil;
    playButton = nil;
}

- (void)dealloc {
    [audioRecorder release];
    [stopButton release];
    [playButton release];
    [recordButton release];
    [super dealloc];
}

@end
