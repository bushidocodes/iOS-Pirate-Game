//
//  ViewController.m
//  Pirate Game
//
//  Created by Sean McBride on 9/2/14.
//  Copyright (c) 2014 Sean McBride. All rights reserved.
//

#import "ViewController.h"
#import "GameFactory.h"
#import "Tile.h"

@interface ViewController ()

@end

@implementation ViewController
            
- (void)viewDidLoad {
//    NSLog(@"viewDidLoad called");
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.enemyName.hidden =  true;
    self.enemyHealthBar.hidden =  true;
    self.actionButtonLabel.hidden = true;
    self.gameBoard = [GameFactory generateGameBoard];
    
    self.player = [GameFactory generateCharacter];
    
    self.randomWeapon = [[Weapon alloc] init];
    self.randomWeapon = [GameFactory generateWeapon];
    self.randomWeapon.currentLocation = [GameFactory randomLocationOnGameboard:self.gameBoard];
//    self.randomWeapon.currentLocation = CGPointMake(1, 1);
    self.randomArmor = [[Armor alloc] init];
    self.randomArmor = [GameFactory generateArmor];
    self.randomArmor.currentLocation = [GameFactory randomLocationOnGameboard:self.gameBoard];
    while (CGPointEqualToPoint(self.randomArmor.currentLocation, self.randomWeapon.currentLocation) == true ) {
        self.randomArmor.currentLocation = [GameFactory randomLocationOnGameboard:self.gameBoard];
    }
//    self.randomArmor.currentLocation = CGPointMake(1, 1);
    self.randomEnemy = [[Enemy alloc] init];
    self.randomEnemy = [GameFactory generateEnemy];
    self.randomEnemy.currentLocation = [GameFactory randomLocationOnGameboard:self.gameBoard];
    while (CGPointEqualToPoint(self.randomEnemy.currentLocation, self.randomWeapon.currentLocation) == true || CGPointEqualToPoint(self.randomEnemy.currentLocation, self.randomArmor.currentLocation) == true) {
        self.randomArmor.currentLocation = [GameFactory randomLocationOnGameboard:self.gameBoard];
    }
//    self.randomEnemy.currentLocation = CGPointMake(1, 1);
    [self refreshTile];
    [self refreshDirectionButtons];
    [self refreshHealthBar];
    [self refreshEnemyHealthBar];
    [self refreshWeaponLabel];
    [self refreshArmorLabel];
    
//    NSLog(@"%@",self.randomWeapon);
//    NSLog(@"%i",self.randomWeapon.damageValue);
//    NSLog(@"%f",self.randomWeapon.currentLocation.x);
//    NSLog(@"%f",self.randomWeapon.currentLocation.y);
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)northPushed:(UIButton *)sender {
    if ([self tileExistsAtPoint: CGPointMake(self.player.currentLocation.x, self.player.currentLocation.y + 1)] == true) {
//        NSLog(@"northPushed called");
//        NSLog(@"Was at %i, %i", self.player.currentLocation.x, self.player.currentLocation.y);
        self.player.currentLocation = CGPointMake(self.player.currentLocation.x, (self.player.currentLocation.y + 1));
        [self refreshTile];
        [self searchForWeapons];
        [self searchForArmor];
        [self searchForEnemies];
        [self refreshDirectionButtons];
    }
}

- (IBAction)southPushed:(UIButton *)sender {
    if ([self tileExistsAtPoint: CGPointMake(self.player.currentLocation.x, self.player.currentLocation.y - 1)] == true) {
        //        NSLog(@"southPushed called");
        self.player.currentLocation = CGPointMake(self.player.currentLocation.x, (self.player.currentLocation.y - 1));
        [self refreshTile];
        [self searchForWeapons];
        [self searchForArmor];
        [self searchForEnemies];
        [self refreshDirectionButtons];
    }
}

- (IBAction)eastPushed:(UIButton *)sender {
    if ([self tileExistsAtPoint: CGPointMake(self.player.currentLocation.x + 1, self.player.currentLocation.y)] == true) {
//        NSLog(@"eastPushed called");
        self.player.currentLocation = CGPointMake((self.player.currentLocation.x + 1), self.player.currentLocation.y);
        [self refreshTile];
        [self searchForWeapons];
        [self searchForArmor];
        [self searchForEnemies];
        [self refreshDirectionButtons];
    }
}

- (IBAction)westPushed:(UIButton *)sender {
    if ([self tileExistsAtPoint: CGPointMake(self.player.currentLocation.x - 1, self.player.currentLocation.y)] == true) {
        //        NSLog(@"westPushed called");
        self.player.currentLocation = CGPointMake((self.player.currentLocation.x - 1), self.player.currentLocation.y);
        [self refreshTile];
        [self searchForWeapons];
        [self searchForArmor];
        [self searchForEnemies];
        [self refreshDirectionButtons];
    }
}

- (IBAction)resetButtonPressed:(UIButton *)sender {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Reset Game?"
                                 message:@"Would you like to terminate the current game and start over?"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* reset = [UIAlertAction
                            actionWithTitle:@"Reset"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                self.northButton.hidden = false;
                                self.southButton.hidden = false;
                                self.westButton.hidden = false;
                                self.eastButton.hidden = false;
                                
                                self.gameBoard = nil;
                                self.player = nil;
                                self.currentTile = nil;
                                self.randomWeapon = nil;
                                self.randomArmor = nil;
                                self.randomEnemy = nil;
                                [self viewDidLoad];
                                [view dismissViewControllerAnimated:YES completion:nil];
                            }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                             }];
    [view addAction:reset];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
    
}

- (IBAction)actionButtonPressed:(UIButton *)sender {
    if(CGPointEqualToPoint(self.player.currentLocation,self.randomEnemy.currentLocation) == true) {
        //flip a coin to see who attacks first
        int coinFlip = (arc4random() % 2);
        if (coinFlip == 0) {
            NSLog(@"Enemy Won Coin Toss");
            self.player.currentHealth = (self.player.currentHealth - self.randomEnemy.damageValue);
            [self refreshHealthBar];
            if (self.player.currentHealth > 0) {
                self.randomEnemy.currentHealth = self.randomEnemy.currentHealth - self.player.equippedWeapon.damageValue;
                [self refreshEnemyHealthBar];
            }
            //            NSLog(@"Enemy Health is now %i", self.randomEnemy.currentHealth);
        } else if (coinFlip == 1) {
            NSLog(@"Player Won Coin Toss");
            self.randomEnemy.currentHealth = self.randomEnemy.currentHealth - self.player.equippedWeapon.damageValue;
            [self refreshEnemyHealthBar];
            //            NSLog(@"Enemy Health is now %i", self.randomEnemy.currentHealth);
            if (self.randomEnemy.currentHealth > 0) {
                self.player.currentHealth = (self.player.currentHealth - self.randomEnemy.damageValue);
                [self refreshHealthBar];
            }
        }
        //        NSLog(@"End of Logic");
        //        NSLog(@"Player is at %f,%f", self.player.currentLocation.x, self.player.currentLocation.y);
        //        NSLog(@"Rounding to  %i,%i", (int) self.player.currentLocation.x, (int) self.player.currentLocation.y);
    } else {
        NSLog(@"Location Mismatch");
        self.actionButtonLabel.hidden = true;
        self.enemyName.hidden =  true;
        self.enemyHealthBar.hidden =  true;
    }
}

#pragma mark - View Modifier Methods

- (void)refreshTile {
//    NSLog(@"Refresh Tile Called");
//    Set the Current Tile based on the Player's location on the gameboard
//    NSLog(@"Player is at %f,%f", self.player.currentLocation.x, self.player.currentLocation.y);
//    NSLog(@"Rounding to  %i,%i", (int) self.player.currentLocation.x, (int) self.player.currentLocation.y);
    
    self.currentTile = [[self.gameBoard objectAtIndex: (int) self.player.currentLocation.x] objectAtIndex: (int) self.player.currentLocation.y];
    
    self.tileDescription.text = self.currentTile.textDescription;
    self.tileImageView.image = self.currentTile.backgroundImage;

}

- (void)refreshDirectionButtons {
    //Hide directional buttons as appropriate if on edge of gameboard

    if ([self tileExistsAtPoint: CGPointMake(self.player.currentLocation.x, self.player.currentLocation.y + 1)] == true) {
        self.northButton.hidden = false;
    } else {
        self.northButton.hidden = true;
    }
    
    if ([self tileExistsAtPoint: CGPointMake(self.player.currentLocation.x, self.player.currentLocation.y - 1)] == true) {
        self.southButton.hidden = false;
    } else {
        self.southButton.hidden = true;
    }
    
    if ([self tileExistsAtPoint: CGPointMake(self.player.currentLocation.x + 1, self.player.currentLocation.y)] == true) {
        self.eastButton.hidden = false;
    } else {
        self.eastButton.hidden = true;
    }
    
    if ([self tileExistsAtPoint: CGPointMake(self.player.currentLocation.x - 1, self.player.currentLocation.y)] == true) {
        self.westButton.hidden = false;
    } else {
        self.westButton.hidden = true;
    }

}

- (void)refreshHealthBar {
    self.healthBar.progress = ((float) self.player.currentHealth/ (float) self.player.healthTotal);
    if (self.player.currentHealth < 1) {
        [self gameOver];
    }
}

- (void)refreshEnemyHealthBar {
    self.enemyHealthBar.progress = ((float) self.randomEnemy.currentHealth/ (float) self.randomEnemy.healthTotal);
    if (self.randomEnemy.currentHealth < 1) {
        [self victory];
    }
}

- (void)refreshWeaponLabel {
    self.weaponLabel.text = self.player.equippedWeapon.name;
    self.weaponDamageValueLabel.text = [NSString stringWithFormat:@"%i", self.player.equippedWeapon.damageValue];
}

- (void)refreshArmorLabel {
    self.armorLabel.text = self.player.equippedArmor.name;
    self.armorValueLabel.text = [NSString stringWithFormat:@"%.1f", self.player.equippedArmor.armorValue];
}

#pragma mark - Helper Methods

- (void)searchForWeapons {
    self.weaponImageView.image = nil;
    if (CGPointEqualToPoint(self.player.currentLocation,self.randomWeapon.currentLocation) == true) {
        self.weaponImageView.image = self.randomWeapon.image;
        
        UIAlertController * weaponView=   [UIAlertController
                                     alertControllerWithTitle:@"Item Found!"
                                     message:[NSString stringWithFormat:@"you found the %@, which has a damage value of %i",self.randomWeapon.name, self.randomWeapon.damageValue]
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* takeTheWeapon = [UIAlertAction
                             actionWithTitle:@"Take The Weapon"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 Weapon *weaponBuffer = [[Weapon alloc] init];
                                 weaponBuffer = self.player.equippedWeapon;
                                 weaponBuffer.currentLocation = CGPointMake(self.randomWeapon.currentLocation.x, self.randomWeapon.currentLocation.y);
                                 self.player.equippedWeapon = self.randomWeapon;
                                 self.player.equippedWeapon.currentLocation = CGPointMake(0, 0);
                                 self.randomWeapon = weaponBuffer;
                                 self.weaponImageView.image = nil;
                                 [self refreshWeaponLabel];
                                 [weaponView dismissViewControllerAnimated:YES completion:nil];
                             }];
        UIAlertAction* leaveTheWeapon = [UIAlertAction
                                 actionWithTitle:@"Leave it"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [weaponView dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
        [weaponView addAction:takeTheWeapon];
        [weaponView addAction:leaveTheWeapon];
        [self presentViewController:weaponView animated:YES completion:nil];
    }
}

- (void)searchForArmor {
    self.armorImageView.image = nil;
    if (CGPointEqualToPoint(self.player.currentLocation,self.randomArmor.currentLocation) == true) {
        self.armorImageView.image = self.randomArmor.image;
        
        UIAlertController * armorView=   [UIAlertController
                                     alertControllerWithTitle:@"Item Found!"
                                     message:[NSString stringWithFormat:@"you found the %@, which has a damage value of %f",self.randomArmor.name, self.randomArmor.armorValue]
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* takeTheArmor = [UIAlertAction
                                        actionWithTitle:@"Take The Armor"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            Armor *armorBuffer = [[Armor alloc] init];
                                            armorBuffer = self.player.equippedArmor;
                                            armorBuffer.currentLocation = CGPointMake(self.randomArmor.currentLocation.x, self.randomArmor.currentLocation.y);
                                            self.player.equippedArmor = self.randomArmor;
                                            self.player.equippedArmor.currentLocation = CGPointMake(0, 0);
                                            self.randomArmor = armorBuffer;
                                            self.armorImageView.image = nil;
                                            [self refreshArmorLabel];
                                            [armorView dismissViewControllerAnimated:YES completion:nil];
                                        }];
        UIAlertAction* leaveTheArmor = [UIAlertAction
                                         actionWithTitle:@"Leave it"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action)
                                         {
                                             [armorView dismissViewControllerAnimated:YES completion:nil];
                                             
                                         }];
        [armorView addAction:takeTheArmor];
        [armorView addAction:leaveTheArmor];
        [self presentViewController:armorView animated:YES completion:nil];
    }
}

- (void)searchForEnemies {
    self.enemyImageView.image = nil;
    if (CGPointEqualToPoint(self.player.currentLocation,self.randomEnemy.currentLocation) == true){
        self.enemyImageView.image = self.randomEnemy.enemyImage;
        
        UIAlertController * enemyView=   [UIAlertController
                                     alertControllerWithTitle:@"Enemy Found!"
                                     message:[NSString stringWithFormat:@"you found %@, who has a damage value of %i",self.randomEnemy.name, self.randomEnemy.damageValue]
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* fight = [UIAlertAction
                                       actionWithTitle:@"Fight"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           self.northButton.hidden = true;
                                           self.southButton.hidden = true;
                                           self.westButton.hidden = true;
                                           self.eastButton.hidden = true;
                                           self.enemyName.text = (@"%@", self.randomEnemy.name);
                                           self.enemyName.hidden =  false;
                                           self.enemyHealthBar.hidden =  false;
                                           self.actionButtonLabel.hidden =  false;
                                           [enemyView dismissViewControllerAnimated:YES completion:nil];
                                       }];
        UIAlertAction* runAway = [UIAlertAction
                                        actionWithTitle:@"Run Away"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {

                                            ////        NSLog(@"You ran away");
                                            //        UIAlertController *alertView = [[UIAlertController alloc] initWithTitle:@"Close Call" message:[NSString stringWithFormat:@"You ran away, but not before %@ successfully attacked you for %i damage",self.randomEnemy.name, self.randomEnemy.damageValue] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                            //        [alertView show];
                                            self.player.currentHealth = self.player.currentHealth - self.randomEnemy.damageValue;
                                            [self refreshHealthBar];
                                            [enemyView dismissViewControllerAnimated:YES completion:nil];
                                        }];
        [enemyView addAction:fight];
        [enemyView addAction:runAway];
        [self presentViewController:enemyView animated:YES completion:nil];
        
    }
}
    
- (BOOL)tileExistsAtPoint:(CGPoint)point {
    if (point.x >= 0 && point.y >= 0 && point.x < [self.gameBoard count] && point.y < [[self.gameBoard objectAtIndex:point.y] count]) {
        return true;
    } else {
        return false;
    }
}

- (void) victory{
    self.northButton.hidden = true;
    self.southButton.hidden = true;
    self.westButton.hidden = true;
    self.eastButton.hidden = true;
    self.actionButtonLabel.hidden = true;
    self.enemyName.hidden =  true;
    self.enemyHealthBar.hidden =  true;
    self.weaponImageView.image = nil;
    self.enemyImageView.image = nil;
    self.tileImageView.image =[UIImage imageNamed:@"victory.JPG"];
    self.tileDescription.text = @"Shortly after killing the evil pirate, you seized a ship and sailed home. You are now rich and famous for your exploits and pirates tremble in your presence!";
}

- (void) gameOver{
    self.northButton.hidden = true;
    self.southButton.hidden = true;
    self.westButton.hidden = true;
    self.eastButton.hidden = true;
    self.enemyName.hidden =  true;
    self.enemyHealthBar.hidden =  true;
    self.actionButtonLabel.hidden = true;
    self.weaponImageView.image = nil;
    self.enemyImageView.image = nil;
    self.tileImageView.image =[UIImage imageNamed:@"gameover.gif"];
    self.tileDescription.text = @"After your death, the pirates desecrated your body to scare away other intruders. GAME OVER!";
}
@end
