//
//  AppSetting.m
//  fruitGame
//
//  Created by KCU on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppSettings.h"


@implementation AppSettings

+ (void) defineUserDefaults
{
	NSString* userDefaultsValuesPath;
	NSDictionary* userDefaultsValuesDict;
	
	// load the default values for the user defaults
	userDefaultsValuesPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
	userDefaultsValuesDict = [NSDictionary dictionaryWithContentsOfFile: userDefaultsValuesPath];
	[[NSUserDefaults standardUserDefaults] registerDefaults: userDefaultsValuesDict];
}

+ (void) setBackgroundVolume: (float) fVolume
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aVolume  =	[[NSNumber alloc] initWithFloat: fVolume];	
	[defaults setObject:aVolume forKey:@"music"];	
	[NSUserDefaults resetStandardUserDefaults];	
}

+ (void) setBGM: (BOOL) bFlag
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aVolume  =	[[NSNumber alloc] initWithBool: bFlag];	
	[defaults setObject:aVolume forKey:@"BGM"];	
	[NSUserDefaults resetStandardUserDefaults];	    
}

+ (void) setEffect: (BOOL) bFlag
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aVolume  =	[[NSNumber alloc] initWithBool: bFlag];	
	[defaults setObject:aVolume forKey:@"Effect"];	
	[NSUserDefaults resetStandardUserDefaults];	        
}

+ (BOOL)  getBGM
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults  boolForKey :@"BGM"];
}

+ (BOOL)  getEffect
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey :@"Effect"];
}


+ (float) backgroundVolume
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults floatForKey:@"music"];
}

+ (void) setEffectVolume: (float) fVolume
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aVolume  =	[[NSNumber alloc] initWithFloat: fVolume];	
	[defaults setObject:aVolume forKey:@"effect"];	
	[NSUserDefaults resetStandardUserDefaults];	
}

+ (float) effectVolume
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults floatForKey:@"effect"];
	
}

+ (void) setLevelFlag: (int) index flag: (BOOL) flag
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[NSNumber numberWithFloat: flag];	
	[defaults setObject:aFlag forKey:[NSString stringWithFormat: @"level%d", index]];	
	[NSUserDefaults resetStandardUserDefaults];		
}

+ (BOOL) getLevelFlag: (int) index
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];	
	return [defaults boolForKey: [NSString stringWithFormat: @"level%d", index]];	
}

+ (void) setItemFlag: (int) index flag: (BOOL) flag
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[NSNumber numberWithFloat: flag];	
	[defaults setObject:aFlag forKey:[NSString stringWithFormat: @"item%d", index]];	
	[NSUserDefaults resetStandardUserDefaults];		
}

+ (BOOL) getItemFlag: (int) index
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];	
	return [defaults boolForKey: [NSString stringWithFormat: @"item%d", index]];	
}

+(void) setStartLevel: (int) index 
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[NSNumber numberWithFloat: index];	
	[defaults setObject:aFlag forKey: @"startLevel"];	
	[NSUserDefaults resetStandardUserDefaults];
}

+ (int) getStartLevel
{
    return [self getIntValue: @"startLevel"];
}

+(void) setCurrentLevel: (int) index 
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[NSNumber numberWithFloat: index];	
	[defaults setObject:aFlag forKey: @"curLevel"];	
	[NSUserDefaults resetStandardUserDefaults];
}

+ (int) getCurrentLevel
{
    return [self getIntValue: @"curLevel"];
}

+ (int) getMaxLevel
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	int maxLevel = (int)[defaults integerForKey: @"maxLevel"];
	return maxLevel;
}

#pragma mark -
#pragma mark Set and get the score, best score, paper score.

+ (int) getStartStage
{
    return [self getIntValue: @"startStage"];
}

+ (void) setStartStage:(int)nStage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[NSNumber numberWithFloat: nStage];	
	[defaults setObject:aFlag forKey: @"startStage"];	
	[NSUserDefaults resetStandardUserDefaults];
}

+ (int) getCurrentStage
{
    return [self getIntValue: @"curStage"];
}

+ (void) setCurrentStage:(int)nStage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[NSNumber numberWithFloat: nStage];	
	[defaults setObject:aFlag forKey: @"curStage"];	
	[NSUserDefaults resetStandardUserDefaults];
}

+ (void) setScore: (int) score
{
    [self setIntValueWithName: score name: @"score"];
}

+ (void) setScore:(int)nlevel nScore:(int) nScore
{
    if ([AppSettings getScore:nlevel] >= nScore) {
        return;
    }
    
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* score  =	[NSNumber numberWithUnsignedLongLong: nScore];
    
	[defaults setObject:score forKey:[NSString stringWithFormat:@"level_score%d", nlevel]];
	[NSUserDefaults resetStandardUserDefaults];	
}

+ (int) getScore:(int)nlevel
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* score = [defaults objectForKey:[NSString stringWithFormat:@"level_score%d", nlevel]];
    return [score intValue];
}

+ (int) getHighScore
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* score = [defaults objectForKey:@"score"];
    return [score intValue];
}

+ (void) setHighScore:(int)nScore
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* score  =	[NSNumber numberWithUnsignedLongLong: nScore];
    
	[defaults setObject:score forKey:@"score"];
	[NSUserDefaults resetStandardUserDefaults];	
}

+ (int) getScore
{
    return [self getIntValue: @"score"];
}

+ (void) setBestScore: (int) bestScore
{
	[self setIntValueWithName: bestScore name: @"best_score"];
}

+ (int) getBestScore
{
    return [self getIntValue: @"best_score"];
}

+ (void) setPaperScore: (int) paperScore
{
	[self setIntValueWithName: paperScore name: @"paper_score"];
}

+ (int) getPaperScore
{
    return [self getIntValue: @"paper_score"];
}

+ (void) setIntValueWithName: (int) nValue name: (NSString*) strName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[NSNumber numberWithFloat: nValue];	
	[defaults setObject:aFlag forKey: strName];	
	[NSUserDefaults resetStandardUserDefaults];
}

+ (int) getIntValue: (NSString*) strName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	int score = (int)[defaults integerForKey: strName];
	return score;
}

+ (BOOL) isUnlockedLevel: (int) nLevel {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey: [NSString stringWithFormat:@"unlocklevel_%d", nLevel]];
    
}
+ (BOOL) isUnlockedStage: (int) nLevel nStage: (int) nStage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey: [NSString stringWithFormat:@"unlockstage_%d%02d", nLevel, nStage]];
}

+ (void) unlockLevel: (int) nLevel {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[NSNumber numberWithBool: YES];	
	[defaults setObject:aFlag forKey: [NSString stringWithFormat:@"unlocklevel_%d", nLevel]];	
	[NSUserDefaults resetStandardUserDefaults];
}
+ (void) unlockStage: (int) nLevel nStage: (int) nStage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[NSNumber numberWithBool: YES];	
	[defaults setObject:aFlag forKey: [NSString stringWithFormat:@"unlockstage_%d%02d", nLevel, nStage]];	
	[NSUserDefaults resetStandardUserDefaults];
}

+ (int) starCountOfStage: (int) nLevel nStage: (int) nStage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults integerForKey: [NSString stringWithFormat:@"star_%d%02d", nLevel, nStage]];
}

+ (void) setStarCountOfStage: (int) nLevel nStage: (int) nStage nStar: (int) nStar {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[NSNumber numberWithInt: nStar];	
	[defaults setObject:aFlag forKey: [NSString stringWithFormat:@"star_%d%02d", nLevel, nStage]];	
	[NSUserDefaults resetStandardUserDefaults];
}


@end
