//
// Created by Сергей Махленко on 07.04.2023.
//

import Foundation
import UIKit

final class TrackerHeaderCollection: UICollectionReusableView {
    private var titleLabelView: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Black")
        label.font = .systemFont(ofSize: 19, weight: .bold)
        return label
    }()

    static let identifier = "header"

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleLabelView)

        NSLayoutConstraint.activate([
            titleLabelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 12),
            titleLabelView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabelView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setTitle(title: String) {
        titleLabelView.text = title
    }
}
