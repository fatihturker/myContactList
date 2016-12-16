//
//  Register.h
//  myContactList
//
//  Created by Fatih Türker on 30.08.2012.
//  Copyright (c) 2012 Fatih Türker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register : UIViewController{
  NSString *titleOFApplication;
}
@property (weak, nonatomic) IBOutlet UINavigationBar *myNavigationBar;
@property (weak, nonatomic) IBOutlet UIWebView *registerWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backToolbar;

@end
