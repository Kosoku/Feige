//
//  Bundle+Extensions.swift
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

internal extension Bundle {
    // MARK: - Internal Functions
    var frameworkBundle: Bundle? {
        .init(identifier: "com.kosoku.Feige") ?? Bundle.main.privateFrameworksURL?.appendingPathComponent("Feige.framework", isDirectory: true).appendingPathComponent("Feige.bundle", isDirectory: true).let({
            Bundle.init(url: $0)
        }) ?? Bundle.main.url(forResource: "Feige", withExtension: "bundle")?.let({
            Bundle.init(url: $0)
        })
    }
}

public extension Bundle {
    // MARK: - Public Types
    struct Key: RawRepresentable {
        // MARK: - Public Properties
        static let identifier = Key("CFBundleIdentifier")
        static let displayName = Key("CFBundleDisplayName")
        static let executable = Key("CFBundleExecutable")
        static let shortVersionString = Key("CFBundleShortVersionString")
        static let version = Key("CFBundleVersion")
        
        public let rawValue: String
        
        // MARK: - Initializers
        public init(_ rawValue: String) {
            self.rawValue = rawValue
        }
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    // MARK: - Public Properties
    /**
     Returns the current bundle based on the calling context. For example, if you call this property within a framework, it will return the framework bundle. If you call this property in the main app, it will return the main bundle.
     */
    static var current: Bundle? {
        let caller = Thread.callStackReturnAddresses[1]
        
        if let bundle = _cache.object(forKey: caller) {
            return bundle
        }
        
        let fname = ("" as NSString).utf8String
        let sname = ("" as NSString).utf8String
        var info = Dl_info(dli_fname: UnsafeMutablePointer(mutating: fname), dli_fbase: nil, dli_sname: UnsafeMutablePointer(mutating: sname), dli_saddr: nil)
        dladdr(caller.pointerValue, &info)
        let bundlePath = String(cString: info.dli_fname)

        for bundle in Bundle.allBundles + Bundle.allFrameworks {
            if let path = bundle.executableURL?.resolvingSymlinksInPath().path,
                bundlePath == path {
                _cache.setObject(bundle, forKey: caller)
                return bundle
            }
        }
        
        return nil
    }
    
    /**
     Returns the bundle identifier. For example, *com.mycompany.app*.
     */
    var identifier: String? {
        self.valueForInfoDictionaryKey(.identifier) as? String
    }
    /**
     Returns the bundle display name. For example, *App*. This value is localized.
     */
    var displayName: String? {
        self.valueForInfoDictionaryKey(.displayName) as? String
    }
    /**
     Returns the bundle executable. For example, *App*. This value is not localized.
     */
    var executable: String? {
        self.valueForInfoDictionaryKey(.executable) as? String
    }
    /**
     Returns the bundle short version string. For example, *1.0.0*.
     */
    var shortVersionString: String? {
        self.valueForInfoDictionaryKey(.shortVersionString) as? String
    }
    /**
     Returns the bundle version. For example, *1*.
     */
    var version: String? {
        self.valueForInfoDictionaryKey(.version) as? String
    }
    
    // MARK: - Private Properties
    private static let _cache = NSCache<NSNumber, Bundle>()
    
    // MARK: - Public Functions
    /**
     Returns the bundle value for the provided `key`.
     
     - Parameter key: The bundle key
     - Returns: The bundle value
     */
    func valueForInfoDictionaryKey(_ key: Key) -> Any? {
        self.object(forInfoDictionaryKey: key.rawValue)
    }
}
