Pod::Spec.new do |s|
    s.name         = "Vrtcal-Fyber-FairBid-Adapters"
    s.version      = "1.0.3"
    s.summary      = "Allows mediation with Vrtcal as either the primary or secondary SDK"
    s.homepage     = "http://vrtcal.com"
    s.license = { :type => 'Copyright', :text => <<-LICENSE
                   Copyright 2020 Vrtcal Markets, Inc.
                  LICENSE
                }
    s.author       = { "Scott McCoy" => "scott.mccoy@vrtcal.com" }
    
    s.source       = { :git => "https://github.com/vrtcalsdkdev/Vrtcal-Fyber-FairBid-Adapters.git", :tag => "#{s.version}" }
    s.source_files = "*.swift"

    s.platform = :ios
    s.ios.deployment_target = '11.0'

    s.dependency 'FairBidSDK'
    s.dependency 'VrtcalSDK'

    s.static_framework = true
end
