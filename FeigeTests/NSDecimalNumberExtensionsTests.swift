//
//  NSDecimalNumberExtensionsTests.swift
//  FeigeTests
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

import XCTest
@testable import Feige

final class NSDecimalNumberExtensionsTests: XCTest {
    func testLessThan() throws {
        XCTAssertTrue(NSDecimalNumber(value: -1) < .zero)
    }
    
    func testLessThanOrEqualTo() throws {
        XCTAssertTrue(NSDecimalNumber(value: 0) <= .zero)
    }
    
    func testGreaterThan() throws {
        XCTAssertTrue(NSDecimalNumber(value: 1) > .zero)
    }
    
    func testGreaterThanOrEqualTo() throws {
        XCTAssertTrue(NSDecimalNumber(value: 0) >= .zero)
    }
    
    func testAdd() throws {
        XCTAssertEqual(NSDecimalNumber(value: 1) + NSDecimalNumber(value: 1), NSDecimalNumber(value: 2))
    }
    
    func testAddEqual() throws {
        var retval = NSDecimalNumber.zero
        
        retval += NSDecimalNumber(value: 1)
        
        XCTAssertEqual(retval, NSDecimalNumber(value: 1))
    }
    
    func testSubtract() throws {
        XCTAssertEqual(NSDecimalNumber(value: 1) - NSDecimalNumber(value: 1), .zero)
    }
    
    func testSubtractEqual() throws {
        var retval = NSDecimalNumber.zero
        
        retval -= NSDecimalNumber(value: 1)
        
        XCTAssertEqual(retval, NSDecimalNumber(value: -1))
    }
    
    func testMultiply() throws {
        XCTAssertEqual(NSDecimalNumber(value: 2) * NSDecimalNumber(value: 2), NSDecimalNumber(value: 4))
    }
    
    func testMultiplyEqual() throws {
        var retval = NSDecimalNumber(value: 2)
        
        retval *= NSDecimalNumber(value: 2)
        
        XCTAssertEqual(retval, NSDecimalNumber(value: 4))
    }
    
    func testDivide() throws {
        XCTAssertEqual(NSDecimalNumber(value: 4) / NSDecimalNumber(value: 2), NSDecimalNumber(value: 2))
    }
    
    func testDivideEqual() throws {
        var retval = NSDecimalNumber(value: 4)
        
        retval /= NSDecimalNumber(value: 2)
        
        XCTAssertEqual(retval, NSDecimalNumber(value: 2))
    }
    
    func testMin() throws {
        XCTAssertEqual(min(NSDecimalNumber(value: 1), NSDecimalNumber(value: 2)), NSDecimalNumber(value: 1))
    }
    
    func testMax() throws {
        XCTAssertEqual(max(NSDecimalNumber(value: 1), NSDecimalNumber(value: 2)), NSDecimalNumber(value: 2))
    }
}
