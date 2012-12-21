//
//  PostViewController.m
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "PostViewController.h"

@implementation PostViewController

- (id)init
{
	self = [super init];
	
	UIBarButtonItem *postButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString( @"UPLOAD", @"등록" ) style:UIBarButtonItemStyleDone target:self action:@selector(postButtonHandler)];
	self.navigationItem.rightBarButtonItem = postButton;
	[postButton release];
	
	return self;
}


#pragma mark -
#pragma mark Navigation Item Handlers

- (void)postButtonHandler
{
	
}

@end
