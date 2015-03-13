//
//  AppDelegate.m
//  IOSSudoku
//
//  Created by Adam Matthew Bennett on 2/25/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(NSString*)sandBoxFileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = paths[0];
    NSString *fileName = [docDir stringByAppendingPathComponent:@"sudokuPuzzle.plist"];
    return fileName;
}

- (NSString*)randomSimpleGame{
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"simple" ofType:@"plist"];
    
    NSArray *games = [NSArray arrayWithContentsOfFile:fileName];
    NSString *game = [games objectAtIndex:arc4random() % [games count]];
    return game;
}

- (NSString*)randomHardGame{
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"hard" ofType:@"plist"];
    
    NSArray *games = [NSArray arrayWithContentsOfFile:fileName];
    NSString *game = [games objectAtIndex:arc4random() % [games count]];
    return game;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *filePath = [self sandBoxFileName];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        self.sudokuPuzzle = [[SudokuPuzzle alloc] initWithContentsOfFile:filePath];
    }else{
        self.sudokuPuzzle = [[SudokuPuzzle alloc] init];
        [self.sudokuPuzzle freshGame:[self randomHardGame]];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSString *fileName = [self sandBoxFileName];
    [self.sudokuPuzzle writeToFile:fileName];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
