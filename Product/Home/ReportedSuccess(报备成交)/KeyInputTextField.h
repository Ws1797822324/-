//
//  KeyInputTextField.h
//  DEmo
//
//  Created by SDL on 16/7/11.
//  Copyright © 2016年 SDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyInputTextField;

@protocol KeyInputTextFieldDelegate <NSObject>

-(void) deleteBackward;

@end


@interface KeyInputTextField : UITextField

@property (nonatomic, assign) id <KeyInputTextFieldDelegate> keyInputDelegate;

@end
