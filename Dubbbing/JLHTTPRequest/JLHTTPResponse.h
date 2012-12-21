//
//  JLHTTPResponse.h
//  JLHTTPRequest
//
//  Created by 전수열 on 12. 11. 19..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLHTTPResponse : NSObject
{
	NSInteger requestId;
	NSString *url;
	NSInteger statusCode;
	NSDictionary *headers;
	NSString *body;
}

@property (nonatomic, assign) NSInteger requestId;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, retain) NSDictionary *headers;
@property (nonatomic, retain) NSString *body;

@end
