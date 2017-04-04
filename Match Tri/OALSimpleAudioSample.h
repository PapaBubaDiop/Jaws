//
//  OALSimpleAudioSample.h
//  ObjectAL
//
//  Created by Karl Stenerud on 10-10-09.
//

#import <Foundation/Foundation.h>


/**
 * This is a copy of the sample code presented in the ObjectAL documentation.
 */
@interface OALSimpleAudioSample : NSObject
{
	// No objects to keep track of...
}

- (void) playSound:(int) i;
- (void) onGameStart;
- (void) onGamePause;

- (void) onGameResume;
- (void) onGameOver;


-(void) setEffectVolume:(float) v;
- (void) setBgVolume:(float) v;



@end
