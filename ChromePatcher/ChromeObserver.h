//
//  ChromeObserver.h
//  ChromePatcher
//
//  Created by Raul Guerrero on 20/07/23.
//

#ifndef ChromeObserver_h
#define ChromeObserver_h

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import "ChromePatcher.h"

@interface ChromeObserver : NSObject

@property (nonatomic) NSNotificationCenter* notificationCenter;
@property (nonatomic) ChromePatcher* chromePatcher;

- (void)applicationDidActivate:(NSNotification *)notification;
- (instancetype)init;
- (void)dealloc;

@end

#endif /* ChromeObserver_h */
