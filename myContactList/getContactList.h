//
//  getContactList.h
//  myContactList
//
//  Created by Fatih Türker on 31.08.2012.
//  Copyright (c) 2012 Fatih Türker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface getContactList : UIViewController
-(IBAction) getContacts;
@property(nonatomic, retain)NSMutableArray *nameAR, *phoneAR;
+ (UIColor*)myColor2;
@end
