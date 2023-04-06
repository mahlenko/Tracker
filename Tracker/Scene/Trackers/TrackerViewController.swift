//
// Created by Сергей Махленко on 01.04.2023.
//

import Foundation
import UIKit

extension TrackerViewController: TrackerPresenterProtocol, UISearchBarDelegate, UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search: \(searchText)")
    }

    @objc func changeDate(sender: UIDatePicker) {
        print("Change date: \(sender.date)")
        presentedViewController?.dismiss(animated: false, completion: nil)
    }
}

class TrackerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = tabBarItem.title

        let datePicker = DatePickerController(presenter: self).register()
        CreateTrackerButton(presenter: self).register()
        SearchController(presenter: self).register()
        CollectionTracker(presenter: self).register()

        datePicker.picker.addTarget(self, action: #selector(changeDate(sender:)), for: .valueChanged)
    }

    override var tabBarItem: UITabBarItem! {
        get {  UITabBarItem(title: "Трекеры", image: UIImage(systemName: "record.circle.fill")!, tag: 0) }
        set { super.tabBarItem = newValue }
    }
}
