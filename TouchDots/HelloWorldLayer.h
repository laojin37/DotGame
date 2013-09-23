//
//  HelloWorldLayer.h
//  TouchDots
//
//  Created by lion on 9/19/13.
//  Copyright lion 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#ifdef TEST_MODE
    #define MAX_DOT 1
#else
    #define MAX_DOT 4
#endif
#define CENTER_CIRCLE_HD_R 400
#define CENTER_CIRCLE_R 200

@class Ball;
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    Ball* _touchSprite[MAX_DOT];
    CCSprite *_bgSuccess;
    CCLabelTTF* _timeLabel;
    CCLabelTTF* _timeLabel1;
    BOOL _bGameOn;
    long m_lStartTime;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
- (BOOL) containPoint: (CGPoint) centerPoint targetCircleCenterPoint: (CGPoint) targetCircleCenterPoint fCheckR: (float) fCheckR;
- (BOOL) containPoint1: (CGPoint) centerPoint targetCircleCenterPoint: (CGPoint) targetCircleCenterPoint fCheckR: (float) fCheckR;
- (BOOL) checkGameSuccess;
- (unsigned long) GetCurrentTime;
@end
