//
//  IndirectReference.swift
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
 Allows recursively referencing a struct within itself.
 
 ```
 struct Node {
    // MARK: - Public Properties
    let id: Int
 
    var left: Node {
        self._left.value
    }
    var right: Node {
        self._right.value
    }
 
    // MARK: - Private Properties
    private let _left: IndirectReference<Node>
    private let _right: IndirectReference<Node>
 }
 ```
 */
public struct IndirectReference<T: Hashable>: Hashable {
    // MARK: - Private Types
    private final class Wrapper {
        // MARK: - Public Properties
        var value: T
        
        // MARK: - Initializers
        init(_ value: T) {
            self.value = value
        }
    }
    
    // MARK: - Public Properties
    /**
     Set/get the referenced value.
     */
    public var value: T {
        get {
            self.wrapper.value
        }
        set {
            if isKnownUniquelyReferenced(&self.wrapper) {
                self.wrapper.value = newValue
            }
            else {
                self.wrapper = Wrapper(newValue)
            }
        }
    }
    
    // MARK: - Equatable
    public static func == (lhs: IndirectReference<T>, rhs: IndirectReference<T>) -> Bool {
        lhs.value == rhs.value
    }
    
    // MARK: - Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
    }
    
    // MARK: - Private Properties
    private var wrapper: Wrapper
    
    // MARK: - Initializers
    /**
     Creates an instance referencing the provided `value`.
     
     - Parameter value: The value to reference
     - Returns: The instance
     */
    public init(_ value: T) {
        self.wrapper = Wrapper(value)
    }
}
