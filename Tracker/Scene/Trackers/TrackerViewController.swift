//
// Created by Сергей Махленко on 01.04.2023.
//

import Foundation
import UIKit

class TrackerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = tabBarItem.title

        let createButton = CreateTrackerButton(presenter: self).register()
        let searchController = SearchController(presenter: self).register()
        let datePicker = DatePickerController(presenter: self).register()
        let collection = CollectionTracker(presenter: self).register()
    }

    override var tabBarItem: UITabBarItem! {
        get {  UITabBarItem(title: "Трекеры", image: UIImage(systemName: "record.circle.fill")!, tag: 0) }
        set { super.tabBarItem = newValue }
    }
}
