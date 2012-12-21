//
//  ListViewController.h
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLHTTPLoader.h"

@interface ListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, JLHTTPLoaderDelegate>
{
	UITableView *_tableView;
	
	NSMutableArray *_posts;
}

@end
