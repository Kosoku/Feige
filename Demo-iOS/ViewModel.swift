//
//  ViewModel.swift
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

import Combine
import Feige
import Foundation
import UIKit

extension ViewModel.Snapshot: ScopeFunctions {}

final class ViewModel {
    // MARK: - Public Types
    enum Section: Hashable {
        case classes
        
        // MARK: - Public Properties
        var title: String {
            switch self {
            case .classes:
                return "Classes"
            }
        }
    }
    enum Item: Hashable {
        case timer
        
        // MARK: - Public Properties
        var title: String {
            switch self {
            case .timer:
                return "Timer"
            }
        }
        
        var viewControllerForPushing: UIViewController? {
            switch self {
            case .timer:
                return BlockTimerViewController()
            }
        }
    }
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    // MARK: - Public Properties
    @Published
    private(set) var snapshot: Snapshot
    
    // MARK: - Initializers
    init() {
        self.snapshot = Snapshot()
            .also {
                $0.appendSections([.classes])
                $0.appendItems([.timer], toSection: .classes)
            }
    }
}
