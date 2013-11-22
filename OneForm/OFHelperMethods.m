//
//  OFHelperMethods.m
//  OneForm
//
//  Created by Oleg Grishin on 11/6/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFHelperMethods.h"
#include <CommonCrypto/CommonDigest.h>

@implementation OFHelperMethods

+ (NSString *) createSHA512:(NSString *)source
{
    
    const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
    
    CC_SHA512(keyData.bytes, keyData.length, digest);
    
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    
    return [out description];
}

+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

#pragma mark Sign up and Sign in

+(NSString *) signUp:(NSString*) email withPassword:(NSString*) password withConfirmPassword:(NSString*) confirmPassword withFirstName:(NSString *)firstName withLastName:(NSString *)lastName
{
    if (firstName.length == 0)
    {
        return @"First Name cannot be empty";
    }
    else if (lastName.length == 0)
    {
        return @"Last Name cannot be empty";
    }
    else if (email.length == 0)
    {
        return @"Email cannot be empty";
    }
    else if (![OFHelperMethods validateEmail:email])
    {
        return @"Invalid email format";
    }
    else if (password.length == 0)
    {
        return @"Password cannot be empty";
    }
    else if (confirmPassword.length == 0)
    {
        return @"Password confirmation cannot be empty";
    }
    else if (![confirmPassword isEqualToString: password])
    {
        return @"Passwords do not match";
    }
    else
    {
        //logic for sign up check
        return @"OK";
    }
}

+(NSString *) signIn:(NSString *)username withPassword:(NSString *)password
{
    if (username.length == 0)
    {
        return @"Username cannot be empty";
    }
    else if (password.length == 0)
    {
        return @"Password cannot be empty";
    }
    else
    {
        //logic for sign in check
        return @"OK";
    }
}

@end
