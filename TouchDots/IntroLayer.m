//
//  IntroLayer.m
//  TouchDots
//
//  Created by lion on 9/19/13.
//  Copyright lion 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "HelloWorldLayer.h"
#import "GrowButton.h"
#import "AppDelegate.h"
#import "AppSettings.h"
#import "DeviceSettings.h"
#import "HistoryLayer.h"

#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        CCLayerColor *layer = [CCLayerColor layerWithColor:ccc4(235, 235, 235, 255) width:size.width height:size.height];
        [self addChild: layer];

        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite* spriteTitle = [CCSprite spriteWithFile:@"text_title.png"];
        [spriteTitle setPosition:ccp(winSize.width/2, winSize.height/2+(IS_IPAD()?200:100))];
        [self addChild: spriteTitle];
        
        GrowButton* button = [GrowButton buttonWithSprite:@"btn_play.png" selectImage:@"btn_play.png" target:self selector:@selector(actionStart)];
        [button setPosition:ccp(winSize.width/2, winSize.height/2)];
        [self addChild: button];

        GrowButton* button1 = [GrowButton buttonWithSprite:@"btn_history.png" selectImage:@"btn_history.png" target:self selector:@selector(actionHistory)];
        [button1 setPosition:ccp(winSize.width-(IS_IPAD()?100:50), winSize.height/2-(IS_IPAD()?200:100))];
        [self addChild: button1];
        
        _spriteHeadphoneJack = [CCSprite spriteWithFile:@"headphonejack.png"];
        [_spriteHeadphoneJack setPosition: ccp(size.width-30, size.height-30)];
        [_spriteHeadphoneJack setAnchorPoint: ccp(1, 1)];
        [self addChild: _spriteHeadphoneJack];
        
        [self scheduleUpdate];
        [self headIconUpdate];
	}
	
	return self;
}

- (void) update:(ccTime)delta
{
    [self headIconUpdate];
}

- (void) headIconUpdate {
    BOOL isPlugined = ((AppController*)[[UIApplication sharedApplication] delegate]).isPluginedHeadphoneJack;
    if (isPlugined) {
        [_spriteHeadphoneJack setColor: ccc3(0, 200, 0)];
    } else {
        [_spriteHeadphoneJack setColor: ccc3(200, 0, 0)];
    }
}

- (void) actionStart {
#ifndef TEST_MODE
    BOOL isPlugined = ((AppController*)[[UIApplication sharedApplication] delegate]).isPluginedHeadphoneJack;
    if (!isPlugined) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You cannot start the game unless you plug headphones into the device.\nPlease plug headphone." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
#endif
    ccColor3B color;
	color.r = 0x0;
	color.g = 0x0;
	color.b = 0x0;
	CCTransitionScene *ts = [CCTransitionFade transitionWithDuration:1.0f scene:[HelloWorldLayer node] withColor:color];
	[[CCDirector sharedDirector] replaceScene:ts];
}

- (void) actionHistory {
    ccColor3B color;
	color.r = 0x0;
	color.g = 0x0;
	color.b = 0x0;
	CCTransitionScene *ts = [CCTransitionFade transitionWithDuration:1.0f scene:[HistoryLayer node] withColor:color];
	[[CCDirector sharedDirector] replaceScene:ts];
}
-(void) onEnter
{
	[super onEnter];
}
@end
