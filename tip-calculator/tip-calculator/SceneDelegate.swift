//
//  SceneDelegate.swift
//  tip-calculator
//
//  Created by Rostyslav Didenko on 11.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowsScene)
        let rvc = CalculatorVC()
        window.rootViewController = rvc
        self.window = window
        window.makeKeyAndVisible()
    }
}

