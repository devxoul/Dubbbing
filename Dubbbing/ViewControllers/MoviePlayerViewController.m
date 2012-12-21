//
//  MoviePlayerViewController.m
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 22..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "MoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation MoviePlayerViewController

- (id)initWithURL:(NSURL *)url
{
	self = [super init];
	self.view.backgroundColor = [UIColor blackColor];
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];
	
	_player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://server.jagur.kr/1.mov"]];
	_player.view.frame = CGRectMake( 0, 0, 400, 225 );
	[_player prepareToPlay];
	[_player play];
	[self.view addSubview:_player.view];
	
	_recordButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	_recordButton.frame = CGRectMake( 410, 130, 60, 60 );
	[_recordButton addTarget:self action:@selector(recordButtonDidTouhDown) forControlEvents:UIControlEventTouchDown];
	[_recordButton addTarget:self action:@selector(recordButtonDidTouhUp) forControlEvents:UIControlEventTouchUpInside];
	[_recordButton addTarget:self action:@selector(recordButtonDidTouhUp) forControlEvents:UIControlEventTouchUpOutside];
	[self.view addSubview:_recordButton];
	
	return self;
}


#pragma mark -
#pragma mark UIButton Handlers

- (void)recordButtonDidTouhDown
{
	
}

- (void)recordButtonDidTouhUp
{
	
}

@end
