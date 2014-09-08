//
//  GameFactory.m
//  Pirate Game
//
//  Created by Sean McBride on 9/2/14.
//  Copyright (c) 2014 Sean McBride. All rights reserved.
//

#import "GameFactory.h"
#import "Character.h"

@implementation GameFactory

//I want to change this to accept parameters for the number of rows and the number of columns
//All edges of the gameboard would be considered beaches and one of the beaches would be the shipwreck location where the player starts the game
//All non-edge locations would be random types of locations...
+ (NSMutableArray *) generateGameBoard {
    Tile *tileOne = [[Tile alloc] init];
    tileOne.textDescription = @"Your ship has crashlanded on a sandy beach. You see the Ocean to the South and West as far as the eyes can see.";
    tileOne.backgroundImage = [UIImage imageNamed:@"shipwreck.jpg"];
    
    Tile *tileTwo = [[Tile alloc] init];
    tileTwo.textDescription = @"A sandy beach. You see the Ocean to the South as far as the eyes can see.";
    tileTwo.backgroundImage = [UIImage imageNamed:@"beach.jpg"];

    Tile *tileThree = [[Tile alloc] init];
    tileThree.textDescription = @"A sandy beach. You see the Ocean to the South as far as the eyes can see.";
    tileThree.backgroundImage = [UIImage imageNamed:@"beach.jpg"];
    
    Tile *tileFour = [[Tile alloc] init];
    tileFour.textDescription = @"A sandy beach. You see the Ocean to the South and East as far as the eyes can see.";
    tileFour.backgroundImage = [UIImage imageNamed:@"beach.jpg"];
    
    Tile *tileFive = [[Tile alloc] init];
    tileFive.textDescription = @"A sandy beach. You see the Ocean to the West as far as the eyes can see.";
    tileFive.backgroundImage = [UIImage imageNamed:@"beach.jpg"];
    
    Tile *tileSix = [[Tile alloc] init];
    tileSix.textDescription = @"A grassy hill.";
    tileSix.backgroundImage = [UIImage imageNamed:@"grassyhill.jpg"];
    
    Tile *tileSeven = [[Tile alloc] init];
    tileSeven.textDescription = @"A grassy hill.";
    tileSeven.backgroundImage = [UIImage imageNamed:@"grassyhill.jpg"];
    
    Tile *tileEight = [[Tile alloc] init];
    tileEight.textDescription = @"A sandy beach. You see the Ocean to the East as far as the eyes can see.";
    tileEight.backgroundImage = [UIImage imageNamed:@"beach.jpg"];
    
    Tile *tileNine = [[Tile alloc] init];
    tileNine.textDescription = @"A sandy beach. You see the Ocean to the North and West as far as the eyes can see.";
    tileNine.backgroundImage = [UIImage imageNamed:@"beach.jpg"];
    
    Tile *tileTen = [[Tile alloc] init];
    tileTen.textDescription = @"A sandy beach. You see the Ocean to the North as far as the eyes can see.";
    tileTen.backgroundImage = [UIImage imageNamed:@"beach.jpg"];
    
    Tile *tileEleven = [[Tile alloc] init];
    tileEleven.textDescription = @"A sandy beach. You see the Ocean to the North as far as the eyes can see.";
    tileEleven.backgroundImage = [UIImage imageNamed:@"beach.jpg"];
    
    Tile *tileTwelve = [[Tile alloc] init];
    tileTwelve.textDescription = @"A sandy beach. You see the Ocean to the North and East as far as the eyes can see.";
    tileTwelve.backgroundImage = [UIImage imageNamed:@"beach.jpg"];
    
    NSMutableArray *columnOne = [[NSMutableArray alloc] init];
    [columnOne addObject:tileOne];
    [columnOne addObject:tileFive];
    [columnOne addObject:tileNine];
    
    NSMutableArray *columnTwo = [[NSMutableArray alloc] init];
    [columnTwo addObject:tileTwo];
    [columnTwo addObject:tileSix];
    [columnTwo addObject:tileTen];
    
    NSMutableArray *columnThree = [[NSMutableArray alloc] init];
    [columnThree addObject:tileThree];
    [columnThree addObject:tileSeven];
    [columnThree addObject:tileEleven];
    
    NSMutableArray *columnFour = [[NSMutableArray alloc] init];
    [columnFour addObject:tileFour];
    [columnFour addObject:tileEight];
    [columnFour addObject:tileTwelve];
    
    NSMutableArray *gameBoard = [[NSMutableArray alloc] init];
    [gameBoard addObject:columnOne];
    [gameBoard addObject:columnTwo];
    [gameBoard addObject:columnThree];
    [gameBoard addObject:columnFour];
    return gameBoard;
}

+ (CGPoint) randomLocationOnGameboard:(NSMutableArray *) gameBoard {
    int randomX = (arc4random() % [gameBoard count]); // [self.gameBoard count] the X coordinate
    int randomY = (arc4random() % [[gameBoard objectAtIndex:randomX] count]);
    
    //Check to make sure that the thing doesn't randomly generate at (0,0), which is the start location of the player
    while (randomX == 0 && randomY == 0) {
        randomX = (arc4random() % [gameBoard count]); // [self.gameBoard count] the X coordinate
        randomY = (arc4random() % [[gameBoard objectAtIndex:randomX] count]);

    }
    return CGPointMake(randomX, randomY);
}

+ (Character *) generateCharacter{
    Character *player = [[Character alloc] init];
    player.healthTotal = 100;
    player.currentHealth = 100;
    player.currentLocation = CGPointMake(0, 0);
    player.equippedWeapon = [[Weapon alloc] init];
    player.equippedWeapon.name = @"Small Pirate Dagger";
    player.equippedWeapon.damageValue = 10;
    player.equippedWeapon.image = [UIImage imageNamed:@"dagger.jpg"];
    player.equippedArmor = [[Armor alloc] init];
    player.equippedArmor.name = @"Frayed Pirate Tunic";
    player.equippedArmor.image = [UIImage imageNamed:@"rags.jpg"];
    player.equippedArmor.armorValue = 0.1;
    return player;
}

+ (Enemy *) generateEnemy{
    Enemy *enemyOne = [[Enemy alloc] init];
    enemyOne.name = @"Blackbeard";
    enemyOne.healthTotal = 50;
    enemyOne.currentHealth = enemyOne.healthTotal;
    enemyOne.damageValue = 25;
    enemyOne.cooldownTime = 5;
    enemyOne.enemyImage = [UIImage imageNamed:@"Blackbeard.jpg"];
    NSArray *myEnemies = [[NSArray alloc] initWithObjects:enemyOne, nil];
    return [myEnemies objectAtIndex:(arc4random() % [myEnemies count])];
}

+ (Weapon *) generateWeapon{
    Weapon *weaponOne = [[Weapon alloc] init];
    weaponOne.name = @"Spanish Cutlass";
    weaponOne.damageValue = 20;
    weaponOne.image = [UIImage imageNamed:@"cutlass.png"];
    Weapon *weaponTwo = [[Weapon alloc] init];
    weaponTwo.name = @"Pistol";
    weaponTwo.damageValue = 30;
    weaponTwo.image = [UIImage imageNamed:@"flintlock pistol.jpg"];
    NSArray *myWeapons = [[NSArray alloc] initWithObjects:weaponOne, weaponTwo, nil];
    return [myWeapons objectAtIndex:(arc4random() % [myWeapons count])];
}

+ (Armor *) generateArmor{
    Armor *armorOne = [[Armor alloc] init];
    armorOne.name = @"Spanish Armor";
    armorOne.armorValue = 0.5;
    armorOne.image = [UIImage imageNamed:@"conquistador.jpg"];
    Armor *armorTwo = [[Armor alloc] init];
    armorTwo.name = @"Quilted Armor";
    armorTwo.armorValue = 0.2;
    armorTwo.image = [UIImage imageNamed:@"clotharmor.jpg"];
    NSArray *myArmor = [[NSArray alloc] initWithObjects:armorOne, armorTwo, nil];
    return [myArmor objectAtIndex:(arc4random() % [myArmor count])];
}

@end
