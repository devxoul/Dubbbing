//
//  PostCell.m
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"
#import "Utils.h"
#import "Const.h"
#import "JLHTTPLoader.h"

@implementation PostCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	
	UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
	bg.frame = CGRectMake( 10, 10, 300, 202 );
	[self.contentView addSubview:bg];
	
	_thumbnailButton = [[UIButton alloc] initWithFrame:CGRectMake( 10, 10, 300, 168 )];
	[_thumbnailButton setBackgroundImage:PLACEHOLDER_IMAGE forState:UIControlStateNormal];
	[self.contentView addSubview:_thumbnailButton];
	
	_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake( 20, 184, 560, 20 )];
	_titleLabel.font = [UIFont boldSystemFontOfSize:14];
	_titleLabel.textColor = [Utils colorWithHex:0x66686F alpha:1];
	_titleLabel.backgroundColor = [UIColor clearColor];
	[self.contentView addSubview:_titleLabel];
	
	return self;
}


#pragma mark -
#pragma mark Getter/Setter

- (Post *)post
{
	return _post;
}

- (void)setPost:(Post *)post
{
	[_thumbnailButton setImage:nil forState:UIControlStateNormal];
	[_thumbnailButton setBackgroundImage:PLACEHOLDER_IMAGE forState:UIControlStateNormal];
	
	if( post.thumbnail )
	{
		[_thumbnailButton setImage:PLAY_IMAGE forState:UIControlStateNormal];
		[_thumbnailButton setBackgroundImage:post.thumbnail forState:UIControlStateNormal];
	}
	else
	{
		[JLHTTPLoader loadAsyncFromURL:post.thumbnailURL completion:^(NSData *data) {
			[_thumbnailButton setImage:PLAY_IMAGE forState:UIControlStateNormal];
			[_thumbnailButton setBackgroundImage:post.thumbnail = [UIImage imageWithData:data] forState:UIControlStateNormal];
		}];
	}
	
	_titleLabel.text = post.title;
}


@end
