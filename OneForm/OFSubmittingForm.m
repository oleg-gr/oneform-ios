//
//  OFSubmittingForm.m
//  OneForm
//
//  Created by Oleg Grishin on 12/11/13.
//  Copyright (c) 2013 nyuad. All rights reserved.
//

#import "OFSubmittingForm.h"

@implementation OFSubmittingForm

-(id)initWithUserData:(NSMutableDictionary*)userData andFields:(NSMutableArray*)myData andForm:(NSMutableDictionary *)formData
{
    self = [super init];
    if (self) {
        self.userData = userData;
        self.myData = myData;
        self.formData = formData;
    }
    return self;
}

-(void)viewDidLoad
{
    NSLog(@"myData: %@", self.myData);
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.loading = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 260, 30)];
    [self.loading setCenter:CGPointMake(160, 240)];
    [self.loading setText:@"Sending..."];
    [self.loading setTextColor:UI_COLOR];
    [self.loading setFont:[UIFont fontWithName:@"Roboto-Thin" size:30]];
    
    [self.view addSubview:self.loading];
    
    self.progressBar = [[OFFormProgress alloc] initWithFrame:CGRectMake(60, 260, 200, 30) andProgress:0.0 andText:@"" andTextSize:26 andTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.progressBar];
    self.connectionManager = [AFHTTPRequestOperationManager manager];
    [self.connectionManager.securityPolicy setAllowInvalidCertificates:YES];
    [self.connectionManager setRequestSerializer: [AFJSONRequestSerializer serializer]];
    [self sendForm];
}

-(void)sendForm
{
    int total_requests = (int) [self.myData count]*2 + 1;
    __block int current_request = 0;
    __block int status;
    NSMutableArray *requests;
    NSString *route;
    NSDictionary *parameters;
    
    NSString *user_id = [[self.userData objectForKey:@"user"] objectForKey:@"_id"];
    
    for (NSMutableArray* field in self.myData)
    {
        route = [NSString stringWithFormat:@"%@%@%@%@", SERVER, @"/users/", user_id, @"/data"];

        NSString *data_id = [field objectAtIndex:3];
        
        parameters = @{@"_id": user_id,
                                     @"secret": [self.userData objectForKey:@"secret"],
                                     @"fieldId": data_id,
                                     @"value": [field objectAtIndex:1]};
        AFHTTPRequestOperation *operation1 = [self.connectionManager POST:route parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%d/%d sent successfully", current_request, total_requests);
            status = (int) [[responseObject objectForKey:@"status"] integerValue];
            current_request++;
            [self.progressBar setProgress:1.0/total_requests * current_request];
        } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
             NSLog(@"%d error %@", current_request, err);
        }];
        
        [requests addObject:operation1];
        
        route = [NSString stringWithFormat:@"%@/users/%@/data/%@/orgs", SERVER, user_id, data_id];
        
        parameters = @{@"_id": user_id,
                       @"secret": [self.userData objectForKey:@"secret"],
                       @"orgs": [self.formData objectForKey:@"orgs"]};
        
        AFHTTPRequestOperation *operation2 = [self.connectionManager POST:route parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%d/%d sent successfully", current_request, total_requests);
            status = (int) [[responseObject objectForKey:@"status"] integerValue];
            current_request++;
            [self.progressBar setProgress:1.0/total_requests * current_request];
        } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
            NSLog(@"%d error %@", current_request, err);
        }];
        
        [requests addObject:operation2];
        
    }
    
    route = [NSString stringWithFormat:@"%@/users/%@/forms", SERVER, user_id];
    
    parameters = @{@"_id": user_id,
                   @"secret": [self.userData objectForKey:@"secret"],
                   @"formId": [self.formData objectForKey:@"_id"]};
    
    AFHTTPRequestOperation *operation3 = [self.connectionManager POST:route parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%d/%d sent successfully", current_request, total_requests);
        status = (int) [[responseObject objectForKey:@"status"] integerValue];
        if (status == 200)
        {
            NSLog(@"%@", [responseObject objectForKey:@"result"]);
            [self.userData setObject:[responseObject objectForKey:@"result"] forKey:@"user"];
        }
        current_request++;
        [self.progressBar setProgress:1.0/total_requests * current_request];
        [self.loading setText:@"Sent"];
        sleep(1);
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
        NSLog(@"%d error %@", current_request, err);
    }];
    
    [requests addObject:operation3];
    
    [self.connectionManager.operationQueue addOperations:requests waitUntilFinished:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
