//
//  AudioInfo.h
//  Dubbbing
//
//  Created by Sinhyub Kim on 12/22/12.
//  Copyright (c) 2012 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioInfo : NSObject
@property (strong, nonatomic) NSURL* audioURL;
@property (nonatomic) CMTime audioStartTime;


-(id) initWithAudioURL:(NSURL*)url startTime:(CMTime)startTime;

@end
