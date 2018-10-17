import XCTest

import GQLSchemaTests

var tests = [XCTestCaseEntry]()
tests += GQLSchemaTests.allTests()
XCTMain(tests)