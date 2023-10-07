//
//  EmptyValueRepresentable.swift
//  Feige
//
//  Created by William Towe on 10/7/23.
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

import Foundation

/**
 Describes an object that has a specific value representing its empty state.
 */
public protocol EmptyValueRepresentable: Emptyable {
    // MARK: - Public Properties
    /**
     Returns the value representing the receiver's empty state.
     */
    static var emptyValue: Self { get }
}

public extension Optional where Wrapped: EmptyValueRepresentable {
    // MARK: - Public Properties
    /**
     Returns the wrapped value or the `EmptyValueRepresentable.emptyValue` if the receiver is nil.
     
     ```
     let value: String? = nil
     let retval = value.valueOrEmpty
     
     // do something with retval which is ""
     ```
     */
    var valueOrEmpty: Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            return Wrapped.emptyValue
        }
    }
}

extension Array: EmptyValueRepresentable {
    // MARK: - Public Properties
    public static var emptyValue: [Element] {
        []
    }
}

extension Dictionary: EmptyValueRepresentable {
    // MARK: - Public Properties
    public static var emptyValue: [Key: Value] {
        [:]
    }
}

extension Set: EmptyValueRepresentable {
    // MARK: - Public Properties
    public static var emptyValue: Set<Element> {
        Set()
    }
}

extension String: EmptyValueRepresentable {
    // MARK: - Public Properties
    public static var emptyValue: String {
        ""
    }
}
