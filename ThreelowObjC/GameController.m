//
//  GameController.m
//  Threelow
//
//  Created by Natasha Machado on 2023-09-09.
//

#import "GameController.h"

@implementation GameController {
    NSInteger _lowestScore;
}

- (instancetype)initWithDiceCount:(NSInteger)diceCount {
    self = [super init];
    if (self) {
        _diceArray = [NSMutableArray arrayWithCapacity:diceCount];
        _heldDiceSet = [NSMutableSet set];
        _rollsSinceLastReset = 0;
        _lowestScore = NSIntegerMax;
    }
    return self;
}

- (void)rollDice {
    for (Dice *die in self.diceArray) {
        [die roll];
    }
    self.rollsSinceLastReset++;
}

- (void)holdDie:(NSInteger)index {
    if (index >= 0 && index < [self.diceArray count]) {
        Dice *die = self.diceArray[index];
        if ([self.heldDiceSet containsObject:die]) {
            [self.heldDiceSet removeObject:die];
        } else {
            [self.heldDiceSet addObject:die];
        }
    }
}

- (void)resetDice {
    [self.heldDiceSet removeAllObjects];
    self.rollsSinceLastReset = 0;
}

- (NSInteger)calculateScore {
    NSInteger score = 0;
    for (Dice *die in self.heldDiceSet) {
        score += [die value];
    }
    return score;
}

- (void)printDice {
    NSMutableString *diceString = [NSMutableString stringWithString:@"Dice: "];
    for (Dice *die in self.diceArray) {
        NSString *dieSymbol = [self dieSymbolForValue:[die value]];
        if ([self.heldDiceSet containsObject:die]) {
            [diceString appendFormat:@"[%@] ", dieSymbol];
        } else {
            [diceString appendFormat:@"%@ ", dieSymbol];
        }
    }

    [diceString appendFormat:@"| Rolls: %ld | Score: %ld", (long)self.rollsSinceLastReset, (long)[self calculateScore]];
    NSLog(@"%@", diceString);
}

- (NSString *)dieSymbolForValue:(NSInteger)value {
    NSArray *dieSymbols = @[@"⚀", @"⚁", @"⚂", @"⚃", @"⚄", @"⚅"];
    if (value >= 1 && value <= 6) {
        return dieSymbols[value - 1];
    }
    return @"?";
}

- (BOOL)canRoll {
    return (self.rollsSinceLastReset < 5) && ([self.heldDiceSet count] < [self.diceArray count]);
}

- (void)play {
    BOOL playing = YES;
    while (playing) {
        if (![self canRoll]) {
            NSLog(@"You can't roll anymore or you need to select at least one die. Type 'reset' to reset or 'quit' to quit.");
        } else {
            NSLog(@"Type 'roll' to roll the dice, 'hold #' to hold a die, 'reset' to reset, 'score' to check the score, or 'quit' to quit.");
        }

        char input[255];
        fgets(input, 255, stdin);
        NSString *inputString = [[NSString stringWithUTF8String:input] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];

        if ([inputString isEqualToString:@"quit"]) {
            playing = NO;
        } else if ([inputString isEqualToString:@"roll"]) {
            if ([self canRoll]) {
                [self rollDice];
                [self printDice];
            } else {
                NSLog(@"You can't roll anymore or you need to select at least one die. Type 'reset' to reset or 'quit' to quit.");
            }
        } else if ([inputString isEqualToString:@"reset"]) {
            [self resetDice];
            [self printDice];
        } else if ([inputString hasPrefix:@"hold "]) {
            NSInteger dieIndex = [[inputString substringFromIndex:5] integerValue];
            if (dieIndex >= 1 && dieIndex <= [self.diceArray count]) {
                [self holdDie:dieIndex - 1];
                [self printDice];
            } else {
                NSLog(@"Invalid die number. Please enter a number between 1 and %ld.", (long)[self.diceArray count]);
            }
        } else if ([inputString isEqualToString:@"score"]) {
            NSLog(@"Current score: %ld", (long)[self calculateScore]);
        } else {
            NSLog(@"Invalid command. Type 'roll' to roll the dice, 'hold #' to hold a die, 'reset' to reset, 'score' to check the score, or 'quit' to quit.");
        }
    }
    NSLog(@"Thanks for playing!");
}

- (NSString *)diceValuesAsString {
    NSMutableString *diceValues = [NSMutableString stringWithString:@"Dice values: "];
    for (Dice *die in self.diceArray) {
        [diceValues appendFormat:@"%ld ", (long)[die value]];
    }
    return [diceValues stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (void)handleSecretTrigger:(NSString *)secretTrigger {
    if ([secretTrigger isEqualToString:@"rolll"]) {
        [self rollDice];
        [self printDice];
    } else if ([secretTrigger isEqualToString:@"resetlowscore"]) {
        [self resetLowestScore];
        NSLog(@"Lowest score has been reset.");
    }
}

- (void)resetLowestScore {
    _lowestScore = NSIntegerMax;
    NSLog(@"Lowest score has been reset.");
}

- (NSInteger)heldDiceCount {
    return [self.heldDiceSet count];
}

- (void)updateLowestScore {
    NSInteger currentScore = [self calculateScore];
    if (currentScore < _lowestScore) {
        _lowestScore = currentScore;
    }
}

@end
