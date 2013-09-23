//
//  ScoreManager.h
//  fruitGame
//
//  Created by KCU on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLDatabase.h"

@interface ScoreManager : NSObject {
	SQLDatabase*	m_sqlManager;
}

+ (ScoreManager*) sharedScoreManager;
+ (void) releaseScoreManager;

- (id) init;

- (NSArray*) loadZooElements;
- (void) deleteElement: (int) nId;
- (void) updateElement: (int) nId x:(float) x y: (float) y;
- (int) addElement: (int) nElementId x: (float) x y: (float) y w: (float) w h: (float) h;
- (int) genNewElementId;

- (NSArray*) loadAllMode0;
- (NSArray*) loadAllMode1;
- (NSArray*) loadAllMode2;
- (NSArray*) loadAllMode3;
- (NSArray*) loadAllMode4;

- (void) submitScore: (int) nMode 
			nCorrect: (int) nCorrect 
			   nMiss: (int) nMiss 
			  nScore: (int) nScore;

@end
