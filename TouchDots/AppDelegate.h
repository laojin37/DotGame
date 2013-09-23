//
//  AppDelegate.h
//  TouchDots
//
//  Created by lion on 9/19/13.
//  Copyright lion 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate, AVAudioPlayerDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
    
    BOOL isPluginedHeadphoneJack;
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;
@property (nonatomic) BOOL isPluginedHeadphoneJack;

- (BOOL) isAudioJackPlugged;

@end
