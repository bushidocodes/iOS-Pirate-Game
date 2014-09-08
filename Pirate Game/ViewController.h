//
//  ViewController.h
//  Pirate Game
//
//  Created by Sean McBride on 9/2/14.
//  Copyright (c) 2014 Sean McBride. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import "Tile.h"
#import "Enemy.h"

@interface ViewController : UIViewController <UIAlertViewDelegate>

//Instance Variables
@property (strong, nonatomic) NSMutableArray *gameBoard;
@property (strong, nonatomic) Character *player;
@property (strong, nonatomic) Tile *currentTile;
@property (strong, nonatomic) Weapon *randomWeapon;
@property (strong, nonatomic) Armor *randomArmor;
@property (strong, nonatomic) Enemy *randomEnemy;

//Interface Builder Outlets
@property (strong, nonatomic) IBOutlet UILabel *tileDescription;
@property (strong, nonatomic) IBOutlet UIImageView *tileImageView;
@property (strong, nonatomic) IBOutlet UIImageView *weaponImageView;
@property (strong, nonatomic) IBOutlet UIImageView *enemyImageView;
@property (strong, nonatomic) IBOutlet UIImageView *armorImageView;
@property (strong, nonatomic) IBOutlet UILabel *enemyName;
@property (strong, nonatomic) IBOutlet UIProgressView *enemyHealthBar;
@property (strong, nonatomic) IBOutlet UIButton *actionButtonLabel;
@property (strong, nonatomic) IBOutlet UIButton *northButton;
@property (strong, nonatomic) IBOutlet UIButton *westButton;
@property (strong, nonatomic) IBOutlet UIButton *eastButton;
@property (strong, nonatomic) IBOutlet UIButton *southButton;
@property (strong, nonatomic) IBOutlet UIProgressView *healthBar;
@property (strong, nonatomic) IBOutlet UILabel *weaponLabel;
@property (strong, nonatomic) IBOutlet UILabel *weaponDamageValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *armorLabel;
@property (strong, nonatomic) IBOutlet UILabel *armorValueLabel;

//Interface Builder Actions
- (IBAction)northPushed:(UIButton *)sender;
- (IBAction)westPushed:(UIButton *)sender;
- (IBAction)eastPushed:(UIButton *)sender;
- (IBAction)southPushed:(UIButton *)sender;
- (IBAction)resetButtonPressed:(UIButton *)sender;
- (IBAction)actionButtonPressed:(UIButton *)sender;


@end

