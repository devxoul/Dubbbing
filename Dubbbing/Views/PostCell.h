//
//  PostCell.h
//  Dubbbing
//
//  Created by 전수열 on 12. 12. 21..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Post;

@interface PostCell : UITableViewCell
{
	Post *_post;
}

@property (nonatomic, retain) Post *post;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
