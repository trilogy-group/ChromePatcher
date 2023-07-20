//
//  ChromePatcher.h
//  ChromePatcher
//
//  Created by Raul Guerrero on 20/07/23.
//

#ifndef ChromePatcher_h
#define ChromePatcher_h

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

@interface ChromePatcher : NSObject

@property (nonatomic, strong) NSTimer *timer;

- (void)patch;
- (void)patch:(NSRunningApplication *)openedChrome;
- (void)doPatch:(NSTimer *)timer;
- (instancetype)init;
@end

#endif /* ChromePatcher_h */
