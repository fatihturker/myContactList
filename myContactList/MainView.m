//
//  MainView.m
//  myContactList
//
//  Created by Fatih Türker on 29.08.2012.
//  Copyright (c) 2012 Fatih Türker. All rights reserved.
//

#import "MainView.h"
#import "UserLogin.h"
@interface MainView ()

@end

@implementation MainView
@synthesize myActivityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) myMethod{
    [myActivityIndicator stopAnimating];
    UserLogin *loginPage = [self.storyboard instantiateViewControllerWithIdentifier:@"userLogin"];
    [self.navigationController pushViewController:loginPage animated:YES];
}

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden=YES;
    [myActivityIndicator startAnimating];
    
    //2 saniye sonra myMethod u cagiriyor
    [self performSelector:@selector(myMethod) withObject:nil afterDelay:3.0f];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidUnload
{
    [self setMyActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
