//
//  KeyInputTextField.m
//  DEmo
//
//  Created by SDL on 16/7/11.
//  Copyright © 2016年 SDL. All rights reserved.
//

#import "KeyInputTextField.h"

@implementation KeyInputTextField

-(void)deleteBackward {
    [super deleteBackward];
    
    if (_keyInputDelegate && [_keyInputDelegate respondsToSelector:@selector(deleteBackward)]) {
        [_keyInputDelegate deleteBackward];
    }
}

@end
