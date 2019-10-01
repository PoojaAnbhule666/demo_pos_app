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
//-(unsigned char *) callBackFromSdk:(unsigned char *) data;
-(unsigned int *) txrx:(unsigned int *) data;
-(void) pinEntryCanceled;
@end
@interface CubeFramework : NSObject
@property (weak) id<mcSDKProtocol> delegate;
+(CubeFramework*) getInstance;
+(NSString*) initiate;
+(NSString*) getmcSDKiOSFrameworkVersion;
// public PEDStatus pair(MCCore.MCTransceiver attachedDecoder)
// i think PEDStatus is an enum so we'll use int for now and the handler i think we can handle through delegation
+(int) pair;
+(int) pinCapture;
+(void) pinEntered:(NSString*) pin;
+(void) pinEntryCanceled;
// public synchronized byte [] aPICallRaw(String call, String [] argsLabel, Object[] argsData, boolean wallet_id_data)
@end

#endif /* MCSdkFrameworkHeader_h */
