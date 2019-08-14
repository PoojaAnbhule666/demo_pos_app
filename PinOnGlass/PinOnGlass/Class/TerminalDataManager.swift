//
//  TerminalDataManager.swift
//  PinOnGlass
//
//  Created by user914766 on 8/9/19.
//  Copyright © 2019 NTTDATA. All rights reserved.
//

import Foundation
import IDTech

class TerminalDataManager: NSObject {
    
    var CAPK = [
        "a000000003950101ee1511cec71020a9b90443b37b1d5f6e703030f6000000039000be9e1fa5e9a803852999c4ab432db28600dcd9dab76dfaaa47355a0fe37b1508ac6bf38860d3c6c2e5b12a3caaf2a7005a7241ebaa7771112c74cf9a0634652fbca0e5980c54a64761ea101a114e0f0b5572add57d010b7c9c887e104ca4ee1272da66d997b9a90b5a6d624ab6c57e73c8f919000eb5f684898ef8c3dbefb330c62660bed88ea78e909aff05f6da627b",
        "a000000003920101429c954a3859cef91295f663c963e582ed6eb25300000003b000996af56f569187d09293c14810450ed8ee3357397b18a2458efaa92da3b6df6514ec060195318fd43be9b8f0cc669e3f844057cbddf8bda191bb64473bc8dc9a730db8f6b4ede3924186ffd9b8c7735789c23a36ba0b8af65372eb57ea5d89e7d14e9c7b6b557460f10885da16ac923f15af3758f0f03ebd3c5c2c949cba306db44e6a2c076c5f67e281d7ef56785dc4d75945e491f01918800a9e2dc66f60080566ce0daf8d17ead46ad8e30a247c9f",
        "a000000003940101c4a3c43ccf87327d136b804160e47d43b60e6e0f00000003acd2b12302ee644f3f835abd1fc7a6f62cce48ffec622aa8ef062bef6fb8ba8bc68bbf6ab5870eed579bc3973e121303d34841a796d6dcbc41dbf9e52c4609795c0ccf7ee86fa1d5cb041071ed2c51d2202f63f1156c58a92d38bc60bdf424e1776e2bc9648078a03b36fb554375fc53d57c73f5160ea59f3afc5398ec7b67758d65c9bff7828b6b82d4be124a416ab7301914311ea462c19f771f31b3b57336000dff732d3b83de07052d730354d297bec72871dccf0e193f171aba27ee464c6a97690943d59bdabb2a27eb71ceebdafa1176046478fd62fec452d5ca393296530aa3f41927adfe434a2df2ae3054f8840657a26e0fc617",
        "a000000004f10101d8e68da167ab5a85d8c3d55ecb9b0517a1a5b4bb00000003a0dcf4bde19c3546b4b6f0414d174dde294aabbb828c5a834d73aae27c99b0b053a90278007239b6459ff0bbcd7b4b9c6c50ac02ce91368da1bd21aaeadbc65347337d89b68f5c99a09d05be02dd1f8c5ba20e2f13fb2a27c41d3f85cad5cf6668e75851ec66edbf98851fd4e42c44c1d59f5984703b27d5b9f21b8fa0d93279fbbf69e090642909c9ea27f898959541aa6757f5f624104f6e1d3a9532f2a6e51515aead1b43b3d7835088a2fafa7be7",
        "a000000004ef010121766ebb0ee122afb65d7845b73db46bab65427aa191cb87473f29349b5d60a88b3eaee0973aa6f1a082f358d849fddff9c091f899eda9792caf09ef28f5d22404b88a2293eebbc1949c43bea4d60cfd879a1539544e09e0f09f60f065b2bf2a13ecc705f3d468b9d33ae77ad9d3f19ca40f23dcf5eb7c04dc8f69eba565b1ebcb4686cd274785530ff6f6e9ee43aa43fdb02ce00daec15c7b8fd6a9b394baba419d3f6dc85e16569be8e76989688efea2df22ff7d35c043338deaa982a02b866de5328519ebbcd6f03cdd686673847f84db651ab86c28cf1462562c577b853564a290c8556d818531268d25cc98a4cc6a0bdfffda2dcca3a94c998559e307fddf915006d9a987b07ddaeb3b"
    ];
    
    var AIDS: [String: String] = [
        "a0000000031010":"9F01065649534130305F5701005F2A0203929F090200965F3601009F1B0400000000DF25039F3704DF280F9F02065F2A029A039C0195059F3704DFEE150101DF13050000000000DF14050000000000DF15050000008000DF180100DF170400000000DF190100",
        "a0000000041010":"9F01064D61737465725F5701005F2A0203929F090200025F3601009F1B0400000000DF25039F3704DF280F9F02065F2A029A039C0195059F3704DFEE150101DF13050000000000DF14050000000000DF15050000008000DF180100DF170400000000DF190100"
    ]
    
    
    var terminalSettng:String = "5f3601009f1a0203929f3501219f330320b8c89f40056000e0b0009f1e085465726d696e616c9f150212349f160f3030303030303030303030303030309f1c0838373635343332319f4e2231303732312057616c6b65722053742e20437970726573732c204341202c5553412edf260100df1008656e667265737a68df110100df270100dfee150101dfee160100dfee170105dfee180180dfee1e08f0f83cf0c20e1400dfee1f0180dfee1b083030303130353030dfee20013cdfee21010adfee2203323c3c";
    
    
    // overidiving
    override init() {
        
    }
    
    //TODO: Inmpelemnt api calls
    func setUpTerminal() {
        // Call to terminal Activation
        // Getting serial number
        // KEY CHAIN SAVING
        
        var SerialNumber: NSString?
        let returnCode: RETURN_CODE = IDT_NEO2.sharedController().config_getSerialNumber(&SerialNumber)
        
        if RETURN_CODE_DO_SUCCESS == returnCode {
            // call API with serial number on success set Terminal Data
            self.setTerminalData()
        }
    }
    
    
    // Set Terminal Data
    func setTerminalData() {
    
        // loop through the CAPK value
        for iApk in self.CAPK {
            let iCAPK = IDTUtility.hex(toData: iApk)
            let returnCode: RETURN_CODE = IDT_NEO2.sharedController().emv_setCAPKFile(iCAPK);
            
            if(RETURN_CODE_DO_SUCCESS == returnCode){
                // do something for error
            }
            
        }
        
        // Let Set AID for terminal inereface
        for iAids in self.AIDS {
            let TLV = IDTUtility.hex(toData: iAids.value);
            let returnCode: RETURN_CODE = IDT_NEO2.sharedController().emv_setApplicationData(iAids.key, configData: IDTUtility.tlVtoDICT(TLV));
            
            if(RETURN_CODE_DO_SUCCESS == returnCode){
                // do something for error
            }
        }
        
        let TLV = IDTUtility.hex(toData: self.terminalSettng);
        let returnCode: RETURN_CODE = IDT_NEO2.sharedController().emv_setTerminalData(IDTUtility.tlVtoDICT(TLV));
        
        if(RETURN_CODE_DO_SUCCESS == returnCode){
            // do something for error
        }
    }

}
