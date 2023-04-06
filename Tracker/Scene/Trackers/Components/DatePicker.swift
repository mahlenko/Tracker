//
// Created by Сергей Махленко on 06.04.2023.
//

import Foundation
import UIKit

class DatePickerController: NSObject {
    public let datePicker = UIDatePicker()
    private let presenter: UIViewController

    init(presenter: UIViewController) {
        self.presenter = presenter
        super.init()
    }

    func register() -> Self {
        presenter.navigationItem.rightBarButtonItem = UIBarButtonItem(
                customView: datePicker)

        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact

        NSLayoutConstraint.activate([
            datePicker.widthAnchor.constraint(equalToConstant: 110)
        ])

        return self
    }
}
