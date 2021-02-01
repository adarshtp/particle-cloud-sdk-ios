//
//  ParticleDeveloperAgreement.m
//
//  Created by Raimundas Sakalauskas on 1/2/21.
//  Copyright © 2021 Particle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParticleDeveloperAgreement.h"
#import "ParticleLogger.h"

@implementation ParticleDeveloperAgreement

-(instancetype)initWithParams:(NSDictionary *)params
{
    if (self = [super init])
    {
        NSLog(@"params = %@", params);

        NSDictionary *attributes = params[@"attributes"];
        if (attributes != nil) {
            if ([[attributes[@"agreement_type"] stringValue] isEqualToString:@"developer"] || [[attributes[@"agreement_type"] stringValue] isEqualToString:@"self_service"]) {
                _activeDevices = 0;
                if ([attributes[@"current_usage_summary"][@"active_devices"] isKindOfClass:[NSNumber class]]) {
                    _activeDevices = [attributes[@"current_usage_summary"][@"active_devices"] intValue];
                }

                _ownedDevices = 0;
                if ([attributes[@"current_usage_summary"][@"owned_devices"] isKindOfClass:[NSNumber class]]) {
                    _ownedDevices = [attributes[@"current_usage_summary"][@"owned_devices"] intValue];
                }

                _deviceLimitReached = NO;
                if ([attributes[@"current_usage_summary"][@"device_limit_reached"] isKindOfClass:[NSNumber class]]) {
                    _deviceLimitReached = [attributes[@"current_usage_summary"][@"device_limit_reached"] boolValue];
                }

                _maxDevices = 0;
                if ([attributes[@"pricing_terms"][@"device"][@"max_devices"] isKindOfClass:[NSNumber class]]) {
                    _maxDevices = [attributes[@"pricing_terms"][@"device"][@"max_devices"] intValue];
                }

                return self;
            }
        }
    }

    return nil;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"_activeDevices: %i ", _activeDevices];
    [description appendFormat:@"_ownedDevices: %i ", _ownedDevices];
    [description appendFormat:@"_maxDevices: %i ", _maxDevices];
    [description appendFormat:@"_deviceLimitReached: %i ", _deviceLimitReached];
    [description appendString:@">"];
    return description;
}

@end
