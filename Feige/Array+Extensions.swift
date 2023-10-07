//
//  Array+Extensions.swift
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

public extension Array {
    // MARK: - Public Functions
    /**
     Returns a subarray starting at `index`, extending backwards at most `length`elements and forwards at most `length` elements for a subarray of **at most** `(length * 2) + 1` elements.
     
     ```
     let tmp = [1, 2, 3, 4, 5]
     let retval = tmp.subarrayWithMiddleIndex(1, length: 2)
     
     // do something with retval which is [1, 2, 3, 4]
     ```
     
     - Parameter index: The middle anchor index
     - Parameter length: The number of elements to extend past `index` in either direction
     - Returns: The subarray
     */
    func subarrayWithMiddleIndex(_ index: Int, length: Int) -> [Element] {
        guard index < self.count else {
            return []
        }
        return Array(self[Swift.max(0, index - length)...Swift.min(self.count - 1, index + length)])
    }
}

public extension Array where Element: Equatable {
    /**
     Calls through to `Array.subarrayWithMiddleIndex(_:length:)` after determining the index of `value`.
     
     ```
     let tmp = ["one", "two", "three", "four", "five"]
     let retval = tmp.subarrayWithMiddleElement("two", length: 2)
     
     // do something with retval which is ["one", "two", "three", "four"]
     ```
     
     - Parameter value: The middle anchor element
     - Parameter length: The number of elements to extend past the index of `value` in either direction
     - Returns: The subarray
     */
    func subarrayWithMiddleElement(_ value: Element, length: Int) -> [Element] {
        guard let index = self.firstIndex(of: value) else {
            return []
        }
        return self.subarrayWithMiddleIndex(index, length: length)
    }
}
