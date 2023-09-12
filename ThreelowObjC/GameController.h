//
//  GameController.h
//  Threelow
//
//  Created by Natasha Machado on 2023-09-10.
//

#import <Foundation/Foundation.h>
#import "Dice.h"

@interface GameController : NSObject

@property (nonatomic, strong) NSMutableArray<Dice *> *diceArray;
@property (nonatomic, strong) NSMutableSet<Dice *> *heldDiceSet;
@property (nonatomic) NSInteger rollsSinceLastReset; 

- (instancetype)initWithDiceCount:(NSInteger)diceCount;
- (void)rollDice;
- (void)holdDie:(NSInteger)index;
- (void)resetDice;
- (NSInteger)calculateScore;
- (void)printDice;
- (BOOL)canRoll;
- (void)play;

@end
