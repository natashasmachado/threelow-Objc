//
//  main.m
//  Threelow
//
//  Created by Natasha Machado on 2023-09-09.
//

#import <Foundation/Foundation.h>
#import "GameController.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        GameController *gameController = [[GameController alloc] initWithDiceCount:5]; 
        [gameController play];
    }
    return 0;
}
