//
//  Ball.h
//  TouchDots
//
//  Created by lion on 9/19/13.
//  Copyright 2013 lion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define TOUCH_CIRCLE_HD_R  128
#define TOUCH_CIRCLE_R  64

@interface Ball : CCSprite {
    UITouch* touch;
    BOOL _captured;
    
    float speed;
    float vecx;
    float vecy;
}

@property (nonatomic, assign) UITouch* touch;
@property (nonatomic) BOOL captured;
@property (nonatomic) float speed;
@property (nonatomic) float vecx;
@property (nonatomic) float vecy;


+(id)spriteWithSpriteFile:(NSString*)filename position:(CGPoint) position;
-(id) initWithSpriteFile: (NSString*) strFileName position:(CGPoint) position;

- (void) setCaptureWithTouch:(BOOL)captured touch: (UITouch*) touch;
- (void) updatePosition;
- (void) vecUpdate;
@end
