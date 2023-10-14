//
//  BundleExtensionsTests.swift
//  FeigeTests
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

import XCTest
@testable import Feige

final class BundleExtensionsTests: XCTestCase {
    func testCurrentBundle() throws {
        XCTAssertEqual(Bundle.current?.identifier, Bundle(for: type(of: self)).bundleIdentifier)
    }
    
    func testBundleIdentifier() throws {
        XCTAssertNotNil(Bundle(for: type(of: self)).identifier)
    }
    
    func testBundleDisplayName() throws {
        XCTAssertNil(Bundle(for: type(of: self)).displayName)
    }
    
    func testBundleExecutable() throws {
        XCTAssertNotNil(Bundle(for: type(of: self)).executable)
    }
    
    func testBundleShortVersionString() throws {
        XCTAssertNotNil(Bundle(for: type(of: self)).shortVersionString)
    }
    
    func testBundleVersion() throws {
        XCTAssertNotNil(Bundle(for: type(of: self)).version)
    }
    
    func testValueForInfoDictKey() throws {
        XCTAssertNotNil(Bundle.current?.valueForInfoDictionaryKey(.identifier))
    }
}
