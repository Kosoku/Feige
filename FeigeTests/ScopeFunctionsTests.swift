//
//  ScopeFunctionsTests.swift
//  FeigeTests
//
//  Created by William Towe on 9/23/23.
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

final class AlsoClass: ScopeFunctions {
    var flag = false
}

class ScopeFunctionsTests: XCTestCase {
    func testLet() throws {
        let retval = "".let {
            $0.count
        }
        XCTAssert(retval == 0)
    }
    
    func testTakeIf() throws {
        let retval = "".takeIf {
            $0.isEmpty
        }
        XCTAssertNotNil(retval)
        
        let optionalRetval = "".takeIf {
            !$0.isEmpty
        }
        
        XCTAssertNil(optionalRetval)
    }
    
    func testTakeUnless() throws {
        let optionalRetval = "".takeUnless {
            $0.isEmpty
        }
        XCTAssertNil(optionalRetval)
        
        let retval = "".takeUnless {
            !$0.isEmpty
        }
        XCTAssertNotNil(retval)
    }
    
    func testAlsoStruct() throws {
        let retval = CGSize.zero.also {
            $0.width = 1.0
            $0.height = 1.0
        }
        XCTAssert(retval != CGSize.zero)
    }
    
    func testAlsoClass() throws {
        let retval = AlsoClass().also {
            $0.flag = true
        }
        XCTAssertTrue(retval.flag)
    }
}
