//
//  Register.m
//  myContactList
//
//  Created by Fatih Türker on 30.08.2012.
//  Copyright (c) 2012 Fatih Türker. All rights reserved.
//

#import "Register.h"

@interface Register ()

@end

@implementation Register
@synthesize myNavigationBar;
@synthesize registerWebView;
@synthesize backToolbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = YES;
    NSURL *regWeb = [NSURL URLWithString:@"http://fatih.demiraytelekom.com/myContactList/register.html"];
    NSURLRequest *regWebreq = [NSURLRequest requestWithURL:regWeb];
    [registerWebView loadRequest:regWebreq];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setRegisterWebView:nil];
    [self setBackToolbar:nil];
    [self setMyNavigationBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
