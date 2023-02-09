//
//  SceneDelegate.swift
//  UrlProject
//
//  Created by Olha Dzhyhirei on 2/4/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabVC()
        window?.makeKeyAndVisible()
    }

    
    func createTabVC() -> UITabBarController {
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.tintColor = .systemBlue
        tabBarVC.viewControllers = [createJokeVC(), createCategoryNC(), createSearchVC(), createFavoriteVC()]
        return tabBarVC
    }
    
    func createSearchVC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 2)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteVC() -> UINavigationController {
        let favoriteVC = FavoriteVC()
        favoriteVC.title = "Favorite jokes"
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star.fill"), tag: 3)
        return UINavigationController(rootViewController: favoriteVC)
    }
    
    func createJokeVC() -> UIViewController {
        let data = JokeDetailVC.JokeDetailVCData()
        let jokeVC = JokeDetailVC(jokeVCData: data)
        jokeVC.tabBarItem = UITabBarItem(title: "Random", image: UIImage(systemName: "questionmark.circle.fill"), tag: 0)
        return jokeVC
    }
    
    func createCategoryNC() -> UINavigationController {
        let categoryVC = CategoryVC()
        categoryVC.title = "Categorys"
        categoryVC.tabBarItem = UITabBarItem(title: "Categorys", image: UIImage(systemName: "list.star"), tag: 1)
        return UINavigationController(rootViewController: categoryVC)
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

