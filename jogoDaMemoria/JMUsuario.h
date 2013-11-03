//
//  JMUsuario.h
//  JogoDaMemoria
//
//  Created by Ricardo Takemura on 03/11/13.
//  Copyright (c) 2013 Dojo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMUsuario : NSObject
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* nome;
@property (nonatomic, strong) UIImage* foto;
+(NSArray*) carregarDados:(NSData*)data;
@end
