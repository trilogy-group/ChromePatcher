//
//  ChromeObserver.m
//  ChromePatcher
//
//  Created by Raul Guerrero on 20/07/23.
//

#import "ChromeObserver.h"

@implementation ChromeObserver

- (void)applicationDidActivate:(NSNotification *)notification {
    NSRunningApplication *app = [[notification userInfo] objectForKey:NSWorkspaceApplicationKey];
    if ([[app localizedName] isEqualToString:@"Google Chrome"]) {
        [self.chromePatcher patch:app];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.notificationCenter = [[NSWorkspace sharedWorkspace] notificationCenter];
        [self.notificationCenter addObserver:self selector:@selector(applicationDidActivate:) name:NSWorkspaceDidActivateApplicationNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [self.notificationCenter removeObserver:self];
}

@end
