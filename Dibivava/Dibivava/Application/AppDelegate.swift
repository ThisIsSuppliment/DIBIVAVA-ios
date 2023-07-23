//
//  AppDelegate.swift
//  Dibivava
//
//  Created by dong eun shin on 2023/07/17.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func checkAppFirstrunOrUpdateStatus(firstrun: () -> (), updated: () -> (), nothingChanged: () -> ()) {
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        let versionOfLastRun = UserDefaults.standard.object(forKey: "VersionOfLastRun") as? String
        // print(#function, currentVersion ?? "", versionOfLastRun ?? "")
        if versionOfLastRun == nil {
            // First start after installing the app
            firstrun()
        } else if versionOfLastRun != currentVersion {
            // App was updated since last run
            updated()
        } else {
            // nothing changed
            nothingChanged()
        }
        UserDefaults.standard.set(currentVersion, forKey: "VersionOfLastRun")
        UserDefaults.standard.synchronize()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 각 상황별로 실행할 작업을 클로저 내에 작성
        checkAppFirstrunOrUpdateStatus {
            print("앱 설치 후 최초 실행할때만 실행됨")
        } updated: {
            print("버전 변경시마다 실행됨")
        } nothingChanged: {
            print("변경 사항 없음")
        }

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


}

