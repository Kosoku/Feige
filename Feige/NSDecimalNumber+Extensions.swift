//
//  NSDecimalNumber+Extensions.swift
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

// MARK: - Public Functions
/**
 Returns the result of adding `left` to `right`.
 
 - Parameter left: The left operand
 - Parameter right: The right operand
 - Returns: The result
 */
public func + (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    left.adding(right)
}

/**
 Adds `left` to `right` and assigns the result to `left`.
 
 - Parameter left: The left operand
 - Parameter right: The right operand
 */
public func += (left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left + right
}

/**
 Returns the result of subtracting `right` from `right`.
 
 - Parameter left: The left operand
 - Parameter right: The right operand
 - Returns: The result
 */
public func - (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    left.subtracting(right)
}

/**
 Subtracts `right` from `left` and assigns the result to `left`.
 
 - Parameter left: The left operand
 - Parameter right: The right operand
 */
public func -= (left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left - right
}

/**
 Returns the result of multiplying `left` by `right`.
 
 - Parameter left: The left operand
 - Parameter right: The right operand
 - Returns: The result
 */
public func * (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    left.multiplying(by: right)
}

/**
 Multiplies `left` by `right` and assigns the result to `left`.
 
 - Parameter left: The left operand
 - Parameter right: The right operand
 */
public func *= (left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left * right
}

/**
 Returns the result of dividing `left` by `right`.
 
 - Parameter left: The left operand
 - Parameter right: The right operand
 - Returns: The result
 */
public func / (left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    left.dividing(by: right)
}

/**
 Divides `left` by `right` and assigns the result to `left`.
 
 - Parameter left: The left operand
 - Parameter right: The right operand
 */
public func /= (left: inout NSDecimalNumber, right: NSDecimalNumber) {
    left = left / right
}

/**
 Returns the minimum value of `left` and `right`.
 
 - Parameter left: The left operand
 - Parameter right: The right operand
 - Returns: `left` if `left` is less than `right`, otherwise `right`
 */
public func min(_ left: NSDecimalNumber, _ right: NSDecimalNumber) -> NSDecimalNumber {
    left < right ? left : right
}

/**
 Returns the maximum value of `left` and `right`.
 
 - Parameter left: The left operand
 - Parameter right: The right operand
 - Returns: `left` if `left` is greater than `right`, otherwise `right`
 */
public func max(_ left: NSDecimalNumber, _ right: NSDecimalNumber) -> NSDecimalNumber {
    left > right ? left : right
}

public extension NSDecimalNumber {
    // MARK: - Public Properties
    /**
     Constant for `-1`.
     */
    static let negativeOne = NSDecimalNumber(value: -1)
    
    // MARK: - Public Functions
    /**
     Returns the absolute value of  the receiver.
     
     ```
     let retval = NSDecimalNumber(value: -5).abs()
     
     // do something with retval which is 5
     ```
     */
    func abs() -> NSDecimalNumber {
        self < .zero ? self * .negativeOne : self
    }
    
    /**
     Returns the result of multiplying the absolute value of the receiver by `-1`.
     
     ```
     let retval = NSDecimalNumber(value: -5).negative()
     
     // do something with retval which is -5
     ```
     */
    func negative() -> NSDecimalNumber {
        self.abs() * .negativeOne
    }
    
    /**
     Returns the result of multiplying the receiver by `-1`.
     
     ```
     let retval = NSDecimalNumber(value: 5).inverted()
     
     // do something with retval which is -5
     ```
     */
    func inverted() -> NSDecimalNumber {
        self * .negativeOne
    }
}

extension NSDecimalNumber: Comparable {
    // MARK: - Comparable
    public static func < (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        lhs.compare(rhs) == .orderedAscending
    }
}
