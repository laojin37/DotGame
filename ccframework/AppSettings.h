//
//  AppSetting.h
//  fruitGame
//
//  Created by KCU on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppSettings : NSObject 
{

}

+ (void) defineUserDefaults;

+ (void) setBackgroundVolume: (float) fVolume;
+ (void) setBGM: (BOOL) bFlag;
+ (void) setEffect: (BOOL) bFlag;
+ (void) setEffectVolume: (float) fVolume;

+ (float) backgroundVolume;
+ (BOOL)  getBGM;
+ (BOOL)  getEffect;
+ (float) effectVolume;

+ (void) setLevelFlag: (int) index flag: (BOOL) flag;
+ (BOOL) getLevelFlag: (int) index;
+ (void) setItemFlag: (int) index flag: (BOOL) flag;
+ (BOOL) getItemFlag: (int) index;

+(void) setCurrentLevel: (int) index ;
+ (int) getCurrentLevel;
+ (int) getCurrentStage;
+ (void) setCurrentStage:(int)nStage;

+ (int) getMaxLevel;
+ (void) setStartLevel: (int) index;
+ (int)  getStartLevel;

+ (int) getStartStage;
+ (void) setStartStage:(int)nStage;

+ (int) getHighScore;
+ (void) setHighScore:(int)nScore;
+ (void) setScore: (int) score;

+ (int) getScore:(int)nlevel;
+ (void) setScore:(int)nlevel nScore:(int) nScore;
+ (void) setScore: (int) score;
+ (int)  getScore;
+ (void) setBestScore: (int) bestScore;
+ (int)  getBestScore;
+ (void) setPaperScore: (int) paperScore;
+ (int)  getPaperScore;
+ (void) setIntValueWithName: (int) nValue name: (NSString*) strName;
+ (int)  getIntValue: (NSString*) strName;

+ (BOOL) isUnlockedLevel: (int) nLevel;
+ (BOOL) isUnlockedStage: (int) nLevel nStage: (int) nStage;
+ (void) unlockLevel: (int) nLevel;
+ (void) unlockStage: (int) nLevel nStage: (int) nStage;

+ (int) starCountOfStage: (int) nLevel nStage: (int) nStage;
+ (void) setStarCountOfStage: (int) nLevel nStage: (int) nStage nStar: (int) nStar;
@end
