//
// Created by Сергей Махленко on 06.04.2023.
//

import Foundation
import UIKit

// MARK: - Action

extension CreateTrackerButton {
    @objc func tapAction() {
        let controllerView = UIViewController()
        controllerView.view.backgroundColor = .orange
        presenter.present(controllerView, animated: true)
    }
}

// MARK: - Default initialize

final class CreateTrackerButton: UIBarButtonItem {
    private let presenter: UIViewController

    override var style: Style {
        get { .plain }
        set { super.style = newValue }
    }

    override var image: UIImage? {
        get {
            UIImage(
                systemName: "plus",
                withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))?
                .withTintColor(UIColor(named: "Black")!, renderingMode: .alwaysOriginal)
        }
        set { super.image = newValue }
    }

    init(presenter: UIViewController) {
        self.presenter = presenter

        super.init()
        action = #selector(tapAction)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func register() {
        presenter.navigationItem.leftBarButtonItem = self
    }
}
