//
//  SceneDelegate.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/04.
//

import UIKit
import Amplify

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func AmplifyFetchAuth(fetchAuthHandler: @escaping (Bool) -> ()) {
        Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success(let session):
                print("Is user signed in - \(session.isSignedIn)")
                DispatchQueue.main.async {
                    fetchAuthHandler(session.isSignedIn)
                }
            case .failure(let error):
                print("Fetch session failed with error \(error)")
            }
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        //Fetch delay 기다리기 위한 instantView
        let instantViewController = UIViewController()
        instantViewController.view.backgroundColor = Colors.Layout.I0
        self.window?.rootViewController = instantViewController
        self.window?.makeKeyAndVisible()
        
        AmplifyFetchAuth { userSignedIn in
            let viewController: UIViewController
            if userSignedIn {
                //Login 했을 때 viewController
                viewController = TabBarController()
            } else {
                //Login 안했을 때 viewController
//                let startViewController = StartViewController()
//                viewController = UINavigationController(rootViewController: startViewController)
                viewController = TabBarController()
            }
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
        
        //임시
//        let registerViewController = RegisterViewController()
//        let instantViewController = UINavigationController(rootViewController: registerViewController)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

