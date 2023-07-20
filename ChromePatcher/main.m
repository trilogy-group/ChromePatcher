//
//  main.m
//  ChromePatcher
//
//  Created by Raul Guerrero on 20/07/23.
//

#import "ChromePatcher.h"
#import "ChromeObserver.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ChromePatcher *patcher = [[ChromePatcher alloc] init];
        ChromeObserver *observer = [[ChromeObserver alloc] init];
        observer.chromePatcher = patcher;
        [[NSRunLoop mainRunLoop] run];
    }
    return 0;
}
