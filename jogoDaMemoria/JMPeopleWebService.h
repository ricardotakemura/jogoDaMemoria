//
//  JMPeopleWebService.h
//  jogoDaMemoria
//
//  Created by Dojo on 30/10/13.
//  Copyright (c) 2013 Dojo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMUsuario;

@protocol JMPeopleWebServiceDelegate <NSObject>
@optional
-(void) respostaLogar:(JMUsuario*) usuario;
@end

@interface JMPeopleWebService : NSObject<NSURLConnectionDataDelegate>

@property id<JMPeopleWebServiceDelegate> delegate;

+ (JMPeopleWebService *)sharedInstance;

-(void)logarComUsuario:(NSString*)nomeDoUsuario
                 senha:(NSString*)senha;
@end
