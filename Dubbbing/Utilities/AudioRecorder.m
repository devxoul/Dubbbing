//
//  AudioRecorder.m
//  Dubbbing
//
//  Created by Sinhyub Kim on 12/22/12.
//  Copyright (c) 2012 Joyfl. All rights reserved.
//

#import "AudioRecorder.h"

@implementation AudioRecorder

@synthesize audioRecorder;
@synthesize audioPlayer;

- (id)init
{
    self = [super init];
    if( self ) {
        NSArray *dirPaths;
        NSString *docsDir;
        
        dirPaths = NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        NSString *soundFilePath = [docsDir
                                   stringByAppendingPathComponent:@"sound.caf"];
        
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        NSDictionary *recordSettings = [NSDictionary
                                        dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:AVAudioQualityMin],
                                        AVEncoderAudioQualityKey,
                                        [NSNumber numberWithInt:16],
                                        AVEncoderBitRateKey,
                                        [NSNumber numberWithInt: 2],
                                        AVNumberOfChannelsKey,
                                        [NSNumber numberWithFloat:44100.0],
                                        AVSampleRateKey,
                                        nil];
        
        NSError *error = nil;
        
        audioRecorder = [[AVAudioRecorder alloc]
                         initWithURL:soundFileURL
                         settings:recordSettings
                         error:&error];
        
        if (error)
        {
            NSLog(@"error: %@", [error localizedDescription]);
            
        } else {
            [audioRecorder prepareToRecord];
        }
    }
    
    return self;
}

-(void) recordAudio
{
    if (!audioRecorder.recording)
    {
        [audioRecorder record];
    }
}

-(void)stop
{
    if (audioRecorder.recording)
    {
        [audioRecorder stop];
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
}
-(void) playAudio
{
    if (!audioRecorder.recording)
    {
        if (audioPlayer)
            [audioPlayer release];
        NSError *error;
        
        audioPlayer = [[AVAudioPlayer alloc]
                       initWithContentsOfURL:[self getRecordedAudioURL]
                       error:&error];
        
        audioPlayer.delegate = self;
        
        if (error)
            NSLog(@"Error: %@",
                  [error localizedDescription]);
        else
            [audioPlayer play];
    }
}

-(NSURL*) getRecordedAudioURL
{
    return self.audioRecorder.url;
}


-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
    // 잉거 구현해줘여 ViewController호출
}

-(void)audioPlayerDecodeErrorDidOccur:
(AVAudioPlayer *)player
                                error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}

-(void)audioRecorderDidFinishRecording:
(AVAudioRecorder *)recorder
                          successfully:(BOOL)flag
{
}

-(void)audioRecorderEncodeErrorDidOccur:
(AVAudioRecorder *)recorder
                                  error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}

- (void)dealloc {
    [audioPlayer release];
    [audioRecorder release];
    [super dealloc];
}


@end
