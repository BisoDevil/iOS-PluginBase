Pod::Spec.new do |s|
    s.name         = 'MoEngagePluginBase'
    s.version      = '4.3.0'
    s.summary      = 'MoEngage Plugin Base for Hybrid SDKs'
    s.description  = <<-DESC
    MoEngage is a mobile marketing automation company. This framework is used by our plugins built for different hybrid frameworks i.e, Flutter, Cordova, React Native etc.
                     DESC

    s.homepage     = 'https://www.moengage.com'
    s.documentation_url = 'https://developers.moengage.com/'
    s.license      = { :type => 'Commercial', :file => 'LICENSE' }
    s.author       = { 'MobileDevs' => 'mobiledevs@moengage.com' }
    s.social_media_url   = 'https://twitter.com/moengage'
    s.platform     = :ios
    s.ios.deployment_target = '11.0'
    
    s.source       = {
                        :git => 'https://github.com/moengage/iOS-PluginBase.git',
                        :tag => 'pluginBase-' + s.version.to_s
                    }

    s.source_files = 'MoEngagePluginBase/**/*'
    s.swift_version = '5.0'
    s.frameworks = 'UIKit', 'Foundation', 'UserNotifications'
    s.dependency 'MoEngage-iOS-SDK', '>= 9.10.0', '< 9.11.0'
    s.dependency 'MoEngageInApp', '>= 4.10.0', '< 4.11.0'
end
