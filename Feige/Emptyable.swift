//
//  Emptyable.swift
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
 Describes an object that be empty.
 
 ```
 let str = ""
 let retval = str.isEmpty
 
 // so something with str which is true
 ```
 */
public protocol Emptyable {
    // MARK: - Public Properties
    /**
     Returns whether the receiver is empty.
     */
    var isEmpty: Bool { get }
}

public extension Emptyable {
    // MARK: - Public Properties
    /**
     Returns whether the receiver is **NOT** empty.
     */
    var isNotEmpty: Bool {
        self.isEmpty.not()
    }
    
    /**
     Returns `nil` if the receiver is empty, otherwise returns the receiver.
     */
    var nilIfEmpty: Self? {
        self.isEmpty ? nil : self
    }
}

public extension Optional where Wrapped: Emptyable {
    // MARK: - Public Properties
    /**
     Returns whether the receiver is empty or nil.
     */
    var isEmptyOrNil: Bool {
        switch self {
        case let .some(value):
            return value.isEmpty
        case .none:
            return true
        }
    }
    
    /**
     Returns whether the receiver is **NOT** empty or nil.
     */
    var isNotEmptyOrNil: Bool {
        self.isEmptyOrNil.not()
    }
}


// Swift types
extension Array: Emptyable {}

extension Dictionary: Emptyable {}

extension Set: Emptyable {}

extension String: Emptyable {}
