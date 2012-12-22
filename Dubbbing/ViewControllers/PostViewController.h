//
//  PostViewController.h
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DubbingViewController.h"
#import "JLHTTPLoader.h"

@interface PostViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, DubbingViewControllerDelegate, JLHTTPLoaderDelegate>
{
	NSURL *_url;
	NSURL *_mixedMovieURL;
	
	UITableView *_tableView;
	
	UIButton *_movieButton;
	UITextField *_titleInput;
	UITextField *_descriptionInput;
	
	JLHTTPLoader *_loader;
}

- (id)initWithURL:(NSString *)url;

@end
