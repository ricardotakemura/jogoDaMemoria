//
//  JMPeopleWebService.m
//  jogoDaMemoria
//
//  Created by Dojo on 30/10/13.
//  Copyright (c) 2013 Dojo. All rights reserved.
//

#import "JMPeopleWebService.h"
#import "JMUsuario.h"

@interface JMPeopleWebService()
@property (atomic, strong) NSMutableData* responseData;
@property (atomic, assign) NSInteger statusCode;
@property (atomic, strong) NSString* nomeDoUsuario;
@property (atomic, strong) NSString* senha;
-(NSURLRequest*)prepareRequestAuthorizationWithURL:(NSURL*) url;
@end

@implementation JMPeopleWebService

static JMPeopleWebService* _sharedInstance = nil;

+ (JMPeopleWebService *)sharedInstance {
    if (nil != _sharedInstance) {
        return _sharedInstance;
    }
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        _sharedInstance = [[JMPeopleWebService alloc] init];
    });
    return _sharedInstance;
}

-(NSURLRequest*)prepareRequestAuthorizationWithURL: (NSURL*)url
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    NSString* base64 = [[[NSString stringWithFormat:@"%@:%@",
                          self.nomeDoUsuario, self.senha]
                         dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
    [request setValue:[NSString stringWithFormat:@"Basic %@", base64]
   forHTTPHeaderField:@"Authorization"];
    return request;
}

-(void)logarComUsuario:(NSString*)nomeDoUsuario
                 senha:(NSString*)senha{
    self.responseData = [[NSMutableData alloc] init];
    self.nomeDoUsuario = nomeDoUsuario;
    self.senha = senha;
    NSURL* url = [NSURL URLWithString:
                  [NSString stringWithFormat:@"https://people.cit.com.br/search/json/?q=%@",
                   self.nomeDoUsuario]];
    NSURLRequest* request = [self prepareRequestAuthorizationWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    self.statusCode = httpResponse.statusCode;
    NSLog(@"Status code: %d", self.statusCode);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (self.responseData) {
        [self.responseData appendData:data];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    JMUsuario* usuario = nil;
    if (self.statusCode == 200) {
        NSArray* usuarios = [JMUsuario carregarDados:self.responseData];
        if ((usuarios) && (usuarios.count == 1)) {
            usuario = [usuarios objectAtIndex:0];
        }
    }
    if ((self.delegate) && ([self.delegate respondsToSelector:@selector(respostaLogar:)])) {
        [self.delegate respostaLogar: usuario];
    }
}
@end
