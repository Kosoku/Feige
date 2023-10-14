//
//  WeakReference.swift
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
 Allows weakly reference another object.
 
 ```
 final class MyClass {
    // MARK: - Private Properties
    private let weakReference: WeakReference<MyOtherClass>
 
    // MARK: Public Functions
    func foo() {
        guard let reference = self.weakReference.value else {
            return
        }
        // do something with reference which is non-nil
    }
 
    // MARK: Initializers
    init(myOtherClass: MyOtherClass) {
        self.weakReference = WeakReference(myOtherClass)
    }
 }
 ```
 */
public final class WeakReference<T>: NSObject {
    // MARK: - Public Properties
    /**
     Returns the weakly referenced value.
     */
    public var value: T? {
        self._value as? T
    }
    
    // MARK: - Override Properties :nodoc:
    @_documentation(visibility: internal)
    public override var hash: Int {
        self.memoryAddress
    }
    
    // MARK: - Private Properties
    private let memoryAddress: Int
    private weak var _value: AnyObject?
    
    // MARK: - Override Functions :nodoc:
    @_documentation(visibility: internal)
    public override func isEqual(_ object: Any?) -> Bool {
        guard let reference = object as? WeakReference else {
            return false
        }
        return self.memoryAddress == reference.memoryAddress
    }
    
    // MARK: - Initializers
    /**
     Creates an instance that weakly references the provided `value`.
     
     - Parameter value: The object to weakly reference
     - Returns: The instance
     */
    public init(_ value: T) {
        self.memoryAddress = unsafeBitCast(value as AnyObject, to: Int.self)
        self._value = value as AnyObject
        
        super.init()
    }
}
