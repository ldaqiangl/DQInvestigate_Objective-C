# Uncomment the next line to define a global platform for your project
source 'https://git.xzlcorp.com/daqiang/XZLDependencyPodSpecs.git'  #私有spec仓库的地址
source 'https://github.com/CocoaPods/Specs.git'  #官方仓库的地址

inhibit_all_warnings!
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
        end
    end
    
end

platform :ios, '8.0'

target 'DQInvestigate' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  use_frameworks!

  # Pods for DQInvestigate
    
    #项目公共依赖库
    #pod 'XZLDependencyPackage/BaseClass/WebViewController', :git => "git@git.xzlcorp.com:daqiang/XZLDependencyPackage.git"
    #pod 'XZLDependencyPackage/Helper/Network', :git => "git@git.xzlcorp.com:daqiang/XZLDependencyPackage.git"
    #pod 'XZLDependencyPackage/Helper/Storage', :git => "git@git.xzlcorp.com:daqiang/XZLDependencyPackage.git"
    #pod 'XZLDependencyPackage/Module', :git => "git@git.xzlcorp.com:daqiang/XZLDependencyPackage.git"
    #pod 'XZLDependencyPackage/Statistics', :git => "git@git.xzlcorp.com:daqiang/XZLDependencyPackage.git"
    pod 'XZLDependencyPackage’, ‘0.0.9’

    pod 'AFNetworking'
    pod 'ReactiveCocoa'
    pod 'Aspects'
    pod 'MagicalRecord'
    pod 'Masonry'
    pod 'HandyAutoLayout'
    pod 'JSPatch'
    pod 'Mixpanel'
    pod 'SDWebImage'
    pod 'YYKit'

  target 'DQInvestigateTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DQInvestigateUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end








