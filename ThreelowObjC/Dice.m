//
//  Dice.m
//  Threelow
//
//  Created by Natasha Machado on 2023-09-11.
//

#import "Dice.h"

@implementation Dice

- (instancetype)init {
  self = [super init];
  if (self) {
    [self reset];
  }
  return self;
}

- (void)roll {
  self.value = arc4random_uniform(6) + 1;
}

- (void)reset {
  self.value = 1;
}

- (NSString *)valueAsString {
  NSArray<NSString *> *diceValues = @[@"⚀", @"⚁", @"⚂", @"⚃", @"⚄", @"⚅"];
  return diceValues[self.value - 1];
}

@end
