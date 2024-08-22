//
//  VRTAsPrimaryManager.swift
//  Vrtcal-Fyber-FairBid-Adapters
//
//  Created by Scott McCoy on 8/21/24.
//

import FairBidSDK
import VrtcalSDK

// Must be NSObject for FairBidDelegate
class VRTAsPrimaryManager: NSObject {
    
    static var singleton = VRTAsPrimaryManager()
    var shouldInit = true
    
    func initializeThirdParty(
        customEventConfig: VRTCustomEventConfig,
        completionHandler: @escaping (Result<Void,VRTError>) -> ()
    ) {
        VRTLogInfo()
        guard shouldInit else {
            return
        }
        
        // Require the appId
        guard let appId = customEventConfig.thirdPartyCustomEventDataValue(
            thirdPartyCustomEventKey: .appId
        ).getSuccess(failureHandler: { vrtError in
            completionHandler(.failure(vrtError))
        }) else {
            return
        }
        
        FairBid.delegate = self
        FairBid.start(withAppId: appId)
        
        shouldInit = false
        completionHandler(.success())
    }
    
}

extension VRTAsPrimaryManager: FairBidDelegate {
    func networkStarted(_ network: FYBMediatedNetwork) {
        VRTLogInfo("network: \(network)")
    }
    
    func network(_ network: FYBMediatedNetwork, failedToStartWithError error: Error) {
        VRTLogInfo("network: \(network), error: \(error)")
    }
    
    func mediationStarted() {
        VRTLogInfo()
    }
    
    func mediationFailedToStartWithError(_ error: Error) {
        VRTLogInfo("error: \(error)")
    }
}
