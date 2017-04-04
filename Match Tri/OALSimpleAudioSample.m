//
//  OALSimpleAudioSample.m
//  ObjectAL
//
//  Created by Karl Stenerud on 10-10-09.
//

#import "OALSimpleAudioSample.h"
#import "ObjectAL.h"


#define SOUND_1 @"s1.wav"
#define SOUND_2 @"clinton.mp3"
#define SOUND_3 @"clear.caf"
#define SOUND_4 @"Combo1.mp3"
#define SOUND_5 @"Combo2.mp3"
#define SOUND_6 @"success.caf"
#define SOUND_7 @"bump_wall_01.aac"
#define SOUND_8 @"improved_result.caf"
#define SOUND_9 @"wood.mp3"
#define SOUND_10 @"counter.mp3"
#define SOUND_11 @"swipe.mp3"
#define SOUND_12 @"s4.wav"
#define SOUND_13 @"powerup_awarded.mp3"
#define SOUND_14 @"lost.mp3"
#define SOUND_15 @"trump.mp3"
#define SOUND_0 @"trump.mp3"





#define INGAME_MUSIC_FILE  @"piratesof.mp3"



@implementation OALSimpleAudioSample

- (id) init
{
	if(nil != (self = [super init]))
	{
		// We don't want ipod music to keep playing since
		// we have our own bg music.
		[OALSimpleAudio sharedInstance].allowIpod = YES;
		
		// Mute all audio if the silent switch is turned on.
		[OALSimpleAudio sharedInstance].honorSilentSwitch = YES;
		
		// This loads the sound effects into memory so that
		// there's no delay when we tell it to play them.
		[[OALSimpleAudio sharedInstance] preloadEffect:SOUND_1];
		[[OALSimpleAudio sharedInstance] preloadEffect:SOUND_2];
		[[OALSimpleAudio sharedInstance] preloadEffect:SOUND_3];
		[[OALSimpleAudio sharedInstance] preloadEffect:SOUND_4];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_5];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_6];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_7];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_8];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_9];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_10];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_11];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_12];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_13];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_14];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_15];
        [[OALSimpleAudio sharedInstance] preloadEffect:SOUND_0];
	}
	return self;
}

- (void) onGameStart
{
	// Play the BG music and loop it.
	[[OALSimpleAudio sharedInstance] playBg:INGAME_MUSIC_FILE loop:YES];
}

- (void) onGamePause
{
	[OALSimpleAudio sharedInstance].paused = YES;
}

- (void) onGameResume
{
	[OALSimpleAudio sharedInstance].paused = NO;
}



- (void) onGameOver
{
	// Could use stopEverything here if you want
	[[OALSimpleAudio sharedInstance] stopAllEffects];
	
	// We only play the game over music through once.
//	[[OALSimpleAudio sharedInstance] playBg:GAMEOVER_MUSIC_FILE];
}


-(void) setEffectVolume:(float) v
{
    [[OALSimpleAudio sharedInstance] setEffectsVolume:v];
}


- (void) setBgVolume:(float) v
{
    [[OALSimpleAudio sharedInstance] setBgVolume:v];
}



- (void) playSound:(int) i
{
    switch (i) {
        case 1:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_1];
            break;
        case 2:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_2];
            break;
        case 3:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_3];
            break;
        case 4:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_4];
            break;
        case 5:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_5];
            break;
        case 6:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_6];
            break;
        case 7:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_7];
            break;
        case 8:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_8];
            break;
        case 9:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_9];
            break;
        case 10:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_10];
            break;
        case 11:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_11];
            break;
        case 12:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_12];
            break;
        case 13:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_13];
            break;
        case 14:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_14];
            break;
        case 15:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_15];
        case 0:
            [[OALSimpleAudio sharedInstance] playEffect:SOUND_0];
            break;
            
        default:
            break;
    }
}

- (void) onQuitToMainMenu
{
	// Stop all music and sound effects.
	[[OALSimpleAudio sharedInstance] stopEverything];	
	
	// Unload all sound effects and bg music so that it doesn't fill
	// memory unnecessarily.
	[[OALSimpleAudio sharedInstance] unloadAllEffects];
}

@end
