//
//  CGRect+Extensions.swift
//  Feige
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

import CoreGraphics
import Foundation

public extension CGRect {
    // MARK: - Public Functions
    /**
     Returns a new rect that is the result of centering the receiver in `rect`.
     
     - Parameter rect: The rect to center the receiver in
     - Returns: The centered rect
     */
    func center(inRect rect: CGRect) -> CGRect {
        CGRect(x: floor(rect.minX + (rect.width * 0.5) - (self.width * 0.5)), y: floor(rect.minY + (rect.height * 0.5) - (self.height * 0.5)), width: self.width, height: self.height)
    }
    
    /**
     Returns a new rect that is the result of centering the receiver horizontally in `rect`.
     
     - Parameter rect: The rect to horizontally center the receiver in
     - Returns: The horizontally centered rect
     */
    func centerHorizontally(inRect rect: CGRect) -> CGRect {
        self.center(inRect: rect)
            .also {
                $0.origin.y = self.origin.y
            }
    }
    
    /**
     Returns a new rect that is the result of centering the receiver vertically in `rect`.
     
     - Parameter rect: The rect to vertically center the receiver in
     - Returns: The vertically centered rect
     */
    func centerVertically(inRect rect: CGRect) -> CGRect {
        self.center(inRect: rect)
            .also {
                $0.origin.x = self.origin.x
            }
    }
}
