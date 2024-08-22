import FairBidSDK
import Foundation
import VrtcalSDK

// Fyber FairBid Interstitial Adapter, Vrtcal as Primary

class VRTInterstitialCustomEventFyberFairBid: VRTAbstractInterstitialCustomEvent {
    private var placementId: String?
    private var fybInterstitialDelegatePassthrough = FYBInterstitialDelegatePassthrough()
    
    override func loadInterstitialAd() {
        VRTLogInfo()
        
        VRTAsPrimaryManager.singleton.initializeThirdParty(
            customEventConfig: customEventConfig
        ) { result in
            guard let placementId = self.customEventConfig.thirdPartyCustomEventDataValueOrFailToLoad(
                thirdPartyCustomEventKey: ThirdPartyCustomEventKey.adUnitId,
                customEventLoadDelegate: self.customEventLoadDelegate
            ) else {
                return
            }
                    
            self.placementId = placementId
            
            self.fybInterstitialDelegatePassthrough.customEventLoadDelegate = self.customEventLoadDelegate
            
            FYBInterstitial.delegate = self.fybInterstitialDelegatePassthrough
            FYBInterstitial.request(placementId)
        }
    }
    
    override func showInterstitialAd() {
        VRTLogInfo()
        fybInterstitialDelegatePassthrough.customEventShowDelegate = customEventShowDelegate
        guard let placementId else {
            
            let vrtError = VRTError(
                vrtErrorCode: .customEvent,
                message: "placementId nil"
            )
            customEventShowDelegate?.customEventFailedToShow(vrtError: vrtError)
            return
        }
        
        customEventShowDelegate?.customEventWillPresentModal(.interstitial)
        let fybShowOptions = FYBShowOptions()
        fybShowOptions.viewController = viewControllerDelegate?.vrtViewControllerForModalPresentation()
        FYBInterstitial.show(placementId, options: fybShowOptions)
    }
}

// MARK: - FYBInterstitialDelegate
class FYBInterstitialDelegatePassthrough: NSObject, FYBInterstitialDelegate {

    public weak var customEventLoadDelegate: VRTCustomEventLoadDelegate?
    public weak var customEventShowDelegate: VRTCustomEventShowDelegate?
    
    func interstitialIsAvailable(_ placementId: String) {
        //    Called when an Interstitial from placement becomes available
        VRTLogInfo()
        customEventLoadDelegate?.customEventLoaded()
    }

    func interstitialIsUnavailable(_ placementId: String) {
        //    Called when an Interstitial from placement becomes unavailable
        VRTLogInfo()
        //No Vrtcal Analog
    }

    func interstitialDidShow(_ placementId: String, impressionData: FYBImpressionData) {
        //    Called when an Interstitial from placement shows up. In case the ad is a video, audio play will start here.
        VRTLogInfo()
        customEventShowDelegate?.customEventShown()
        customEventShowDelegate?.customEventDidPresentModal(.interstitial)
    }

    func interstitialDidFail(
        toShow placementId: String,
        withError error: Error,
        impressionData: FYBImpressionData
    ) {
        // Called when an error arises when showing an Interstitial from placement
        // No Vrtcal Analog
        VRTLogInfo()
        
        let vrtError: VRTError
        
        vrtError = VRTError(vrtErrorCode: .customEvent, error: error)

        customEventShowDelegate?.customEventFailedToShow(
            vrtError: vrtError
        )
    }

    func interstitialDidClick(_ placementId: String) {
        // Called when an Interstitial from placement is clicked
        VRTLogInfo()
        customEventShowDelegate?.customEventClicked()
    }

    func interstitialDidDismiss(_ placementId: String) {
        //    Called when an Interstitial from placement hides. In case the ad is a video, audio play will stop here.
        VRTLogInfo()
        customEventShowDelegate?.customEventDidDismissModal(.interstitial)
    }

    func interstitialWillRequest(_ placementId: String) {
        //    Called when an Interstitial is going to be requested.
        VRTLogInfo()
        //No Vrtcal Analog
    }
}
