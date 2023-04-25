//
// Created by Сергей Махленко on 01.04.2023.
//

import Foundation

struct Tracker {
    let id: UUID
    let name: String
    let categoryUuid: UUID
    let schedule: [WeekDay]?
    let emoji: String
    let color: Colors
    var completeAt: [Date] = []

    mutating func completed(date: Date) {
        completeAt.append(date)
        print("✅Tracker \"\(name)\" is completed.")
    }
}
