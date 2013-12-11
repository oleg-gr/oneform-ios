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
    
    CC_SHA512(keyData.bytes, (int) keyData.length, digest);
    
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"< >"];
    NSString *secret = [[[out description] componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    
    return secret;
}

+(BOOL)validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

#pragma mark Sign up and Sign in

+(NSString *) signUp:(NSString*) email withPassword:(NSString*) password withConfirmPassword:(NSString*) confirmPassword withFirstName:(NSString *)firstName withLastName:(NSString *)lastName withUdid:(NSString *)udid
{
    if (firstName.length == 0)
    {
        return @"First Name cannot be empty";
    }
    else if (lastName.length == 0)
    {
        return @"Last Name cannot be empty";
    }
    else if (udid.length == 0)
    {
        return @"UDID cannot be empty";
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
    else if (password.length < 6 || confirmPassword.length < 6)
    {
        return @"Password cannot be less than 6 characters long";
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

+(NSString *) signIn:(NSString *)email withPassword:(NSString *)password
{
    if (email.length == 0)
    {
        return @"Email cannot be empty";
    }
    else if (password.length == 0)
    {
        return @"Password cannot be empty";
    }
    else if (password.length <= 6)
    {
        return @"Password cannot be shorter than 6 characters";
    }
    else if (![OFHelperMethods validateEmail:email])
    {
        return @"Invalid email format";
    }
    else
    {
        return @"OK";
    }
}

+(NSMutableDictionary*) orgToLookup:(NSMutableArray*)orgs
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSMutableDictionary *org in orgs)
    {
        NSString *name = [[org objectForKey:@"profile"] objectForKey:@"name"];
        [result setObject:name forKey:[org objectForKey:@"_id"]];
    }
    return result;
}

+(NSMutableDictionary*) formsToLookup:(NSMutableArray*)forms
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSInteger i = 0; i < [forms count]; i++)
    {
        [result setObject:[[forms objectAtIndex:i] objectForKey:@"_id"] forKey:[NSNumber numberWithInteger:i]];
    }
    return result;
}

+(NSMutableDictionary*) formsToRevLookup:(NSMutableArray*)forms
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSInteger i = 0; i < [forms count]; i++)
    {
        [result setObject:[NSNumber numberWithInteger:i] forKey:[[forms objectAtIndex:i] objectForKey:@"_id"]];
    }
    return result;
}

+(NSMutableDictionary*) fieldsToRevLookup:(NSMutableArray*)fields
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSInteger i = 0; i < [fields count]; i++)
    {
        [result setObject:[NSNumber numberWithInteger:i] forKey:[[fields objectAtIndex:i] objectForKey:@"_id"]];
    }
    return result;
}

+(void) getLookUps:(NSMutableDictionary*)userData
{
    NSMutableArray *forms = [userData objectForKey:@"forms"];
    [userData setObject:[OFHelperMethods formsToLookup:forms] forKey:@"forms_lookup"];
    [userData setObject:[OFHelperMethods formsToRevLookup:forms] forKey:@"forms_reverse_lookup"];
    NSMutableArray *orgs = [userData objectForKey:@"orgs"];
    [userData setObject:[OFHelperMethods orgToLookup:orgs] forKey:@"orgs_lookup"];
    NSMutableArray *fields = [userData objectForKey:@"fields"];
    [userData setObject:[OFHelperMethods fieldsToRevLookup:fields] forKey:@"fields_reverse_lookup"];
}

@end
