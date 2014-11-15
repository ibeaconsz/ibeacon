# Uncomment this line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, "6.0"

target "ComicFans-iOS" do


############# CORE ################

# core - framework
pod 'ReactiveCocoa', '~> 2.3.1'
pod 'ReactiveViewModel', '~> 0.2'

# core - injection & AOP
#pod 'Typhoon', '~> 2.2.0'
#pod 'Aspects', '~> 1.4.1'

# core - networking
pod 'AFNetworking', '~> 2.4.1'
pod 'AFNetworking-RACExtensions', '0.1.4'
pod 'AFNetworkActivityLogger', '~> 2.0.3'

#http://stackoverflow.com/questions/19041584/does-afnetworking-2-0-support-ios-6-0
#pod 'AFNetworking', '~> 2.0' # Core, without NSURLSession, compatible with iOS6
#pod 'AFNetworking/NSURLSession', '~> 2.0' # Add NSURLSession features, only compatible with iOS7

# core - data parser
pod 'RestKit/ObjectMapping', '~>0.23.3'

# core - cache
#pod 'AFCache', :git => "https://github.com/artifacts/AFCache.git"



# core - log
#pod 'JIRAConnect', '~> 1.2.1'

# core - debug
#pod 'FLEX', '~> 1.1.0'

# utils


# animation
#pod 'pop', '~> 1.0.6'


# view
pod 'UIAlertView+Blocks'
pod 'TTTAttributedLabel'

##############  Project   ################

# project - view
pod 'MBProgressHUD', '~> 0.9'
pod 'SpinKit', '~> 1.1'
pod 'MWPhotoBrowser'
pod 'SDWebImage', '~>3.6'
# project - util


# project - image cache
pod 'FastImageCache', '~> 1.3'

# project - 百度

pod 'TouchJSON', '~> 1.1'

# project - webview
pod 'SVWebViewController', '~> 1.0'
pod 'MASimplestSemiModalViewController', '~> 0.1'

#pod 'XLForm', '~> 2.0.0'

end

target "ComicFans-iOSTests" do

pod 'Expecta', '~> 0.3.1'
pod 'Specta', '~> 0.2.1'

end


post_install do |installer|
    target = installer.project.targets.find { |t| t.to_s == "Pods-ComicFans-iOSTests-Specta" }
    if (target)
        target.build_configurations.each do |config|
            s = config.build_settings['FRAMEWORK_SEARCH_PATHS']
            s = [ '$(inherited)' ] if s == nil;
            s.push('$(PLATFORM_DIR)/Developer/Library/Frameworks')
            config.build_settings['FRAMEWORK_SEARCH_PATHS'] = s
        end
        else
        puts "WARNING: Pods-ComicFans-iOSTests-Specta target not found"
    end
end

post_install do |installer_representation|
    installer_representation.project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        end
    end
end


