//  Converted to Swift 5.8.1 by Swiftify v5.8.26605 - https://swiftify.com/
//
//  VRTInterstitialCustomEventFyberFairBid.swift
//
//  Created by Scott McCoy on 5/9/19.
//  Copyright © 2019 VRTCAL. All rights reserved.
//

import FairBidSDK
import Foundation
import VrtcalSDK

//Fyber FairBid Interstitial Adapter, Vrtcal as Primary

class VRTInterstitialCustomEventFyberFairBid: VRTAbstractInterstitialCustomEvent, FYBInterstitialDelegate {
    private var placementId: String?

    func loadInterstitialAd() {
        VRTLogWhereAmI()
        placementId = customEventConfig.thirdPartyCustomEventData["adUnitId"] as? String
        FYBInterstitial.delegate = self
        FYBInterstitial.request(placementId)
    }

    func showInterstitialAd() {
        VRTLogWhereAmI()
        let fybShowOptions = FYBShowOptions()
        fybShowOptions.viewController = viewControllerDelegate.vrtViewControllerForModalPresentation()
        FYBInterstitial.show(placementId, options: fybShowOptions)
    }

    // MARK: - MPAdViewDelegate

    func interstitialIsAvailable(_ placementId: String?) {
        //    Called when an Interstitial from placement becomes available
        VRTLogWhereAmI()
        customEventLoadDelegate.customEventLoaded()
    }

    func interstitialIsUnavailable(_ placementId: String?) {
        //    Called when an Interstitial from placement becomes unavailable
        VRTLogWhereAmI()
        //No Vrtcal Analog
    }

    func interstitialDidShow(_ placementId: String?, impressionData: FYBImpressionData?) {
        //    Called when an Interstitial from placement shows up. In case the ad is a video, audio play will start here.
        VRTLogWhereAmI()
        customEventShowDelegate.customEventShown()
        customEventShowDelegate.customEventDidPresentModal(VRTModalTypeInterstitial)
    }

    func interstitialDidFail(toShow placementId: String?, withError error: Error?, impressionData: FYBImpressionData?) {
        //    Called when an error arises when showing an Interstitial from placement
        VRTLogWhereAmI()
        //No Vrtcal Analog
    }

    func interstitialDidClick(_ placementId: String?) {
        //    Called when an Interstitial from placement is clicked
        VRTLogWhereAmI()
        customEventShowDelegate.customEventClicked()
    }

    func interstitialDidDismiss(_ placementId: String?) {
        //    Called when an Interstitial from placement hides. In case the ad is a video, audio play will stop here.
        VRTLogWhereAmI()
        customEventShowDelegate.customEventDidDismissModal(VRTModalTypeInterstitial)
    }

    func interstitialWillRequest(_ placementId: String?) {
        //    Called when an Interstitial is going to be requested.
        VRTLogWhereAmI()
        //No Vrtcal Analog
    }
}

//Fyber FairBid Interstitial Adapter, Vrtcal as Primary