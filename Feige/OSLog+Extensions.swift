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

import os.log

/**
 A set of commonly used OSLog instances for use with `os_log` functions
 
 ```
 os_log(.debug, log: .analytics, "%@ %@", #function, String(describing: self))
 ```
 */
public extension OSLog {
    static let analytics = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "analytics")
    static let `extension` = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "extension")
    static let network = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "network")
    static let model = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "model")
    static let view = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "view")
    static let viewModel = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "viewModel")
    static let viewController = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "viewController")
}
