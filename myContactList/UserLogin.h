//
//  UserLogin.h
//  myContactList
//
//  Created by Fatih Türker on 29.08.2012.
//  Copyright (c) 2012 Fatih Türker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLogin : UIViewController{

}
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

-(IBAction) userLoginConformation;
@end
