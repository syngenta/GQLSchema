//
//  ParameterTests.swift
//  Gryphin
//
//  Created by Dima Bart on 2017-01-29.
//  Copyright © 2017 Dima Bart. All rights reserved.
//

import XCTest
@testable import GQLSchema

class ParameterTests: XCTestCase {
    
    private enum TestEnum: String {
        case one   = "1one"
        case two   = "2two"
        case three = "3three"
    }
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testValueTypeInit() {
        self.assert(parameter: GraphQLParameter(name: "string", value: "value"),
                    equals:    "string: \"value\"")
    }
    
    func testValueTypeCollectionInit() {
        self.assert(parameter: GraphQLParameter(name: "numbers", value: [123, 234]),
                    equals:    "numbers: [123, 234]")
    }
    
    func testScalarTypeInit() {
        self.assert(parameter: GraphQLParameter(name: "id", value: TestID(from: "123")),
                    equals:    "id: \"123\"")
    }
    
    func testScalarTypeCollectionInit() {
        let values = [
            TestID(from: "123"),
            TestID(from: "234"),
        ]
        self.assert(parameter: GraphQLParameter(name: "ids", value: values),
                    equals:    "ids: [\"123\", \"234\"]")
    }
    
    func testEnumInit() {
        self.assert(parameter: GraphQLParameter(name: "enum", value: TestEnum.two),
                    equals:    "enum: 2two")
    }
    
    func testEnumCollectionInit() {
        self.assert(parameter: GraphQLParameter(name: "enums", value: [TestEnum.two, TestEnum.three]),
                    equals:    "enums: [2two, 3three]")
    }

    func testGraphQLValueParameters() {
        let values = [
            TestID(from: "123"),
            TestID(from: "234"),
        ]
        self.assert(
            parameter: GraphQLParameter(name: "ids", value: GraphQLValue.value(values)),
            equals: "ids: [\"123\", \"234\"]"
        )

        self.assert(
            parameter: GraphQLParameter(name: "ids", value: GraphQLValue<[TestID]>.variable("ids")),
            equals: "ids: $ids"
        )
    }
    
    private func assert(parameter: GraphQLParameter, equals value: String) {
        let string = parameter._graphQLFormat
        XCTAssertEqual(string, value)
    }
    
    // ----------------------------------
    //  MARK: - Equality -
    //
    func testEquality() {
        let param1 = GraphQLParameter(name: "number", value: 123)
        let param2 = GraphQLParameter(name: "number", value: 123)
        
        XCTAssertEqual(param1, param2)
        
        let param3 = GraphQLParameter(name: "number", value: "123")
        
        XCTAssertNotEqual(param2, param3)
    }
    
    static var allTests = [
        ("testValueTypeInit", testValueTypeInit),
        ("testValueTypeCollectionInit", testValueTypeCollectionInit),
        ("testScalarTypeInit", testScalarTypeInit),
        ("testScalarTypeCollectionInit", testScalarTypeCollectionInit),
        ("testEnumInit", testEnumInit),
        ("testEnumCollectionInit", testEnumCollectionInit),
        ("testGraphQLValueParameters", testGraphQLValueParameters),
        ("testEquality", testEquality),
    ]
}

// ----------------------------------
//  MARK: - Test Scalar -
//
private struct TestID: GraphQLScalarType {
    
    let string: String
    
    init(from string: String) {
        self.string = string
    }
}
