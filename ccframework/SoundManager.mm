//
//  SoundManager.m
//  crashGame
//
//  Created by KCU on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SoundManager.h"
#include <sys/time.h>

@implementation SoundManager

static SoundManager *_sharedSound = nil;
static NSString* strBGM[] =
{
    @"bgm1.mp3",
};

static NSString* strEffects[] =
{
    @"Explosion.mp3",
};


+ (SoundManager*) sharedSoundManager 
{
	if (!_sharedSound) 
	{
		_sharedSound = [[SoundManager alloc] init];
	}
	
	return _sharedSound;
}

+ (void) releaseSoundManager 
{
	if (_sharedSound) 
	{
		[_sharedSound release];
		_sharedSound = nil;
	}
}

- (id) init
{
	if ( (self=[super init]) )
	{
		soundEngine = [SimpleAudioEngine sharedEngine];
		[soundEngine setEffectsVolume: 0.02f];
		[soundEngine setBackgroundMusicVolume: 0.02f];
		audioManager = [CDAudioManager sharedManager];
		mbEffectMute = NO;
		mbBackgroundMute = NO;
        [self loadData];
	}
	
	return self;
}

- (void) loadData
{
    [self loadBGM: 0];
}

- (void) playRandomBackground
{
    /*
	int soundId = arc4random()%kBackgroundCount;
	[self playBackgroundMusic: soundId];
     */
}

#pragma mark -
#pragma mark Load and unload sound files.
- (void) loadData: (NSString*) fileName
{
    [soundEngine preloadEffect: fileName];
}

-(void) unloadData: (NSString*) fileName 
{
	[soundEngine unloadEffect: fileName];    
}

- (void) loadBGM: (int) nID 
{
    [soundEngine preloadEffect: strBGM[nID]];
}
- (void) unloadBGM: (int) nID
{
    [soundEngine unloadEffect: strBGM[nID]];
}

#pragma mark -
#pragma mark Play background and effect.

- (void) playEffect: (NSString*) strFile bForce: (BOOL) bForce
{
	if (strFile == nil)
		return;
	if (mbEffectMute)
		return;
	
	[soundEngine playEffect: strFile];
}

- (void) playEffectWithID: (int) nEffectID bForce: (BOOL) bForce
{
	if (mbEffectMute)
		return;
	
	[soundEngine playEffect: strEffects[nEffectID]];
}

- (void) playBackgroundMusic:(NSString*) strFile
{
	if (strFile == nil)
		return;
	if (mbBackgroundMute)
		return;
    
	[soundEngine playBackgroundMusic: strFile loop:TRUE];
}

-(void) stopBackgroundMusic
{
	[soundEngine stopBackgroundMusic];
}

- (void) setBackgroundMusicMute: (BOOL) bMute
{
	mbBackgroundMute = bMute;
}

- (void) setEffectMute: (BOOL) bMute
{
	mbEffectMute = bMute;
}

- (BOOL) getBackgroundMusicMuted
{
	return mbBackgroundMute;
}

- (BOOL) getEffectMuted
{
	return mbEffectMute;
}

- (float) backgroundVolume
{
	return soundEngine.backgroundMusicVolume;
}

- (void) setBackgroundVolume: (float) fVolume
{
	soundEngine.backgroundMusicVolume = fVolume;
}

- (void) setEffectVolume: (float) fVolume
{
	soundEngine.effectsVolume = fVolume;
}

- (float) effectVolume
{
	return soundEngine.effectsVolume;
}

- (void) playBGM:(int) nID
{
	if (mbBackgroundMute)
		return;
    
	[soundEngine playBackgroundMusic: strBGM[nID] loop:TRUE];
}

- (int) getBallEffectID: (int) nBallType
{
//    int nEffectID = 0;
//    
//    switch (nBallType) {
//        case PAPER:
//            nEffectID = PAPER_EFFECT;
//            break;
//
//        case APPLE:
//            nEffectID = APPLE_EFFECT;
//            break;
//
//        case PENCIL:
//            nEffectID = PENCIL_EFFECT;
//            break;
//            
//        case CAKE_BOX:
//            nEffectID = CAKE_BOX_EFFECT;
//            break;
//
//
//        case CHOCOLET:
//            nEffectID = CHOCOLET_EFFECT;
//            break;
//
//        case CUP:
//            nEffectID = CUP_EFFECT;
//            break;
//
//        case JUICE_BOTTLE:
//            nEffectID = JUICE_BOTTLE_EFFECT;
//            break;
//
//        case JUICE_BOX:
//            nEffectID = JUICE_BOX_EFFECT;
//            break;
//
//        case ORANGE:
//            nEffectID = ORANGE_EFFECT;
//            break;
//
//        case PINGPONG:
//            nEffectID = PINGPONG_EFFECT;
//            break;
//            
//        default:
//            break;
//    }
//    
//    return nEffectID;
    return 0;
}

- (void) dealloc
{
	[super dealloc];
}
@end
