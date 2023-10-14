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

public extension Bundle {
    // MARK: - Constants
    static let kBundleIdentifierKey = "CFBundleIdentifier"
    static let kBundleDisplayNameKey = "CFBundleDisplayName"
    static let kBundleExecutableKey = "CFBundleExecutable"
    static let kBundleShortVersionStringKey = "CFBundleShortVersionString"
    static let kBundleVersionKey = "CFBundleVersion"
    
    private static let _cache = NSCache<NSNumber, Bundle>()
    
    // MARK: - Public Properties
    /**
     Returns the current bundle based on the calling context. For example, if you call this property within a framework, it will return the framework bundle. If you call this property in the main app, it will return the main bundle.
     */
    class var currentBundle: Bundle? {
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
     Returns the bundle identifier. For example, "com.mycompany.app".
     
     @return The bundle identifier
     */
    var bundleIdentifier: String? {
        return self.bundleValueForKey(Bundle.kBundleIdentifierKey)
    }
    /**
     Returns the bundle display name. For example, "App". This value is localized.
     
     @return The bundle display name
     */
    var bundleDisplayName: String? {
        return self.bundleValueForKey(Bundle.kBundleDisplayNameKey)
    }
    /**
     Returns the bundle executable. For example, "App". This value is not localized.
     
     @return The bundle executable
     */
    var bundleExecutable: String? {
        return self.bundleValueForKey(Bundle.kBundleExecutableKey)
    }
    /**
     Returns the bundle short version string. For example, "1.0.0".
     
     @return The bundle short version string
     */
    var bundleShortVersion: String? {
        return self.bundleValueForKey(Bundle.kBundleShortVersionStringKey)
    }
    /**
     Returns the bundle version. For example, "1".
     
     @return The bundle version
     */
    var bundleVersion: String? {
        return self.bundleValueForKey(Bundle.kBundleVersionKey)
    }
    // MARK: - Private Functions
    private func bundleValueForKey(_ key: String) -> String? {
        return self.infoDictionary?.let({
            $0[key] as? String
        })
    }
}

internal extension Bundle {
    // MARK: - Internal Functions
    var frameworkBundle: Bundle? {
        return .init(identifier: "com.kosoku.Feige") ?? Bundle.main.privateFrameworksURL?.appendingPathComponent("Feige.framework", isDirectory: true).appendingPathComponent("Feige.bundle", isDirectory: true).let({
            Bundle.init(url: $0)
        }) ?? Bundle.main.url(forResource: "Feige", withExtension: "bundle")?.let({
            Bundle.init(url: $0)
        })
    }
}
