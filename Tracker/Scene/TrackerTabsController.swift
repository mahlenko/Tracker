//
// Created by Сергей Махленко on 01.04.2023.
//

import Foundation
import UIKit

class TrackerTabsController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        createNavigation([
            TrackerViewController(),
            StatisticViewController()
        ])

        configureNavigationBar()
    }

    private func createNavigation(_ navigationControllers: [UIViewController]) {
        var tabs: [UINavigationController] = []

        navigationControllers.forEach { navigation in
            let navigationController = UINavigationController(rootViewController: navigation)
            if navigation.tabBarItem.title != nil && navigation.tabBarItem.image != nil {
                navigationController.tabBarItem = navigation.tabBarItem
                tabs.append(navigationController)
            }
        }

        viewControllers = tabs
    }

    private func configureNavigationBar() {
        view.backgroundColor = UIColor(named: "White")
        tabBar.tintColor = UIColor(named: "Blue")
        tabBar.unselectedItemTintColor = UIColor(named: "Gray")

        UITabBarItem.appearance()
            .setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12) ], for: .normal)
    }
}
