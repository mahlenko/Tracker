//
// Created by Сергей Махленко on 07.04.2023.
//

import Foundation
import UIKit

final class TrackerCell: UICollectionViewCell {
    static let identifier = "trackerCell"

    private let card = UIView()
    private let nameView = UILabel()
    private let emojiView = UILabel()

    private let completionRowView = UIView()
    private let completedLabel = UILabel()
    private let completedButtonView = UIButton()

    func setupForTracking(tracker: Tracker) {
        // add subviews
        completionRowView.addSubview(completedLabel)
        completionRowView.addSubview(completedButtonView)

        card.addSubview(emojiView)
        card.addSubview(nameView)

        contentView.addSubview(card)
        contentView.addSubview(completionRowView)

        // card configure
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.masksToBounds = true
        card.layer.cornerRadius = 16
        card.backgroundColor = UIColor.init(rgb: tracker.color.rawValue)

        // name label configure
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.text = tracker.name
        nameView.font = .systemFont(ofSize: 14)
        nameView.textColor = .white
        nameView.numberOfLines = 0

        // emoji label configure
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.text = tracker.emoji
        emojiView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        emojiView.layer.masksToBounds = true
        emojiView.layer.cornerRadius = 15
        emojiView.textAlignment = .center
        emojiView.frame = CGRect(
            x: emojiView.frame.minX,
            y: emojiView.frame.minY,
            width: emojiView.frame.width + 20,
            height: emojiView.frame.height + 20)

        // completions row configure
        completionRowView.translatesAutoresizingMaskIntoConstraints = false

        // completion button configure
        completedButtonView.translatesAutoresizingMaskIntoConstraints = false
        completedButtonView.layer.masksToBounds = true
        completedButtonView.layer.cornerRadius = 17
        completedButtonView.backgroundColor = UIColor.init(rgb: tracker.color.rawValue)
        completedButtonView.setImage(UIImage(systemName: "plus"), for: .normal)
        completedButtonView.tintColor = UIColor(named: "White")

        completedLabel.translatesAutoresizingMaskIntoConstraints = false
        completedLabel.font = .systemFont(ofSize: 14)
        completedLabel.text = (tracker.completeAt?.count ?? 0).toStringChoice("день", "дня", "дней")

        configureConstraints()
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            card.topAnchor.constraint(equalTo: contentView.topAnchor),
            card.heightAnchor.constraint(equalToConstant: 100),

            emojiView.topAnchor.constraint(equalTo: card.topAnchor, constant: 12),
            emojiView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 12),
            emojiView.widthAnchor.constraint(equalToConstant: 30),
            emojiView.heightAnchor.constraint(equalToConstant: 30),

            nameView.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -12),
            nameView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 12),
            nameView.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -12),

            completionRowView.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 8),
            completionRowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            completionRowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            completionRowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            completedLabel.leadingAnchor.constraint(equalTo: completionRowView.leadingAnchor, constant: 12),
            completedLabel.trailingAnchor.constraint(equalTo: completedButtonView.leadingAnchor, constant: -12),
            completedLabel.topAnchor.constraint(equalTo: completionRowView.topAnchor),
            completedLabel.bottomAnchor.constraint(equalTo: completionRowView.bottomAnchor, constant: -8),

            completedButtonView.trailingAnchor.constraint(equalTo: completionRowView.trailingAnchor, constant: -12),
            completedButtonView.widthAnchor.constraint(equalToConstant: 34),
            completedButtonView.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}