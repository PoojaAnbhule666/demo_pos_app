//
//  MCSdkFrameworkHeader.h
//  mcsdkObjCFW
//
//  Created by Mike Adams on 8/2/19.
//  Copyright © 2019 MagicCube. All rights reserved.
//

#ifndef MCSdkFrameworkHeader_h
#define MCSdkFrameworkHeader_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol mcSDKProtocol <NSObject>
-(unsigned int *) txrx:(unsigned int *) data;
-(void) pinEntryCanceled;
@end
@interface CubeFramework : NSObject
@property (weak) id<mcSDKProtocol> delegate;
+(CubeFramework*) getInstance;
+(NSString*) initiate;
+(NSString*) getmcSDKiOSFrameworkVersion;
+(int) pair;
+(int) pinCapture;
+(void) pinEntered:(NSString*) pin;
+(void) pinEntryCanceled;
+(void) clearData;
@end

#endif /* MCSdkFrameworkHeader_h */
