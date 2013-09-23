//
//  HistoryLayer.m
//  TouchDots
//
//  Created by lion on 9/23/13.
//  Copyright 2013 lion. All rights reserved.
//

#import "HistoryLayer.h"
#import "IntroLayer.h"
#import "DeviceSettings.h"
#import "ScoreManager.h"
@implementation HistoryLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HistoryLayer *layer = [HistoryLayer node];
	
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
        [self setTouchEnabled:YES];
		CGSize size = [[CCDirector sharedDirector] winSize];
        CCLayerColor *layer = [CCLayerColor layerWithColor:ccc4(235, 235, 235, 255) width:size.width height:size.height];
        [self addChild: layer];

        float x = size.width/2;
        float y = size.height - (IS_IPAD()?160:80);
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"BEST TIME" fontName:@"HelveticaNeue" fontSize:(IS_IPAD()?60:30)];
        [label setColor: ccc3(239, 93, 74)];
		label.position =  ccp( x , y );
		[self addChild: label];
        
        NSArray* array = [[ScoreManager sharedScoreManager] loadAllMode1];
        
        for (int i = 0; i < 10; i ++) {
            CCLabelTTF* label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d.", i+1] fontName:@"HelveticaNeue" fontSize:(IS_IPAD()?60:30)];
            [label1 setColor: ccc3(156, 102, 173)];
            label1.position =  ccp( size.width/2 - (IS_IPAD()?150:75) , y - (IS_IPAD()?80:40)*(i+1) );
            [self addChild: label1];

            int nPastTime = 0;
            if ([array count] > i) {
                NSDictionary*dic = [array objectAtIndex: i];
                nPastTime = [[dic objectForKey: @"score"] integerValue];
            }
            
            NSString *strTime = @"--";
            if (nPastTime > 0) {
                int nTime = (int)(nPastTime / 1000);
                int nMinutes = (int)nTime/60;
                int nSec = (int) nTime%60;
                strTime = [NSString stringWithFormat: @"%02d:%02d", nMinutes, nSec];
            }
            
            CCLabelTTF* label2 = [CCLabelTTF labelWithString:strTime fontName:@"HelveticaNeue" fontSize:(IS_IPAD()?60:30)];
            [label2 setColor: ccc3(156, 102, 173)];
            label2.position =  ccp( size.width/2 + (IS_IPAD()?100:40), y - (IS_IPAD()?80:40)*(i+1) );
            [self addChild: label2];

        }
    }
    
    return self;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    ccColor3B color;
	color.r = 0x0;
	color.g = 0x0;
	color.b = 0x0;
	CCTransitionScene *ts = [CCTransitionFade transitionWithDuration:1.0f scene:[IntroLayer node] withColor:color];
	[[CCDirector sharedDirector] replaceScene:ts];
}

@end
