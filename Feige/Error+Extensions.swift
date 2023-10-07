//
//  Error+Extensions.swift
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

public extension Error where Self: CustomNSError {
    // MARK: - Public Properties
    /**
     Returns the underlying error.
     */
    var underlyingError: Error? {
        self.errorUserInfo[NSUnderlyingErrorKey] as? Error
    }
}

public extension Error where Self: CustomNSError, Self: LocalizedError {
    // MARK: - Public Properties
    /**
     Returns the localized error user info dictionary, which will include the `LocalizedError.errorDescription` and `LocalizedError.failureReason` if non-nil.
     */
    var localizedErrorUserInfo: [String: Any] {
        self.errorUserInfo.also {
            if let errorDescription = self.errorDescription {
                $0[NSLocalizedDescriptionKey] = errorDescription
            }
            if let failureReason = self.failureReason {
                $0[NSLocalizedFailureErrorKey] = failureReason
            }
        }
    }
}
