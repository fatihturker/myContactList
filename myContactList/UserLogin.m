//
//  UserLogin.m
//  myContactList
//
//  Created by Fatih Türker on 29.08.2012.
//  Copyright (c) 2012 Fatih Türker. All rights reserved.
//

#import "UserLogin.h"
#import <CommonCrypto/CommonDigest.h>
#define CC_MD5_DIGEST_LENGTH 16
@interface UserLogin ()

@end

@implementation UserLogin
@synthesize userName;
@synthesize password;
@synthesize loginButton;
@synthesize registerButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSString*) MD5StringOfString : (NSString*) inputStr
{
	NSData* inputData = [inputStr dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char outputData[CC_MD5_DIGEST_LENGTH];
	CC_MD5([inputData bytes], [inputData length], outputData);
    
	NSMutableString* hashStr = [NSMutableString string];
	int i = 0;
	for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
		[hashStr appendFormat:@"%02x", outputData[i]];
    
	return hashStr;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(IBAction) userLoginConformation{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@" " delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [alert addSubview:progress];
    [progress startAnimating];
    [alert show];
    NSString *checkPass;
    checkPass=[self MD5StringOfString:password.text];
    NSString *post = [NSString stringWithFormat:@"&username=%@&password=%@",userName.text,checkPass];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://fatih.demiraytelekom.com/myContactList/auth.php"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if(conn)
    {
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *regexString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        if([regexString rangeOfString:@"1"].location != NSNotFound){
            [[NSUserDefaults standardUserDefaults] setObject:userName.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:checkPass forKey:@"password"];
            [alert dismissWithClickedButtonIndex:-1 animated:YES];
            UITabBarController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"contactListTabBar"];
            [self.navigationController pushViewController:svc animated:YES];
        }else{
            [alert dismissWithClickedButtonIndex:-1 animated:YES];
                UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Username or Password was incorrect or your account is not activated yet." message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert2 show];
            
        }
    }
    else
    {
        [alert dismissWithClickedButtonIndex:-1 animated:YES];
        NSLog(@"Connection Fail");
    }
 
}


- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden=YES;
   
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setUserName:nil];
    [self setPassword:nil];
    [self setLoginButton:nil];
    [self setRegisterButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
