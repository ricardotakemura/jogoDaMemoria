//
//  DJViewController.h
//  jogoDaMemoria
//
//  Created by Dojo on 23/10/13.
//  Copyright (c) 2013 Dojo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMPeopleWebService.h"

@interface JMLoginViewController : UIViewController<UITextFieldDelegate, JMPeopleWebServiceDelegate>
@property (weak, nonatomic) IBOutlet UIView* vwPrincipal;
@property (weak, nonatomic) IBOutlet UITextField *txtNomeUsuario;
@property (weak, nonatomic) IBOutlet UITextField *txtSenha;
- (IBAction)btnIniciarOnTouchDown:(id)sender;

@end
