//
//  AppDelegate.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

//        let tabBarController = setupTabBarController()
//        window?.rootViewController = tabBarController
//        window?.makeKeyAndVisible()
        
        setupKeyboard()
        checkAppLang()
        Localizer.doTheExChange()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK: - func setup keyboard
    private func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
        IQKeyboardManager.shared.keyboardConfiguration.overrideAppearance = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = true
        IQKeyboardManager.shared.goNext()
        IQKeyboardManager.shared.goPrevious()
        IQKeyboardManager.shared.resignFirstResponder()
    }
    
    //MARK: - Check App Lang
    private func checkAppLang() {
        let lang = Language.currentLanguage()
        if lang == "zh-Hans-AE" || lang == "zh-Hans" {
            Language.setAppLanguage(lang: "zh-Hans")
        }else{
            Language.setAppLanguage(lang: "en")
        }
    }
    
    func setupTabBarController() -> UITabBarController {
        // Create your view controllers
        let homeViewController = HomeConfigurator.viewController(input: .init())
        let socialMediaViewController = UIViewController()
        let newsViewController = NewsConfigurator.viewController(input: .init())
        let settingsViewController = UIViewController()

        homeViewController.title = "Home".localized
        homeViewController.tabBarItem = UITabBarItem(title: "Home".localized, image: UIImage(named: "house"), selectedImage: UIImage(named: "house.fill"))

        socialMediaViewController.title = "Connect".localized
        socialMediaViewController.tabBarItem = UITabBarItem(title: "Connect".localized, image: UIImage(named: "link.circle"), selectedImage: UIImage(named: "link.circle.fill"))

        newsViewController.title = "News".localized
        newsViewController.tabBarItem = UITabBarItem(title: "News".localized, image: UIImage(named: "newspaper"), selectedImage: UIImage(named: "newspaper.fill"))

        settingsViewController.title = "Settings".localized
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings".localized, image: UIImage(named: "gear"), selectedImage: UIImage(named: "gear.fill"))

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeViewController, socialMediaViewController, newsViewController, settingsViewController]

        return tabBarController
    }

}

