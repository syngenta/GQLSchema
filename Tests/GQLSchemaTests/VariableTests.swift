//
//  VariableTests.swift
//  GQLSchemaTests
//
//  Created by Evegeny Kalashnikov on 15.09.2022.
//

import XCTest
@testable import GQLSchema

final class VariableTests: XCTestCase {

    struct TestScalar: GraphQLScalarType {
        var string: String

        init(from string: String) {
            fatalError("Not need for test")
        }

        init(date: Date) {
            self.string = "\(date)"
        }
    }

    struct TestScalarCustom: GraphQLScalarType {
        var string: String

        var _graphQLFormat: String { self.string }

        init(from string: String) {
            fatalError("Not need for test")
        }

        init() {
            self.string = "{ \"key\": \"value\" }"
        }
    }

    func testVariableInt() {
        let variable = GraphQLVariable(type: "Int", name: "name", value: 10)
        XCTAssertEqual(variable.declaration, "$name: Int")
        XCTAssertEqual(variable.bodyValue, "\"name\": 10")
    }

    func testVariableArrayInt() {
        let variable = GraphQLVariable(type: "Int", name: "name", value: [10, 20, 30, 40])
        XCTAssertEqual(variable.declaration, "$name: Int")
        XCTAssertEqual(variable.bodyValue, "\"name\": [10, 20, 30, 40]")
    }

    func testVariableArrayString() {
        let variable = GraphQLVariable(type: "Int", name: "name", value: ["10", "20", "30", "40"])
        XCTAssertEqual(variable.declaration, "$name: Int")
        XCTAssertEqual(variable.bodyValue, "\"name\": [\"10\", \"20\", \"30\", \"40\"]")
    }

    func testVariableScalar() {
        let date = Date()
        let variable = GraphQLVariable(type: "TestScalar", name: "date", value: TestScalar(date: date))
        XCTAssertEqual(variable.declaration, "$date: TestScalar")
        XCTAssertEqual(variable.bodyValue, "\"date\": \"\(date)\"")
    }

    func testVariableArrayScalar() {
        let date = Date()
        let value = [TestScalar(date: date), TestScalar(date: date)]
        let variable = GraphQLVariable(type: "[TestScalar]", name: "dates", value: value)
        XCTAssertEqual(variable.declaration, "$dates: [TestScalar]")
        XCTAssertEqual(variable.bodyValue, "\"dates\": [\"\(date)\", \"\(date)\"]")
    }

    func testVariableScalarCustom() {
        let variable = GraphQLVariable(type: "TestScalarCustom", name: "value", value: TestScalarCustom())
        XCTAssertEqual(variable.declaration, "$value: TestScalarCustom")
        XCTAssertEqual(variable.bodyValue, "\"value\": { \"key\": \"value\" }")
    }

    static var allTests = [
        ("testVariableInt", testVariableInt),
        ("testVariableArrayInt", testVariableArrayInt),
        ("testVariableArrayString", testVariableArrayString),
        ("testVariableScalar", testVariableScalar),
        ("testVariableArrayScalar", testVariableArrayScalar),
        ("testVariableScalarCustom", testVariableScalarCustom)
    ]
}
