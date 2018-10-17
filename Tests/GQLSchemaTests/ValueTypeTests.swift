//
//  ValueTypeTests.swift
//  Gryphin
//
//  Created by Dima Bart on 2017-01-16.
//  Copyright © 2017 Dima Bart. All rights reserved.
//

import XCTest
@testable import GQLSchema

class ValueTypeTests: XCTestCase {

    // ----------------------------------
    //  MARK: - Primitives -
    //
    func testString() {
        let value = "someValue"
        XCTAssertEqual(value._graphQLFormat, "\"someValue\"")
    }
    
    func testInt() {
        let value = 13
        XCTAssertEqual(value._graphQLFormat, "13")
    }
    
    func testFloat() {
        let value: Float = 13.0
        XCTAssertEqual(value._graphQLFormat, "13.0")
    }
    
    func testDouble() {
        let value: Double = 13.0
        XCTAssertEqual(value._graphQLFormat, "13.0")
    }
    
    func testBool() {
        let value = true
        XCTAssertEqual(value._graphQLFormat, "true")
        
        let anotherValue = false
        XCTAssertEqual(anotherValue._graphQLFormat, "false")
    }
    
    func testRawStringEnum() {
        
        enum Dog: String {
            case husky
            case rottweiler = "rotty"
            case dachshund
        }
        
        XCTAssertEqual(Dog.husky._stringRepresentation, "husky")
        XCTAssertEqual(Dog.rottweiler._stringRepresentation, "rotty")
    }
    
    // ----------------------------------
    //  MARK: - Equality -
    //
    func testEquality() {
        
        let value1 = TestValue(name: "value")
        let value2 = TestValue(name: "value")
        
        XCTAssertFalse(value1 === value2)
        XCTAssertTrue(value1 == value2)
        XCTAssertTrue(value1._graphQLFormat == value2._graphQLFormat)
        XCTAssertTrue(value1.hashValue == value2.hashValue)
    }
    
    static var allTests = [
        ("testString", testString),
        ("testInt", testInt),
        ("testFloat", testFloat),
        ("testDouble", testDouble),
        ("testBool", testBool),
        ("testRawStringEnum", testRawStringEnum),
        ("testEquality", testEquality),
    ]
}

// ----------------------------------
//  MARK: - TestValue -
//
class TestValue: GraphQLValueType {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var _graphQLFormat: String {
        return self.name._graphQLFormat
    }
}
