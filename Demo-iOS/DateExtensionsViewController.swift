//
//  DateExtensionsViewController.swift
//  Demo-iOS
//
//  Created by William Towe on 10/16/23.
//  Copyright © 2023 Kosoku Interactive, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import Feige
import Foundation
import os.log
import Romita
import UIKit

final class DateExtensionsViewController: UIViewController {
    // MARK: - Private Properties
    private let stackView = UIStackView()
        .setTranslatesAutoresizingMaskIntoConstraints()
        .also {
            $0.axis = .vertical
            $0.alignment = .center
        }
    private let datePicker = UIDatePicker()
        .setTranslatesAutoresizingMaskIntoConstraints()
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ViewModel.Item.dateExtensions.title
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.stackView.also {
            $0.addArrangedSubview(self.datePicker.also {
                $0.addTarget(self, action: #selector(datePickerAction(sender:)), for: .valueChanged)
            })
        })
        self.stackView.pinToSuperviewEdges([.leading, .trailing], safeAreaLayoutGuideEdges: .top)
    }
    
    // MARK: - Private Functions
    @objc
    private func datePickerAction(sender: UIDatePicker) {
        os_log("second %@\nminute %@\nhour %@\nday %@\nmonth %@\nyear %@\nstarOfDay %@\nendOfDay %@\nstartOfWeek %@\nendOfWeek %@\nstartOfMonth %@\nendOfMonth %@\nstartOfYear %@\nendOfYear %@", log: .viewController, String(describing: sender.date.second), String(describing: sender.date.minute), String(describing: sender.date.hour), String(describing: sender.date.day), String(describing: sender.date.month), String(describing: sender.date.year), String(describing: sender.date.startOfDay), String(describing: sender.date.endOfDay), String(describing: sender.date.startOfWeek), String(describing: sender.date.endOfWeek), String(describing: sender.date.startOfMonth), String(describing: sender.date.endOfMonth), String(describing: sender.date.startOfYear), String(describing: sender.date.endOfYear))
    }
}
