//
//  OSLog+Extensions.swift
//  Feige
//
//  Created by Jason Anderson on 10/14/23.
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
import os.log

/**
 Commonly used OSLog instances for use with `os_log` functions
 
 ```
 os_log(.debug, log: .analytics, "%@ %@", #function, String(describing: self))
 ```
 */
public extension OSLog {
    /**
     Use to log analytics related info.
     */
    static let analytics = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "analytics")
    /**
     Use to log within `extension` statements.
     */
    static let `extension` = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "extension")
    /**
     Use to log network request/response related info.
     */
    static let network = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "network")
    /**
     Use to log model related info (e.g. `CoreData`).
     */
    static let model = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "model")
    /**
     Use to log within view classes (e.g. `NSView`, `UIView`).
     */
    static let view = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "view")
    /**
     Use to log within view model classes.
     */
    static let viewModel = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "viewModel")
    /**
     Use to log within view controller classes (e.g. `NSViewController`, `UIViewController`).
     */
    static let viewController = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "viewController")
}
