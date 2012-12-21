//
//  Utils.h
//  Dish by.me
//
//  Created by 전 수열 on 12. 9. 20..
//  Copyright (c) 2012년 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJSON.h"

@interface Utils : NSObject

+ (id)parseJSON:(NSString *)json;
+ (NSString *)writeJSON:(id)object;

+ (UIColor *)colorWithHex:(NSInteger)color alpha:(CGFloat)alpha;

+ (NSString *)sha1:(NSString *)input;

+ (CGFloat)screenHeight;

+ (NSString *)dateString:(NSDate *)date;

+ (NSInteger)integerValueFromDictionary:(NSDictionary *)dictionary forKey:(id)key;

@end
