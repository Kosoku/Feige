//
//  FileManager+Extensions.swift
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

import Foundation

public extension FileManager {
    // MARK: - Public Properties
    /**
     Returns the document directory URL.
     */
    var documentDirectoryURL: URL? {
        self.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    // MARK: - Public Functions
    /**
     Returns the application support directory URL, attempting to create it if it does **NOT** exist.
     
     - Returns: The application support directory URL
     - Throws: If checking the URL is reachable fails **OR** if creation of the directory fails
     */
    func applicationSupportDirectoryURL() throws -> URL? {
        guard var retval = self.urls(for: .applicationSupportDirectory, in: .userDomainMask).first, let executable = Bundle.main.executable else {
            return nil
        }
        #if os(macOS)
        retval = retval.appendingPathComponent(executable, isDirectory: true)
        #endif
        
        if try retval.checkResourceIsReachable().not() {
            try self.createDirectory(at: retval, withIntermediateDirectories: true)
        }
        return retval
    }
    
    /**
     Returns the caches directory URL, attempting to create it if it does **NOT** exist.
     
     - Returns: The caches directory URL
     - Throws: If checking the URL is reachable fails **OR** if creation of the directory fails
     */
    func cachesDirectoryURL() throws -> URL? {
        guard var retval = self.urls(for: .cachesDirectory, in: .userDomainMask).first, let identifier = Bundle.main.identifier else {
            return nil
        }
        #if os(macOS)
        retval = retval.appendingPathComponent(identifier, isDirectory: true)
        
        if try retval.checkResourceIsReachable().not() {
            try self.createDirectory(at: retval, withIntermediateDirectories: true)
        }
        #endif
        
        return retval
    }
}
