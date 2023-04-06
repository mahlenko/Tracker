//
// Created by Сергей Махленко on 06.04.2023.
//

import Foundation
import UIKit

extension CollectionTracker {
    func showEmptyDataView(visible: Bool) {
        emptyDataView.isHidden = !visible
    }
}

final class CollectionTracker: NSObject {
    public let collection = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout())

    private let presenter: TrackerPresenterProtocol

    private let emptyDataView: UIView = UIView()

    init(presenter: TrackerPresenterProtocol) {
        self.presenter = presenter
    }

    func register() -> Self {
        if let presenter = presenter as? UIViewController {
            presenter.view.addSubview(collection)
            collection.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                collection.topAnchor.constraint(equalTo: presenter.view.topAnchor),
                collection.bottomAnchor.constraint(equalTo: presenter.view.safeAreaLayoutGuide.bottomAnchor),
                collection.leadingAnchor.constraint(equalTo: presenter.view.safeAreaLayoutGuide.leadingAnchor),
                collection.trailingAnchor.constraint(equalTo: presenter.view.safeAreaLayoutGuide.trailingAnchor)
            ])

            createEmptyDataView(message: "Что будем отслеживать?")
        }

        return self
    }

    private func createEmptyDataView(message: String) {
        let imageNoData = UIImageView(image: UIImage(named: "no-data")!)
        let textLabel = UILabel()

        textLabel.text = message
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.tintColor = UIColor(named: "Black")

        emptyDataView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        emptyDataView.addSubview(imageNoData)
        emptyDataView.addSubview(textLabel)

        collection.backgroundView = emptyDataView

        if let presenter = presenter as? UIViewController {
            NSLayoutConstraint.activate([
                emptyDataView.centerXAnchor.constraint(equalTo: presenter.view.centerXAnchor),
                emptyDataView.centerYAnchor.constraint(equalTo: presenter.view.centerYAnchor),
                textLabel.centerXAnchor.constraint(equalTo: collection.centerXAnchor),
                imageNoData.centerXAnchor.constraint(equalTo: collection.centerXAnchor),
                textLabel.topAnchor.constraint(equalTo: imageNoData.bottomAnchor, constant: 8)
            ])
        }
    }
}
