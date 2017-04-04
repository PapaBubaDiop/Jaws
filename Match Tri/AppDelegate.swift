//
//  AppDelegate.swift
//  Match Tri
//
//  Created by vadim on 10/20/16.
//  Copyright © 2016 vadim. All rights reserved.
//



import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ChartboostDelegate {
    
    var window: UIWindow?
    let soundLib = OALSimpleAudioSample()
    var requestLib = Request()
    
    var pause = true
    
 // ads
    var bannerView: GADBannerView!
    var GADFlag = 0
    
    var iPhone = 1
    var iPad = 0
    
    enum AppName {
        case jaws2017
        case jaws2
    }
    var appName = AppName.jaws2
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initDeviceFlag()
        requestLib.loadPrefs()
        initChartboostAds()
        
        pause = false
        
        return true
    }
    
    func updateRank() {
        requestLib.saveScore(0)
    }
    
    
    func initDeviceFlag() {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        
        switch (deviceIdiom) {
            
        case .pad:
            print("iPad style UI")
            iPad = 1
            iPhone = 0
        case .phone:
            print("iPhone and iPod touch style UI")
            iPad = 0
            iPhone = screenHeight<500 ? 0 : 1
        case .tv:
            print("tvOS style UI")
        default:
            print("Unspecified UI idiom")
        }
        
    }
    
    
    func playSound(_ trek:Int) {
        soundLib.playSound(Int32(trek))
    }
    
    func setSoundVolume(_ v:Double) {
        let v2 = Float(v*v)
        soundLib.setEffectVolume(v2)
        soundLib.setBgVolume(0)
    }
    
    func stopSounds()
    {
        soundLib.onGameOver()
    }
    
    
    
    
    func initChartboostAds() {
        if appName == .jaws2 {
            return
        }
        switch appName {
        case .jaws2017:
            Chartboost.start(withAppId: "58cffda5f6cd453ec313e07f", appSignature: "63aaacc3c90d9a5d579d08507c72985a9059ed68", delegate: self)
        case .jaws2:
            Chartboost.start(withAppId: "589ce45143150f1b8ba5ba1b", appSignature: "08f5dd6e4c2000dc1e6d77720b401c3471493334", delegate: self)
        }
        Chartboost.cacheRewardedVideo(CBLocationHomeScreen)
    }
    
    
    
    func showChartboostAds() {
        if appName == .jaws2 {
            return
        }
        
        Chartboost.showInterstitial(CBLocationHomeScreen)
    }
    
    func initAdMob() {
        
        if GADFlag>0 {
            return
        }
        
        GADFlag = 1
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.rootViewController = self.window?.rootViewController
        let adViewHeight = bannerView.frame.size.height
        let screenSize: CGRect = UIScreen.main.bounds
        //       let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        bannerView.frame.origin = CGPoint(x: 0, y: screenHeight -  adViewHeight)
        switch appName {
        case .jaws2017:
            bannerView.adUnitID = "ca-app-pub-9980022107741499/4907363560"
        case .jaws2:
            bannerView.adUnitID = "ca-app-pub-9980022107741499/3535571568"
        }
        let googleRequest = GADRequest()
        googleRequest.testDevices = [kGADSimulatorID ]
        self.window?.rootViewController!.view.addSubview(bannerView)
        bannerView.load(googleRequest)
    }

    func bringGADtoFront() {
        if GADFlag>0 {
            self.window?.rootViewController!.view.bringSubview(toFront: bannerView)
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        pause = true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        pause = false
        requestLib.updateRank()
    }
    
}


