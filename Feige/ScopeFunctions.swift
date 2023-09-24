//
//  ScopeFunctions.swift
//  Feige
//
//  Created by William Towe on 9/23/23.
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

// MARK: - Public Functions
/**
 Invokes the provided `block` and returns the result.
 
 ```
 let retval = run {
    // do stuff and return a value
 }
 ```
 
 - Parameter block: The block to invoke
 - Returns: The result of invoking `block`
 - SeeAlso: https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/run.html
 */
@inlinable
@inline(__always)
public func run<T>(_ block: () -> T) -> T {
    block()
}

/**
 Conformance to this protocol provides implementation of **some** of the _Kotlin Scope Functions_. To add conformance to your own types, see examples below.
 
 ```
 class MyClass: ScopeFunctions {}
 
 struct MyStruct: ScopeFunctions {}
 ```
 
 - SeeAlso: https://kotlinlang.org/docs/scope-functions.html
 */
public protocol ScopeFunctions {}

public extension ScopeFunctions {
    // MARK: - Public Functions
    /**
     Invokes the provided `block` and returns, providing the receiver as the only argument.
     
     ```
     struct MyStruct: ScopeFunctions {}
     
     let retval = MyStruct().let {
        // do stuff with $0 and return a different value
        "my string value"
     }
     
     // do something with retval which is a String
     ```
     
     - Parameter block: The block to invoke
     - Returns: The result of invoking `block`
     - SeeAlso: https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/let.html
     */
    @inlinable
    @inline(__always)
    func `let`<T>(_ block: (Self) -> T) -> T {
        block(self)
    }
    
    /**
     Invokes the provided `predicate`, if it returns `true`, returns the receiver, otherwise returns nil.
     
     ```
     struct MyStruct: ScopeFunctions {}
     
     let retval = MyStruct().takeIf {
        // test $0 to determine return value
     }
     
     // do something with retval which is an optional MyStruct
     ```
     
     - Parameter predicate: The predicate to invoke
     - Returns: The receiver or nil
     - SeeAlso: https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/take-if.html
     */
    @inlinable
    @inline(__always)
    func takeIf(_ predicate: (Self) -> Bool) -> Self? {
        predicate(self) ? self : nil
    }
    
    /**
     Invokes the provided `predicate`, if it returns `true`, returns nil, otherwise returns the receiver.
     
     ```
     struct MyStruct: ScopeFunctions {}
     
     let retval = MyStruct().takeUnless {
        // test $0 to determine return value
     }
     
     // do something with retval which is an optional MyStruct
     ```
     
     - Parameter predicate: The predicate to invoke
     - Returns: The receiver or nil
     - SeeAlso: https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/take-unless.html
     */
    @inlinable
    @inline(__always)
    func takeUnless(_ predicate: (Self) -> Bool) -> Self? {
        predicate(self) ? nil : self
    }
}

/**
 Provides an implementation of the `also(_:)` scope function on value types.
 */
public extension ScopeFunctions where Self: Any {
    // MARK: - Public Functions
    /**
     Invokes the provided `block`, providing the receiver as the only argument and returns the receiver.
     
     ```
     struct MyStruct: ScopeFunctions {}
     
     let retval = MyStruct().also {
        // configure $0
     }
     
     // do something with the configured retval which is of type MyStruct
     ```
     
     - Parameter block: The block to invoke
     - Returns: The receiver
     - SeeAlso: https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/also.html
     */
    @discardableResult
    @inlinable
    @inline(__always)
    func also(_ block: (inout Self) -> Void) -> Self {
        var retval = self
        
        block(&retval)
        
        return retval
    }
}

/**
 Provides an implementation of the `also(_:)` scope function on reference types.
 */
public extension ScopeFunctions where Self: AnyObject {
    // MARK: - Public Functions
    /**
     Invokes the provided `block`, providing the receiver as the only argument and returns the receiver.
     
     ```
     struct MyClass: ScopeFunctions {}
     
     let retval = MyClass().also {
        // configure $0
     }
     
     // do something with the configured retval which is a MyClass
     ```
     
     - Parameter block: The block to invoke
     - Returns: The receiver
     - SeeAlso: https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/also.html
     */
    @discardableResult
    @inlinable
    @inline(__always)
    func also(_ block: (Self) -> Void) -> Self {
        block(self)
        
        return self
    }
}

// Swift types
extension Bool: ScopeFunctions {}

extension Int: ScopeFunctions {}

extension Float: ScopeFunctions {}

extension Double: ScopeFunctions {}

extension String: ScopeFunctions {}

extension Array: ScopeFunctions {}

extension Set: ScopeFunctions {}

extension Dictionary: ScopeFunctions {}

// Foundation types
extension NSObject: ScopeFunctions {}

extension CGAffineTransform: ScopeFunctions {}

extension CGFloat: ScopeFunctions {}

extension CGPoint: ScopeFunctions {}

extension CGRect: ScopeFunctions {}

extension CGSize: ScopeFunctions {}

extension CGVector: ScopeFunctions {}
