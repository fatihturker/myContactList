//
//  aboutWebacik.m
//  myContactList
//
//  Created by Fatih Türker on 03.09.2012.
//  Copyright (c) 2012 Fatih Türker. All rights reserved.
//

#import "aboutWebacik.h"

@interface aboutWebacik ()

@end

@implementation aboutWebacik
@synthesize webView;

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
    self.navigationController.navigationBarHidden=YES;
    NSURL *webacik = [NSURL URLWithString:@"http://www.webacik.com/"];
    NSURLRequest *gogreq = [NSURLRequest requestWithURL:webacik];
    [webView loadRequest:gogreq];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
