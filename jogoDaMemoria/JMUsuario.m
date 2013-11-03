//
//  JMUsuario.m
//  JogoDaMemoria
//
//  Created by Ricardo Takemura on 03/11/13.
//  Copyright (c) 2013 Dojo. All rights reserved.
//

#import "JMUsuario.h"

@implementation JMUsuario

+(NSArray*) carregarDados:(NSData*)data {
    if (data) {
        NSError* error = nil;
        NSJSONSerialization* jsonSerialization =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingAllowFragments
                                          error:&error];
        if (error) {
            return nil;
        }
        NSArray* data = [jsonSerialization mutableArrayValueForKey:@"data"];
        NSMutableArray* usuarios = [NSMutableArray array];
        for (id item in data) {
            if ([item isKindOfClass:[NSArray class]]) {
                NSArray* itemAsArray = (NSArray*)item;
                if (itemAsArray.count >= 2) {
                    JMUsuario* usuario = [[JMUsuario alloc] init];
                    usuario.nome =  [itemAsArray objectAtIndex:0];
                    usuario.email = [NSString stringWithFormat: @"%@@ciandt.com",
                                     [itemAsArray objectAtIndex:1]];
                    usuario.foto = [UIImage imageWithData:
                                    [NSData dataWithContentsOfURL:
                                     [NSURL URLWithString:
                                      [NSString stringWithFormat:@"https://people.cit.com.br/photos/%@.jpg"
                                       ,[itemAsArray objectAtIndex:1]]]]];
                    [usuarios addObject:usuario];
                }
            }
        }
        if (usuarios.count > 0) {
            return usuarios;
        }
    }
    return nil;
}

@end
