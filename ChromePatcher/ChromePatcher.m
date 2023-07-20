//
//  ChromePatcher.m
//  ChromePatcher
//
//  Created by Raul Guerrero on 20/07/23.
//

#import "ChromePatcher.h"

@implementation ChromePatcher

- (void)patch {
    NSMutableArray *paths = [NSMutableArray array];

    [paths addObject:@"/System/Applications/Google Chrome.app"];
    [paths addObject:@"/Applications/Google Chrome.app"];

    // add the Applications folder paths for all users in the system
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *usersDirectoryPath = @"/Users";
    NSArray *userDirectories = [fileManager contentsOfDirectoryAtPath:usersDirectoryPath error:nil];
    for (NSString *userDirectory in userDirectories) {
        NSString *applicationsDirectory = [NSString stringWithFormat:@"%@/%@/Applications", usersDirectoryPath, userDirectory];
        BOOL isDir;
        if ([fileManager fileExistsAtPath:applicationsDirectory isDirectory:&isDir] && isDir) {
            [paths addObject:[applicationsDirectory stringByAppendingString:@"/Google Chrome.app"]];
        }
    }

    // Get bundle for each path, if exists check if it's patcher, if not, patch it
    for (NSString *chromePath in paths) {
        NSBundle *appBundle = [NSBundle bundleWithPath:chromePath];
        if (appBundle) {
            NSString *bundleIdentifier = [appBundle bundleIdentifier];
            NSLog(@"The bundle %@ exists in path %@", bundleIdentifier, chromePath);

            //check if requires patching
            BOOL requiresPatch = true;
            if (requiresPatch) {
                // patch

            }
        }
    }
}

- (void)patch:(NSRunningApplication *)openedChrome; {
    // Add known Applications paths and bundlePath if provided from ChromeObserver
    NSString *chromePath = [[openedChrome bundleURL] path];
    NSBundle *appBundle = [NSBundle bundleWithPath:chromePath];
    if (appBundle) {
        NSString *bundleIdentifier = [appBundle bundleIdentifier];
        NSLog(@"The bundle %@ exists in path %@", bundleIdentifier, chromePath);
        
        // Check if requires patching
        BOOL requiresPatch = true;
        if (requiresPatch) {
            // close the app
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_async(queue, ^{
                [openedChrome terminate];
                while (![openedChrome isTerminated]) {
                    // Sleep for a bit to prevent this loop from spinning too fast
                    [NSThread sleepForTimeInterval:0.1];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    // patch

                    // and reopen
                    NSTask *task = [[NSTask alloc] init];
                    [task setLaunchPath:@"/usr/bin/open"];
                    [task setArguments:@[chromePath]];
                    [task launch];
                    exit(0);
                });
            });
        }
    }
}

- (void)doPatch:(NSTimer *)timer {
    [self patch];
}

- (instancetype)init {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(doPatch:) userInfo:nil repeats:YES];
    return self;
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end
