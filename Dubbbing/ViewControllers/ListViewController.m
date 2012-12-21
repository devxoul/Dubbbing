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
#import <MobileCoreServices/UTCoreTypes.h>

@implementation ListViewController

- (id)init
{
	self  = [super init];
	
	UIBarButtonItem *postButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(postButtonHandler)];
	self.navigationItem.rightBarButtonItem = postButton;
	[postButton release];
	
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, 320, [Utils screenHeight] - 64 ) style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];
	
	return self;
}


#pragma mark -
#pragma mark Navigation Item Handlers

- (void)postButtonHandler
{
	[self presentActionSheet];
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
		
		pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
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
	[self dismissViewControllerAnimated:YES completion:nil];
	
	NSLog( @"Album : %@", info );
	UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	
	// 카메라로 찍은 경우 앨범에 저장
	if( picker.sourceType == UIImagePickerControllerSourceTypeCamera )
		UIImageWriteToSavedPhotosAlbum( image, nil, nil, nil );
	
}


#pragma mark -
#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _posts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
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
}



@end
