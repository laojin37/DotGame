//
//  Ball.m
//  TouchDots
//
//  Created by lion on 9/19/13.
//  Copyright 2013 lion. All rights reserved.
//

#import "Ball.h"
#import "DeviceSettings.h"

@implementation Ball
@synthesize touch;
@synthesize captured, speed, vecx, vecy;

+(id)spriteWithSpriteFile:(NSString*)filename position:(CGPoint) position
{
	return [[[self alloc] initWithSpriteFile:filename position: position] autorelease];
}

-(id) initWithSpriteFile: (NSString*) filename position:(CGPoint) position
{
    if( (self=[super initWithFile:filename]))
    {
        self.position = position;
        self.captured = NO;
        [self vecUpdate];
    }
    return self;
}

- (void) vecUpdate {
    self.speed = arc4random()%4+1;
    self.vecx = (arc4random()%10 > 5)?1:-1;
    self.vecy = (arc4random()%10 > 5)?1:-1;
}

- (void) speedUpdate {
    self.speed = arc4random()%4+1;
}

- (void) setCaptureWithTouch:(BOOL)captured touch: (UITouch*) touch {
    self.captured = captured;
    self.touch = touch;
    [self vecUpdate];
}

- (void) updatePosition {
    if (self.captured == YES)
        return;
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float x = self.position.x + vecx*speed;
    float y = self.position.y + vecy*speed;

    if (x < (IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)/2) {
        vecx = 1;
        [self speedUpdate];
    }
    if (x > (winSize.width-(IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)/2)) {
        vecx = -1;
        [self speedUpdate];
    }
    if (y < TOUCH_CIRCLE_R/2) {
        vecy = 1;
        [self speedUpdate];
    }
    if (y > (winSize.height-(IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)/2)) {
        vecy = -1;
        [self speedUpdate];
    }

    self.position = ccp(x, y);
}

@end
