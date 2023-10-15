//
//  BlockTimerViewController.swift
//  Demo-iOS
//
//  Created by William Towe on 10/15/23.
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

final class BlockTimerViewController: UIViewController {
    // MARK: - Private Properties
    private let stackView = UIStackView()
        .setTranslatesAutoresizingMaskIntoConstraints()
        .also {
            $0.axis = .vertical
            $0.alignment = .center
        }
    private let onceButton = UIButton(type: .system)
        .setTranslatesAutoresizingMaskIntoConstraints()
        .also {
            $0.setTitle("Once Timer", for: .normal)
        }
    private let repeatingButton = UIButton(type: .system)
        .setTranslatesAutoresizingMaskIntoConstraints()
        .also {
            $0.setTitle("Repeating Timer", for: .normal)
        }
    
    private var onceTimer: BlockTimer?
    private var repeatingTimer: BlockTimer?
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ViewModel.Item.timer.title
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.stackView.also {
            $0.addArrangedSubviews([self.onceButton.also {
                $0.addTarget(self, action: #selector(onceButtonAction(sender:)), for: .touchUpInside)
            }, self.repeatingButton.also {
                $0.addTarget(self, action: #selector(repeatingButtonAction(sender:)), for: .touchUpInside)
            }])
        })
        self.stackView.pinToSuperviewEdges([.leading, .trailing], safeAreaLayoutGuideEdges: .top)
    }
    
    // MARK: - Private Functions
    @objc
    private func onceButtonAction(sender: UIButton) {
        self.onceTimer = .scheduled(timeInterval: 1.0) { _ in
            os_log("once timer", log: .viewController)
        }
    }
    
    @objc
    private func repeatingButtonAction(sender: UIButton) {
        self.repeatingTimer = .scheduled(timeInterval: 1.0, repeats: true) { _ in
            os_log("repeating timer", log: .viewController)
        }
    }
}
