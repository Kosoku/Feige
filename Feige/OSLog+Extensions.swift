//
//  OSLog+Extensions.swift
//  Feige
//
//  Created by Jason Anderson on 10/14/23.
//  Copyright © 2023 Kosoku Interactive, LLC. All rights reserved.
//

import os.log

/**
 A set of commonly used OSLog instances for use with `os_log` functions
 
 ```
 os_log(.debug, log: .analytics, "%@ %@", #function, String(describing: self))
 ```
 */
public extension OSLog {
    static let analytics = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "analytics")
    static let network = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "network")
    static let model = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "model")
    static let view = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "view")
    static let viewModel = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "viewModel")
    static let viewController = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "unidentified bundle", category: "viewController")
}
