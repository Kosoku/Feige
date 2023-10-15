//
//  ReadWriteLock.swift
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
 Many readers, single writer generic lock.
 
 ```
 let myClass = ...
 let lock = ReadWriteLock(myClass)
 
 lock.mutate {
    // do stuff with $0 to update myClass
 }
 ```
 */
public final class ReadWriteLock<T> {
    // MARK: - Public Properties
    /**
     Returns the current value.
     */
    public var value: T {
        var retval: T!
        
        self.queue.sync {
            retval = self._value
        }
        
        return retval
    }
    
    // MARK: - Private Properties
    private let label: String
    private let queue: DispatchQueue
    private var _value: T
    
    // MARK: - Public Functions
    /**
     Mutates the current value within the provided `block`.
     
     - Parameter block: The mutating block
     */
    public func mutate(_ block: @escaping (inout T) -> Void) {
        self.queue.async(flags: .barrier) {
            block(&self._value)
        }
    }
    
    // MARK: - Initializers
    /**
     Creates an instance with the provided parameters.
     
     - Parameter value: The value to wrap
     - Parameter label: The label for the underlying queue
     - Parameter queue: The underlying queue
     - Returns: The instance
     */
    public init(_ value: T, label: String? = nil, qualityOfService: DispatchQoS = .utility) {
        let label = label ?? String(describing: T.self)
        
        self.label = label
        self.queue = DispatchQueue(label: "\(String.bundleIdentifier).\(ReadWriteLock.self).\(label)", qos: qualityOfService, attributes: .concurrent, target: .global(qos: qualityOfService.qosClass))
        self._value = value
    }
}
