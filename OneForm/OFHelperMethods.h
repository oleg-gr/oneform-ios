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
+(NSString *) signUp:(NSString*) email withPassword:(NSString*) password withConfirmPassword:(NSString*) confirmPassword withFirstName:(NSString*) firstName withLastName:(NSString*) lastName withUdid:(NSString*)udid;
+(NSString *) signIn:(NSString*) username withPassword:(NSString*) password;
+(NSMutableDictionary*) orgToLookup:(NSMutableArray*)orgs;
+(NSMutableDictionary*) formsToLookup:(NSMutableArray*)forms;
+(NSMutableDictionary*) fieldsToLookup:(NSMutableArray*)forms;
@end
