//
//  PostCell.m
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "PostCell.h"
#import "Post.h"

@implementation PostCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	
	
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
	
}


@end
