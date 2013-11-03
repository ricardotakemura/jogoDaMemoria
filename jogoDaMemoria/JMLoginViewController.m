//
//  DJViewController.m
//  jogoDaMemoria
//
//  Created by Dojo on 23/10/13.
//  Copyright (c) 2013 Dojo. All rights reserved.
//

#import "JMLoginViewController.h"
#import "JMPeopleWebService.h"
#import "JMUsuario.h"

@interface JMLoginViewController ()

@end

@implementation JMLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.txtSenha.delegate = self;
    self.txtNomeUsuario.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.vwPrincipal.frame.origin.y == 0) {
       [UIView animateWithDuration:0.3 animations:^{
            self.vwPrincipal.frame = CGRectMake(0, -125,
                                           self.vwPrincipal.frame.size.width,
                                           self.vwPrincipal.frame.size.height);
        }];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.vwPrincipal.frame.origin.y == -125) {
        [textField resignFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
            self.vwPrincipal.frame = CGRectMake(0, 0,
                                           self.vwPrincipal.frame.size.width,
                                           self.vwPrincipal.frame.size.height);
        }];
    }
    return YES;
}

- (IBAction)btnIniciarOnTouchDown:(id)sender {
    JMPeopleWebService* WebService = [JMPeopleWebService sharedInstance];
    WebService.delegate = self;
    [WebService logarComUsuario:self.txtNomeUsuario.text
                          senha:self.txtSenha.text];
}

-(void)respostaLogar:(JMUsuario*)resposta
{
    NSString* str = resposta.nome;
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Aviso" message:str delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
