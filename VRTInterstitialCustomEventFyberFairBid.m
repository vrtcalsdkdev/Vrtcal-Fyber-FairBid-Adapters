//
//  VRTInterstitialCustomEventMoPub.m
//
//  Created by Scott McCoy on 5/9/19.
//  Copyright © 2019 VRTCAL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRTInterstitialCustomEventFyberFairBid.h"

#import <FairBidSDK/FYBInterstitial.h>

//MoPub Interstitial Adapter, Vrtcal as Primary
@interface VRTInterstitialCustomEventFyberFairBid() <FYBInterstitialDelegate>
@property NSString *placementId;
@end


@implementation VRTInterstitialCustomEventFyberFairBid

- (void) loadInterstitialAd {
    VRTLogWhereAmI();
    self.placementId = [self.customEventConfig.thirdPartyCustomEventData objectForKey:@"adUnitId"];
    FYBInterstitial.delegate = self;
    [FYBInterstitial request:self.placementId];
}

- (void) showInterstitialAd {
    VRTLogWhereAmI();
    FYBShowOptions *fybShowOptions = [[FYBShowOptions alloc] init];
    fybShowOptions.viewController = [self.viewControllerDelegate vrtViewControllerForModalPresentation];
    [FYBInterstitial show:self.placementId options:fybShowOptions];
}

#pragma mark - MPAdViewDelegate
- (void)interstitialIsAvailable:(NSString *)placementId {
//    Called when an Interstitial from placement becomes available
    VRTLogWhereAmI();
    [self.customEventLoadDelegate customEventLoaded];
}
 
- (void)interstitialIsUnavailable:(NSString *)placementId {
//    Called when an Interstitial from placement becomes unavailable
    VRTLogWhereAmI();
    //No Vrtcal Analog
}
 
- (void)interstitialDidShow:(NSString *)placementId impressionData:(FYBImpressionData *)impressionData {
//    Called when an Interstitial from placement shows up. In case the ad is a video, audio play will start here.
    VRTLogWhereAmI();
    [self.customEventShowDelegate customEventShown];
    [self.customEventShowDelegate customEventDidPresentModal:VRTModalTypeInterstitial];
}
 
- (void)interstitialDidFailToShow:(NSString *)placementId withError:(NSError *)error impressionData:(FYBImpressionData *)impressionData {
//    Called when an error arises when showing an Interstitial from placement
    VRTLogWhereAmI();
    //No Vrtcal Analog
}
 
- (void)interstitialDidClick:(NSString *)placementId {
//    Called when an Interstitial from placement is clicked
    VRTLogWhereAmI();
    [self.customEventShowDelegate customEventClicked];
}
 
- (void)interstitialDidDismiss:(NSString *)placementId {
//    Called when an Interstitial from placement hides. In case the ad is a video, audio play will stop here.
    VRTLogWhereAmI();
    [self.customEventShowDelegate customEventDidDismissModal:VRTModalTypeInterstitial];
}
 
- (void)interstitialWillRequest:(NSString *)placementId {
//    Called when an Interstitial is going to be requested.
    VRTLogWhereAmI();
    //No Vrtcal Analog
}
 
@end
