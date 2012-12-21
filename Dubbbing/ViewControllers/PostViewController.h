//
//  PostViewController.h
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
	NSURL *_url;
	
	UITableView *_tableView;
	
	UIButton *_movieButton;
	UITextField *_titleInput;
	UITextField *_descriptionInput;
}

- (id)initWithURL:(NSString *)url;

@end
