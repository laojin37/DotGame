//
//  GrowButton.h
//  Game
//
//  Created by hrh on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define Tag_Item	1

@interface GrowButton : CCMenu 
{    
}

+ (GrowButton*)buttonWithSprite:(NSString*)normalImage
					selectImage: (NSString*) selectImage
					  target:(id)target
					selector:(SEL)sel;

+ (GrowButton*)buttonWithSpriteFrame_none:(NSString*) frameName 
                          selectframeName:(NSString *)selectframeName
                                   target:(id)target
                                 selector:(SEL)sel;

- (void) enable:(BOOL)isEnable;

+ (GrowButton*)buttonWithSpriteFrame:(NSString*)frameName 
                     selectframeName: (NSString*) selectframeName
                              target:(id)target
                            selector:(SEL)sel;

+ (GrowButton*)buttonWithDisableSpriteFrame:(NSString*)frameName 
                            selectframeName: (NSString*) selectframeName
                           disableframeName: (NSString*) disableframeName
                                     target:(id)target
                                   selector:(SEL)sel;

@end
