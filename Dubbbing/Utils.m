//
//  Utils.m
//  Dish by.me
//
//  Created by 전 수열 on 12. 9. 20..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import "Utils.h"
#import "CommonCrypto/CommonDigest.h"

@implementation Utils

+ (id)parseJSON:(NSString *)json
{
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	return [[parser autorelease] objectWithString:json];
}

+ (NSString *)writeJSON:(id)object
{
	SBJsonWriter *writer = [[SBJsonWriter alloc] init];
	return [[writer autorelease] stringWithObject:object];
}

+ (UIColor *)colorWithHex:(NSInteger)color alpha:(CGFloat)alpha
{
	NSInteger red = ( color >> 16 ) & 0xFF;
	NSInteger green = ( color >> 8 ) & 0xFF;
	NSInteger blue = color & 0xFF;
	return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (NSString *)sha1:(NSString *)input
{
	NSData *data = [input dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1( data.bytes, data.length, digest );
	
	NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
	for( int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++ )
		[output appendFormat:@"%02x", digest[i]];
	
	return output;
}

+ (CGFloat)screenHeight
{
	return [UIScreen mainScreen].bounds.size.height;
}

+ (NSString *)dateString:(NSDate *)date
{
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	formatter.dateFormat = @"yyyy-MM-dd";
	return [formatter stringFromDate:date];
}

+ (NSInteger)integerValueFromDictionary:(NSDictionary *)dictionary forKey:(id)key
{
	return ![[dictionary objectForKey:key] isEqual:[NSNull null]] ? [[dictionary objectForKey:key] integerValue] : 0;
}

@end
