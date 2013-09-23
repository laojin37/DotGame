//
//  HelloWorldLayer.m
//  TouchDots
//
//  Created by lion on 9/19/13.
//  Copyright lion 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "AppDelegate.h"
#import "GrowButton.h"
#import "Ball.h"
#import "IntroLayer.h"
#import "DeviceSettings.h"
#import "ScoreManager.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		// ask director for the window size
        [self setTouchEnabled: YES];
		CGSize size = [[CCDirector sharedDirector] winSize];
//		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
        
        CCLayerColor *layer = [CCLayerColor layerWithColor:ccc4(235, 235, 235, 255) width:size.width height:size.height];
        [self addChild: layer];

        GrowButton* button1 = [GrowButton buttonWithSprite:@"btn_back.png" selectImage:@"btn_back.png" target:self selector:@selector(backAction)];
        [button1 setPosition:ccp((IS_IPAD()?60:30), size.height-(IS_IPAD()?100:50))];
        [self addChild: button1];
        
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"TIME:00:00" fontName:@"HelveticaNeue" fontSize:(IS_IPAD()?40:20)];
        [label setColor: ccc3(33, 33, 33)];
        [label setAnchorPoint:ccp(1, 0.5)];
		label.position =  ccp( size.width-30 , size.height-30 );
		[self addChild: label];
        _timeLabel = label;
        
        CCSprite* sprite = [CCSprite spriteWithFile:@"center_circle.png"];
        [sprite setPosition: ccp(size.width/2 , size.height/2)];
        [sprite setColor: ccc3(255, 255, 255)];
        [self addChild: sprite];
        
        CCTintTo *fade = [CCTintTo actionWithDuration:2 red:255 green:255 blue:255];
        CCTintTo *fade1 =[CCTintTo actionWithDuration:2 red:142 green:142 blue:142];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction: [CCSequence actions:fade, fade1, nil]];
        [sprite runAction:repeat];
        
        ccColor3B colors[MAX_DOT] = {ccc3(138, 187, 255),
            ccc3(230, 220, 37),
            ccc3(152, 100, 174),
            ccc3(239, 90, 70)
        };
        for (int i = 0; i < MAX_DOT; i ++) {
            CGPoint position = ccp((IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)/2+arc4random()%((int)(size.width-(IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)
                                                                                   )), (IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)/2+arc4random()%((int)(size.height-(IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R))));
            _touchSprite[i] = [Ball spriteWithSpriteFile: @"small_circle.png" position:position];
            [_touchSprite[i] setColor: colors[i]];
            [self addChild: _touchSprite[i]];
        }
        
        _bgSuccess = [CCSprite spriteWithFile: @"bg_success.png"];
        [_bgSuccess setColor: ccc3(224, 51, 17)];
        [_bgSuccess setPosition: ccp(size.width/2, size.height/2)];
        [self addChild: _bgSuccess];
        [_bgSuccess setVisible: NO];
        CGSize bgSize = [_bgSuccess textureRect].size;
        GrowButton* button = [GrowButton buttonWithSprite:@"btn_tryagain.png" selectImage:@"btn_tryagain.png" target:self selector:@selector(tryagainAction)];
        [button setPosition:ccp(bgSize.width/2, bgSize.height/4.0f)];
        [_bgSuccess addChild: button];
        
		label = [CCLabelTTF labelWithString:@"TIME:00:00" fontName:@"HelveticaNeue" fontSize:(IS_IPAD()?40:20)];
		label.position =  ccp( bgSize.width/2 , bgSize.height*2/4.0f + 10 );
		[_bgSuccess addChild: label];
        _timeLabel1 = label;

		label = [CCLabelTTF labelWithString:@"SUCCESS!" fontName:@"HelveticaNeue" fontSize:(IS_IPAD()?40:20)];
		label.position =  ccp( bgSize.width/2 , bgSize.height*3/4.0f + 10 );
		[_bgSuccess addChild: label];
        _bGameOn = YES;
        [self scheduleUpdate];
        m_lStartTime = [self GetCurrentTime];
	}
	return self;
}

- (void) backAction {
    ccColor3B color;
	color.r = 0x0;
	color.g = 0x0;
	color.b = 0x0;
	CCTransitionScene *ts = [CCTransitionFade transitionWithDuration:1.0f scene:[IntroLayer node] withColor:color];
	[[CCDirector sharedDirector] replaceScene:ts];
}

- (void) updateDotRandPosition {
    CGSize size = [[CCDirector sharedDirector] winSize];
    for (int i = 0; i < MAX_DOT; i ++) {
        float x = (IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)/2+arc4random()%((int)(size.width-(IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)
                                                       ));
        float y = (IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)/2+arc4random()%((int)(size.height-(IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)));
        CGPoint position = ccp(x, y);
        [_touchSprite[i] setPosition: position];
        [_touchSprite[i] setCaptureWithTouch:NO touch:nil];
    }
}

- (unsigned long) GetCurrentTime
{
	struct timeval tv;
	gettimeofday(&tv, NULL);
	unsigned long ms = tv.tv_sec * 1000L + tv.tv_usec / 1000L;
	return ms;
}


- (void) tryagainAction {
    [self updateDotRandPosition];
    _bGameOn = YES;
    m_lStartTime = [self GetCurrentTime];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    id move = [CCMoveTo actionWithDuration:1 position:ccp(winSize.width/2, -200)];
    id ease_out = [CCEaseElasticOut actionWithAction:move period:0.5f];
    [_bgSuccess runAction: ease_out];
}

- (void) update:(ccTime)delta {
    if (!_bGameOn)
        return;
    long pastTime = ([self GetCurrentTime] - m_lStartTime);
	int nTime = (int)(pastTime / 1000);
    int nMinutes = (int)nTime/60;
    int nSec = (int) nTime%60;
    
    [_timeLabel setString: [NSString stringWithFormat: @"TIME:%02d:%02d", nMinutes, nSec]];
    
    for (int i = 0; i < MAX_DOT; i ++) {
        [_touchSprite[i] updatePosition];
    }
    
    if ([self checkGameSuccess]) {
        _bGameOn = NO;
        [[ScoreManager sharedScoreManager] submitScore:1 nCorrect:1 nMiss:1 nScore:pastTime];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [_bgSuccess setPosition:ccp(winSize.width/2, -200)];
        [_bgSuccess setVisible: YES];

        long pastTime = ([self GetCurrentTime] - m_lStartTime);
        int nTime = (int)(pastTime / 1000);
        int nMinutes = (int)nTime/60;
        int nSec = (int) nTime%60;
        [_timeLabel1 setString: [NSString stringWithFormat: @"TIME:%02d:%02d", nMinutes, nSec]];
        
        id move = [CCMoveTo actionWithDuration:1 position:ccp(winSize.width/2, winSize.height/2)];
        id ease_out = [CCEaseElasticOut actionWithAction:move period:0.5f];
        [_bgSuccess runAction: ease_out];
    }
}

- (BOOL) checkGameSuccess {
    BOOL bSuccess = YES;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    for (int i = 0; i < MAX_DOT; i ++) {
        [_touchSprite[i] updatePosition];
        if (![self containPoint1:ccp(winSize.width/2, winSize.height/2)  targetCircleCenterPoint:_touchSprite[i].position fCheckR:(IS_IPAD()?CENTER_CIRCLE_HD_R:CENTER_CIRCLE_R)]) {
            bSuccess = NO;
            break;
        }
        if (_touchSprite[i].touch == nil) {
            bSuccess = NO;
            break;
        }
    }
    return bSuccess;
}

- (BOOL) containPoint1: (CGPoint) centerPoint targetCircleCenterPoint: (CGPoint) targetCircleCenterPoint fCheckR: (float) fCheckR {
    float fDX = fabsf(centerPoint.x - targetCircleCenterPoint.x);
    float fDY = fabsf(centerPoint.y - targetCircleCenterPoint.y);
    float fR = sqrtf(powf(fDX, 2) + pow(fDY, 2));
    
    if (fR > (fCheckR-(IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)))
        return NO;
    return YES;
}

- (BOOL) containPoint: (CGPoint) centerPoint targetCircleCenterPoint: (CGPoint) targetCircleCenterPoint fCheckR: (float) fCheckR {
    float fDX = fabsf(centerPoint.x - targetCircleCenterPoint.x);
    float fDY = fabsf(centerPoint.y - targetCircleCenterPoint.y);
    float fR = sqrtf(powf(fDX, 2) + pow(fDY, 2));
    
    if (fR > fCheckR)
        return NO;
    return YES;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_bGameOn)
        return;
    
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:[touch view]];
    loc = [[CCDirector sharedDirector] convertToGL:loc];
    
    NSArray *touchArray=[touches allObjects];
    
    for (int i = 0; i < [touchArray count]; i ++) {
        UITouch* touch = (UITouch*)[touchArray objectAtIndex: i];
        CGPoint loc = [touch locationInView:[touch view]];
        loc = [[CCDirector sharedDirector] convertToGL:loc];
        
        for (int i = 0; i < MAX_DOT; i ++) {
            if ([self containPoint: loc targetCircleCenterPoint:_touchSprite[i].position fCheckR:(IS_IPAD()?TOUCH_CIRCLE_HD_R:TOUCH_CIRCLE_R)]) {
                [_touchSprite[i] setCaptureWithTouch:YES touch:touch];
                break;
            }
        }
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_bGameOn)
        return;

    NSArray *touchArray=[touches allObjects];
    
    for (int i = 0; i < [touchArray count]; i ++) {
        UITouch* touch = (UITouch*)[touchArray objectAtIndex: i];
        CGPoint loc = [touch locationInView:[touch view]];
        loc = [[CCDirector sharedDirector] convertToGL:loc];
        
        for (int i = 0; i < MAX_DOT; i ++) {
            if (touch == _touchSprite[i].touch) {
                [_touchSprite[i] setPosition: loc];
            }
        }
    }    
}
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_bGameOn)
        return;

    NSArray *touchArray=[touches allObjects];
    
    for (int i = 0; i < [touchArray count]; i ++) {
        UITouch* touch = (UITouch*)[touchArray objectAtIndex: i];
        
        for (int i = 0; i < MAX_DOT; i ++) {
            if (touch == _touchSprite[i].touch) {
                [_touchSprite[i] setCaptureWithTouch:NO touch: nil];
            }
        }
    }
}
- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_bGameOn)
        return;

    NSArray *touchArray=[touches allObjects];
    
    for (int i = 0; i < [touchArray count]; i ++) {
        UITouch* touch = (UITouch*)[touchArray objectAtIndex: i];
        
        for (int i = 0; i < MAX_DOT; i ++) {
            if (touch == _touchSprite[i].touch) {
                [_touchSprite[i] setCaptureWithTouch:NO touch: nil];
            }
        }
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
