//
//  DJAppDelegate.h
//  jogoDaMemoria
//
//  Created by Dojo on 23/10/13.
//  Copyright (c) 2013 Dojo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMLoginViewController;

@interface JMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) JMLoginViewController *viewController;

@end
