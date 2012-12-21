//
//  MoviePlayerViewController.h
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 22..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MoviePlayerViewController : UIViewController
{
	NSURL *_url;
	
	MPMoviePlayerController *_player;
	UIButton *_recordButton;
}

- (id)initWithURL:(NSURL *)url;

@end
