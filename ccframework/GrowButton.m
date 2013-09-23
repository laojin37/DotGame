//
//  GrowButton.m
//  Game
//
//  Created by hrh on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GrowButton.h"
#import "AppDelegate.h"

@implementation GrowButton

+ (GrowButton*)buttonWithSprite:(NSString*)normalImage 
					selectImage:(NSString *)selectImage
						target:(id)target
					  selector:(SEL)sel
{
	CCSprite *normalSprite = [CCSprite spriteWithFile:normalImage];
	CCSprite *selectSprite = [CCSprite spriteWithFile:selectImage];

	assert(normalSprite);
	assert(selectSprite);
	
	CCMenuItem *menuItem = [CCMenuItemSprite itemFromNormalSprite:normalSprite
												   selectedSprite:selectSprite
														   target:target
														 selector:sel];
	GrowButton *menu = [GrowButton menuWithItems:menuItem, nil];
	return menu;	
}

+ (GrowButton*)buttonWithSpriteFrame:(NSString*) frameName 
					 selectframeName:(NSString *)selectframeName
							  target:(id)target
							selector:(SEL)sel
{
	CCSprite *normalSprite = [CCSprite spriteWithSpriteFrameName: frameName];
	CCSprite *selectSprite = [CCSprite spriteWithSpriteFrameName: selectframeName];
	
    NSLog(@"%@", frameName);
    NSLog(@"%@", selectframeName);
	
	CCMenuItem *menuItem = [CCMenuItemSprite itemFromNormalSprite:normalSprite
												   selectedSprite:selectSprite
														   target:target
														 selector:sel];
	GrowButton *menu = [GrowButton menuWithItems:menuItem, nil];
	return menu;	
}

+ (GrowButton*)buttonWithDisableSpriteFrame:(NSString*)frameName 
                            selectframeName: (NSString*) selectframeName
                           disableframeName: (NSString*) disableframeName
                                     target:(id)target
                                   selector:(SEL)sel {
    
	CCSprite *normalSprite = [CCSprite spriteWithSpriteFrameName: frameName];
	CCSprite *selectSprite = [CCSprite spriteWithSpriteFrameName: selectframeName];
	CCSprite *disableSprite = [CCSprite spriteWithSpriteFrameName: disableframeName];
	
    NSLog(@"%@", frameName);
	assert(normalSprite);
    NSLog(@"%@", selectframeName);
	assert(selectSprite);
	
	CCMenuItem *menuItem = [CCMenuItemSprite itemFromNormalSprite:normalSprite
												   selectedSprite:selectSprite
                                                   disabledSprite:disableSprite
														   target:target
														 selector:sel];
	GrowButton *menu = [GrowButton menuWithItems:menuItem, nil];
	return menu;	
}

+ (GrowButton*)buttonWithSpriteFrame_none:(NSString*) frameName 
					 selectframeName:(NSString *)selectframeName
							  target:(id)target
							selector:(SEL)sel
{
	CCSprite *normalSprite = [CCSprite spriteWithSpriteFrameName: frameName];
	CCSprite *selectSprite = [CCSprite spriteWithSpriteFrameName: selectframeName];
	
    NSLog(@"%@", frameName);
	assert(normalSprite);
    NSLog(@"%@", selectframeName);
	assert(selectSprite);
	
	CCMenuItem *menuItem = [CCMenuItemSprite itemFromNormalSprite:normalSprite
												   selectedSprite:selectSprite
														   target:target
														 selector:sel];
	GrowButton *menu = [GrowButton menuWithItems:menuItem, nil];
	return menu;	
}

- (void) enable:(BOOL)isEnable
{
    CCMenuItem* child;
	CCARRAY_FOREACH(_children, child) {
        child.isEnabled = isEnable;
    }
}

-(CCMenuItem *) itemForTouch: (UITouch *) touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    
	CCMenuItem* item;
	CCARRAY_FOREACH(_children, item){
		// ignore invisible and disabled items: issue #779, #866
		if ( [item visible] && [item isEnabled] ) {
            
			CGPoint local = [item convertToNodeSpace:touchLocation];
			CGRect r = [item activeArea];
            
			if( CGRectContainsPoint( r, local ) )
				return item;
		}
	}
	return nil;
}

- (void) animateFocusMenuItem: (CCMenuItem*) menuItem
{
	id movetozero = [CCScaleTo actionWithDuration:0.1f scale:1.2f];
	id ease = [CCEaseBackOut actionWithAction:movetozero];
	id movetozero1 = [CCScaleTo actionWithDuration:0.1f scale:1.15f];
	id ease1 = [CCEaseBackOut actionWithAction:movetozero1];
	id movetozero2 = [CCScaleTo actionWithDuration:0.1f scale:1.2f];
	id ease2 = [CCEaseBackOut actionWithAction:movetozero2];
	id sequence = [CCSequence actions: ease, ease1, ease2, nil];
	[menuItem runAction:sequence];	
}

- (void) animateFocusLoseMenuItem: (CCMenuItem*) menuItem
{
	id movetozero = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
	id ease = [CCEaseBackOut actionWithAction:movetozero];
	id movetozero1 = [CCScaleTo actionWithDuration:0.1f scale:1.05];
	id ease1 = [CCEaseBackOut actionWithAction:movetozero1];
	id movetozero2 = [CCScaleTo actionWithDuration:0.1f scale:1.0];
	id ease2 = [CCEaseBackOut actionWithAction:movetozero2];
	id movetozero3 = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
	id ease3 = [CCEaseBackOut actionWithAction:movetozero3];
	id sequence = [CCSequence actions: ease,ease1, ease2, ease3, nil];
	[menuItem runAction:sequence];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if( _state != kCCMenuStateWaiting || !_visible )
		return NO;
	
	_selectedItem = [self itemForTouch:touch];
	[_selectedItem selected];
	
	if( _selectedItem ) {
		[self animateFocusMenuItem: _selectedItem];
		_state = kCCMenuStateTrackingTouch;
		return YES;
	}
	return NO;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	[_selectedItem unselected];
	[_selectedItem activate];
	_state = kCCMenuStateWaiting;

	[self animateFocusLoseMenuItem: _selectedItem];
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
	[_selectedItem unselected];
	
	[self animateFocusLoseMenuItem: _selectedItem];
	_state = kCCMenuStateWaiting;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	CCMenuItem *currentItem = [self itemForTouch:touch];
	
	if (currentItem != _selectedItem) {
		[self animateFocusLoseMenuItem: _selectedItem];
		[self animateFocusMenuItem: currentItem];
		[_selectedItem unselected];
		_selectedItem = currentItem;
		[_selectedItem selected];
	}
}

@end
