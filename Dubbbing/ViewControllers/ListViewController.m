//
//  ListViewController.m
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "ListViewController.h"
#import "Utils.h"
#import "PostViewController.h"
#import "PostCell.h"
#import "DubbbingNavigationController.h"
#import "DubbbingBarButtonItem.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "Post.h"
#import "Const.h"

@implementation ListViewController

- (id)init
{
	self  = [super init];
	self.view.backgroundColor = [Utils colorWithHex:0xE9F0FB alpha:1];
	
	self.navigationItem.titleView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]] autorelease];
	
	DubbbingBarButtonItem *postButton = [[DubbbingBarButtonItem alloc] initWithType:DubbbingBarButtonItemTypeNormal title:nil target:self action:@selector(postButtonHandler)];
	postButton.frame = CGRectMake( 0, 0, 30, 30 );
	[postButton setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
	self.navigationItem.rightBarButtonItem = postButton;
	[postButton release];
	
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, 320, [Utils screenHeight] - 64 ) style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.backgroundColor = self.view.backgroundColor;
	[self.view addSubview:_tableView];
	
	_posts = [[NSMutableArray alloc] init];
	
	_loader = [[JLHTTPLoader alloc] init];
	_loader.delegate = self;
	
	JLHTTPGETRequest *req = [[JLHTTPGETRequest alloc] init];
	req.url = URL_API_DUBS;
	[req setParam:@"45c2c93dae3e7e9bd60a3bf6cf33f7a7bab9b671" forKey:@"access_token"];
	[req setParam:@"0" forKey:@"offset"];
	[req setParam:@"100" forKey:@"limit"];
	[_loader addRequest:req];
	[_loader startLoading];
	
	return self;
}


#pragma mark -
#pragma mark Navigation Item Handlers

- (void)postButtonHandler
{
	[self presentActionSheet];
//	[self presentPostViewControllerWithURL:nil];
}


#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)presentActionSheet
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString( @"CANCEL", @"취소" ) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString( @"RECORD_A_VIDEO", @"동영상 촬영" ), NSLocalizedString( @"FROM_LIBRARY", @"라이브러리에서 선택" ), nil];
	[actionSheet showInView:self.view];
	[actionSheet release];
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
	
	// Camera
	if( buttonIndex == 0 )
	{
		@try
		{
			pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
		}
		@catch (NSException *exception)
		{
			[[[[UIAlertView alloc] initWithTitle:NSLocalizedString( @"OOPS", @"어맛!" ) message:NSLocalizedString( @"NO_SUPPORT_CAMERA", @"카메라를 지원하지 않는 기기입니다.") delegate:self cancelButtonTitle:NSLocalizedString( @"I_GOT_IT", @"알겠어요" ) otherButtonTitles:nil] autorelease] show];
			return;
		}
		
		pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
	}
	
	// Library
	else if( buttonIndex == 1 )
	{
		pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		pickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
	}
	
	
	// Cancel
	else
	{
		return;
	}
	
	pickerController.delegate = self;
	[self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	NSLog( @"info : %@", info );
	[self performSelector:@selector(presentPostViewControllerWithURL:) withObject:[info objectForKey:UIImagePickerControllerMediaURL] afterDelay:0.5];
}

- (void)presentPostViewControllerWithURL:(NSString *)url
{
	[self dismissViewControllerAnimated:NO completion:nil];
	
	DubbbingNavigationController *postViewController = [[DubbbingNavigationController alloc] initWithRootViewController:[[[PostViewController alloc] initWithURL:url] autorelease]];
	[self presentViewController:postViewController animated:NO completion:nil];
	[postViewController release];
}


#pragma mark -
#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _posts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 212;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellId = @"cellId";
	PostCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	
	if( !cell )
	{
		cell = [[[PostCell alloc] initWithReuseIdentifier:cellId] autorelease];
	}
	
	cell.post = [_posts objectAtIndex:indexPath.row];
	
	return cell;
}


#pragma mark -
#pragma mark JLHTTPLoaderDelegate

- (void)loaderDidFinishLoading:(JLHTTPResponse *)response
{
	NSLog( @"Code : %d", response.statusCode );
	NSLog( @"Body : %@", response.body );
	
	NSArray *posts = [[Utils parseJSON:response.body] objectForKey:@"data"];
	
	for( NSDictionary *postDict in posts )
	{
		Post *post = [Post postFromDictionary:postDict];
		[_posts addObject:post];
		[post release];
	}
	
	[_tableView reloadData];
}



@end
