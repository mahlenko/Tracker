//
// Created by Сергей Махленко on 01.04.2023.
//

import Foundation
import UIKit

class StatisticViewController: UIViewController {
    override var tabBarItem: UITabBarItem! {
        get { UITabBarItem(title: "Статистика", image: UIImage(systemName: "hare.fill")!, tag: 0) }
        set { super.tabBarItem = newValue }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
