//
// Created by Сергей Махленко on 06.04.2023.
//

import Foundation
import UIKit

class SearchController: NSObject {
    public let controller: UISearchController = UISearchController()
    private var searchBar: UISearchBar = UISearchBar()
    private let presenter: UIViewController

    init(presenter: UIViewController) {
        self.presenter = presenter

        super.init()
        controller.delegate = self
        searchBar.delegate = self

        controller.hidesNavigationBarDuringPresentation = false
    }

    func register() -> Self {
        presenter.navigationItem.searchController = controller
        return self
    }
}

extension SearchController: UISearchControllerDelegate {}

extension SearchController: UISearchBarDelegate {}
