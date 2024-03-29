//
//  PostViewController.m
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "PostViewController.h"
#import "Utils.h"
#import <QuartzCore/CALayer.h>
#import "DubbingViewController.h"
#import "DubbbingBarButtonItem.h"
#import "DubbbingNavigationController.h"
#import "DejalActivityView.h"
#import "Const.h"

@implementation PostViewController

enum {
	kSectionMovie = 0,
	kSectionInfo = 1,
};

enum {
	kRowTitle = 0,
	kRowDescription = 1,
};

- (id)initWithURL:(NSURL *)url
{
	self = [super init];
	
	_url = [url retain];
	
	DubbbingBarButtonItem *cancelButton = [[DubbbingBarButtonItem alloc] initWithType:DubbbingBarButtonItemTypeNormal title:NSLocalizedString( @"CANCEL", @"취소" ) target:self action:@selector(cancelButtonHandler)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	[cancelButton release];
	
	self.navigationItem.title = NSLocalizedString( @"POSTING", @"포스팅" );
	
	DubbbingBarButtonItem *postButton = [[DubbbingBarButtonItem alloc] initWithType:DubbbingBarButtonItemTypeNormal title:NSLocalizedString( @"UPLOAD", @"등록" ) target:self action:@selector(postButtonHandler)];
	self.navigationItem.rightBarButtonItem = postButton;
	[postButton release];
	
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake( 0, 0, 320, [Utils screenHeight] - 64 ) style:UITableViewStyleGrouped];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.view addSubview:_tableView];
	
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewDidTap)];
	[self.view addGestureRecognizer:tapRecognizer];
	[tapRecognizer release];
	
	_loader = [[JLHTTPLoader alloc] init];
	_loader.delegate = self;
	
	
	
	return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	
}

- (void)tableViewDidTap
{
	[_titleInput resignFirstResponder];
	[_descriptionInput resignFirstResponder];
	
	[UIView animateWithDuration:0.25 animations:^{
		_tableView.contentInset = UIEdgeInsetsMake( 0, 0, 0, 0 );
		_tableView.scrollIndicatorInsets = UIEdgeInsetsMake( 0, 0, 0, 0 );
	}];
}


#pragma mark -
#pragma mark Navigation Item Handlers

- (void)cancelButtonHandler
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)postButtonHandler
{
	[DejalBezelActivityView activityViewForView:self.view];
	
	JLHTTPMultipartRequest *req = [[JLHTTPMultipartRequest alloc] init];
	req.url = URL_API_DUB;
	req.method = @"POST";
	[req setParam:@"45c2c93dae3e7e9bd60a3bf6cf33f7a7bab9b671" forKey:@"access_token"];
	[req setParam:_titleInput.text forKey:@"title"];
	[req setParam:@"Description" forKey:@"description"];
	[req setParam:_mixedMovieURL forKey:@"video"];
	[_loader addRequest:req];
	[_loader startLoading];
}


#pragma mark -
#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if( section == kSectionMovie )
		return 1;
	
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if( indexPath.section == kSectionMovie )
		return 169;
	
	if( indexPath.row == kRowTitle )
		return 44;
	
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *movieCellId = @"movieCellId";
	static NSString *titleCellId = @"titleCellId";
	
	UITableViewCell *cell = nil;
	
	if( indexPath.section == kSectionMovie )
	{
		cell = [tableView dequeueReusableCellWithIdentifier:movieCellId];
		if( !cell )
		{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:movieCellId];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		
		if( !_movieButton )
		{
			_movieButton = [[UIButton alloc] initWithFrame:CGRectMake( 0, 0, 300, 169 )];
			_movieButton.backgroundColor = [UIColor blackColor];
			_movieButton.layer.cornerRadius = 5;
			_movieButton.clipsToBounds = YES;
			[_movieButton addTarget:self action:@selector(movieButtonDidTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
			[cell.contentView addSubview:_movieButton];
		}
	}
	
	else if( indexPath.section == kSectionInfo )
	{
		if( indexPath.row == kRowTitle )
		{
			cell = [tableView dequeueReusableCellWithIdentifier:titleCellId];
			if( !cell )
			{
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:movieCellId];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				
				_titleInput = [[UITextField alloc] initWithFrame:CGRectMake( 10, 11, 300, 22 )];
				_titleInput.delegate = self;
				_titleInput.placeholder = NSLocalizedString( @"TITLE", @"제목" );
				_titleInput.returnKeyType = UIReturnKeyNext;
				[_titleInput addTarget:self action:@selector(inputEditingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
				[cell.contentView addSubview:_titleInput];
			}
		}
	}
	
	return cell;
}


#pragma mark -
#pragma mark UIButton Selectors

- (void)movieButtonDidTouchUpInside
{
	DubbingViewController *dubbingViewController = [[DubbingViewController alloc] initWithURL:_url];
	dubbingViewController.delegate = self;
	[self presentViewController:[[[DubbbingNavigationController alloc] initWithRootViewController:dubbingViewController] autorelease] animated:YES completion:nil];
	[dubbingViewController release];
}


#pragma mark -
#pragma mark DubbingViewControllerDelegate

- (void)dubbingDidFinishWithURL:(NSURL *)url
{
	_mixedMovieURL = [url retain];
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (void)inputEditingDidBegin
{
	[UIView animateWithDuration:0.25 animations:^{		
		_tableView.contentInset = UIEdgeInsetsMake( 0, 0, 216, 0 );
		_tableView.scrollIndicatorInsets = UIEdgeInsetsMake( 0, 0, 216, 0 );
		_tableView.contentOffset = CGPointMake( 0, 190 );
	}];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if( textField == _titleInput )
		[_descriptionInput becomeFirstResponder];
	
	else
		[self tableViewDidTap];
	
	return NO;
}


#pragma mark -
#pragma mark JLHTTPLoaderDelegate

- (void)loaderDidFinishLoading:(JLHTTPResponse *)response
{
	NSLog( @"Code : %d", response.statusCode );
	NSLog( @"Body : %@", response.body );
}

@end
