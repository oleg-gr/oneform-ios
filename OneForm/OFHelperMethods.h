//
//  OFHelperMethods.h
//  OneForm
//
//  Created by Oleg Grishin on 11/6/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OFHelperMethods : NSObject

+(NSString *) createSHA512:(NSString *)source;
+(NSString *) signUp:(NSString*) email withUsername:(NSString*) userName withPassword:(NSString*) password withConfirmPassword:(NSString*) confirmPassword withFirstName:(NSString*) firstName withLastName:(NSString*) lastName;
+(NSString *) signIn:(NSString*) username withPassword:(NSString*) password;
@end
