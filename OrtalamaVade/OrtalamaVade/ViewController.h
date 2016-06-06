//
//  ViewController.h
//  OrtalamaVade
//
//  Created by Bekir Yaylacı on 18.04.2016.
//  Copyright © 2016 Bekir Yaylacı. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UILabel *lblOrtVadeTarihi;
@property (weak, nonatomic) IBOutlet UILabel *lblOrtVadeTutari;



-(IBAction)touchText1:(UITextField*)sender;

-(IBAction)addRow;
-(void)addLabelAndTextBox;
-(IBAction)getAllData;
-(IBAction)newPage;
@end

