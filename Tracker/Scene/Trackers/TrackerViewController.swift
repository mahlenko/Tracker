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

extension TrackerViewController: UICollectionViewDelegateFlowLayout {
    // set margin cells
    func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            insetForSectionAt section: Int) -> UIEdgeInsets {
        let xySize = marginsBetweenCells / 2
        return UIEdgeInsets(top: xySize, left: xySize, bottom: xySize, right: xySize)
    }

    // set cell sizes
    func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / perRow - marginsBetweenCells
        return CGSize(width: width, height: 150)
    }
}

extension TrackerViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.size.width, height: 50.0)
    }

    public func collectionView(
            _ collectionView: UICollectionView,
            viewForSupplementaryElementOfKind kind: String,
            at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section]

        //
        switch kind {
        case "UICollectionElementKindSectionHeader":
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TrackerHeaderCollection.identifier,
                for: indexPath) as? TrackerHeaderCollection

            guard let header else { return UICollectionReusableView() }
            header.setTitle(title: section.category.name)

            return header
        default:
            fatalError("collectionView(_:viewForSupplementaryElementOfKind:at:) has not been implemented")
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].items?.count ?? 0
    }

    func collectionView(
            _ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrackerCell.identifier,
                for: indexPath) as? TrackerCell

        let section = sections[indexPath.section]
        let tracker = section.items?[indexPath.row]

        cell?.setupForTracking(tracker: tracker!)

        return cell!
    }
}

class TrackerViewController: UIViewController {
    private let perRow: CGFloat = 2
    private let marginsBetweenCells: CGFloat = 10
    private var collectionTracker: CollectionTracker?

    private var categories = [
        Category.init(uuid: UUID(), name: "Домашний уют"),
        Category.init(uuid: UUID(), name: "Радостные мелочи"),
        Category.init(uuid: UUID(), name: "Самочувствие")
    ]

    private lazy var items = {
        [
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!,
            randomTracker(categories: categories)!
        ]
    }()

    private var sections: [CollectionSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = tabBarItem.title

        let datePicker = DatePickerController(presenter: self).register()
        datePicker.picker.addTarget(self, action: #selector(changeDate(sender:)), for: .valueChanged)
        CreateTrackerButton(presenter: self).register()
        SearchController(presenter: self).register()
        collectionTracker = CollectionTracker(presenter: self).register()

        if items.count > 0 {
            buildSections(categories: categories, trackers: items)
            collectionTracker?.showEmptyDataView(visible: false)
        }
    }

    private func buildSections(categories: [Category], trackers: [Tracker]) {
        let groupTrackers = Dictionary(grouping: trackers, by: { $0.categoryUuid })

        groupTrackers.forEach { (categoryUuid: UUID, trackers: [Tracker]) in
            let category = categories.first { $0.uuid == categoryUuid }
            if let category = category {
                sections.append(CollectionSection(category: category, items: trackers))
            }
        }
    }

    private func randomTracker(categories: [Category]) -> Tracker? {
        var emojiList = [
            "🍇", "🍈", "🍉", "🍊", "🍋",
            "🍌", "🍍", "🥭", "🍎", "🍏",
            "🍐", "🍒", "🍓", "🫐", "🥝",
            "🍅", "🫒", "🥥", "🥑", "🍆",
            "🥔", "🥕", "🌽", "🌶️", "🫑",
            "🥒", "🥬", "🥦", "🧄", "🧅",
            "🍄"]

        emojiList.shuffle()

        var names = [
            "Кошка заслонила камеру на созвоне",
            "Запись к стамотологу",
            "Встреча дня рождения 🥳"
        ]
        names.shuffle()

        var categoryList = categories
        categoryList.shuffle()

        guard let uuid = categoryList.first?.uuid else { return nil }

        return Tracker.init(
            id: UUID(),
            name: names.first!,
            categoryUuid: uuid,
            schedule: [],
            emoji: emojiList.first!,
            color: Colors.allCases.randomElement()!,
            completeAt: [])
    }

    override var tabBarItem: UITabBarItem! {
        get {  UITabBarItem(title: "Трекеры", image: UIImage(systemName: "record.circle.fill")!, tag: 0) }
        set { super.tabBarItem = newValue }
    }
}
