//
//  IntroLayer.h
//  TouchDots
//
//  Created by lion on 9/19/13.
//  Copyright lion 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface IntroLayer : CCLayer
{
    CCSprite* _spriteHeadphoneJack;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
- (void) headIconUpdate;


@end
