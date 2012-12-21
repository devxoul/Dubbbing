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

@property (strong, nonatomic) AVAudioRecorder* audioRecorder;
@property (strong, nonatomic) AVAudioPlayer* audioPlayer;


-(void) recordAudio;
-(void) stop;
-(void) playAudio;
-(NSURL*) getRecordedAudioURL;

@end


