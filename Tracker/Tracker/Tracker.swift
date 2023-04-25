//
// Created by Сергей Махленко on 01.04.2023.
//

import Foundation

class Tracker {
    let id: UUID
    let name: String
    let categoryUuid: UUID
    let schedule: [WeekDay]?
    let emoji: String
    let color: Colors
    var completeAt: [Date] = []

    init(
        id: UUID,
        name: String,
        categoryUuid: UUID,
        schedule: [WeekDay]?,
        emoji: String,
        color: Colors,
        completeAt: [Date] = []
    ) {
        self.id = id
        self.name = name
        self.categoryUuid = categoryUuid
        self.schedule = schedule
        self.emoji = emoji
        self.color = color
        self.completeAt = completeAt
    }

    func completed(date: Date) {
        completeAt.append(date)
        print("✅Tracker \"\(name)\" is completed.")
    }
}
