//
//  Dice.h
//  Threelow
//
//  Created by Natasha Machado on 2023-09-09.
//

#import <Foundation/Foundation.h>

@interface Dice : NSObject

@property (nonatomic, assign) NSInteger value;

- (void)roll;
- (void)reset;
- (NSString *)valueAsString;

@end
