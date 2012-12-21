//
//  AudioRecorder.h
//  Dubbbing
//
//  Created by Sinhyub Kim on 12/22/12.
//  Copyright (c) 2012 Joyfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>



@interface AudioRecorder : NSObject <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (strong, nonatomic) NSMutableArray* audioRecorderList;
@property (strong, nonatomic) NSMutableArray* audioInfoList;



-(void) recordAudioWithStartTime:(CMTime)startTime;
-(void) stop;


@end


