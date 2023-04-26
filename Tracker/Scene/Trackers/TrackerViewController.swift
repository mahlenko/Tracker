//
// Created by Сергей Махленко on 01.04.2023.
//

import Foundation
import UIKit

extension TrackerViewController: TrackerPresenterProtocol, UISearchBarDelegate, UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let itemsFilter = items.filter { tracker in
            tracker.name.lowercased().contains(searchText.lowercased())
        }

        if searchText.count > 0 {
            resultSections = willCollectSections(categories: categories, trackers: itemsFilter)
        } else {
            resultSections = willCollectSections(categories: categories, trackers: items)
        }

        collectionTracker?.collection.reloadData()
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
        resultSections.count
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
        let section = resultSections[indexPath.section]

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
        resultSections[section].items?.count ?? 0
    }

    func collectionView(
            _ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TrackerCell.identifier,
                for: indexPath) as? TrackerCell

        let section = resultSections[indexPath.section]
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

    private var sections: [CollectionSection] = []
    private var resultSections: [CollectionSection] = []

    private var items: [Tracker] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = tabBarItem.title

        let datePicker = DatePickerController(presenter: self).register()
        datePicker.picker.addTarget(self, action: #selector(changeDate(sender:)), for: .valueChanged)
        CreateTrackerButton(presenter: self).register()
        SearchController(presenter: self).register()
        collectionTracker = CollectionTracker(presenter: self).register()

        items = fetchData()

        if items.count > 0 {
            sections = willCollectSections(categories: categories, trackers: items)
            resultSections = sections

            collectionTracker?.showEmptyDataView(visible: false)
        }
    }

    private func fetchData() -> [Tracker] {
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
    }

    // Will collect data in the sections
    private func willCollectSections(categories: [Category], trackers: [Tracker]) -> [CollectionSection] {
        let groupTrackers = Dictionary(grouping: trackers, by: { $0.categoryUuid })

        var collection: [CollectionSection] = []
        groupTrackers.forEach { (categoryUuid: UUID, trackers: [Tracker]) in
            let category = categories.first { $0.uuid == categoryUuid }
            if let category = category {
                collection.append(CollectionSection(category: category, items: trackers))
            }
        }

        collection.sort { section, section2 in
            section.category.name < section2.category.name
        }

        return collection
    }

    // Mock data set
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
