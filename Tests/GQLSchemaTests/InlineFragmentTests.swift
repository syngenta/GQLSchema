//
//  InlineFragmentTests.swift
//  Gryphin
//
//  Created by Dima Bart on 2017-01-29.
//  Copyright © 2017 Dima Bart. All rights reserved.
//

import XCTest
@testable import GQLSchema

class InlineFragmentTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Setup -
    //
    override func setUp() {
        super.setUp()
        
        precondition(Environment.prettyPrint, "Inline fragment tests require the \"com.lumyk.GQLSchema.prettyPrint\" environment variable to be set.")
    }
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let fragment = GraphQLInlineFragment(type: "User")
        
        XCTAssertNotNil(fragment)
        XCTAssertEqual(fragment._name,          "")
        XCTAssertEqual(fragment._typeCondition, "User")
        XCTAssertEqual(fragment._parameters,    [])
    }
    
    // TODO: Test child -> parent relationship between children
    
    // ----------------------------------
    //  MARK: - StringRepresentable -
    //
    func testStringRepresentable() {
        
        let fragment = GraphQLInlineFragment(type: "User", children: [
            GraphQLField(name: "subfield1"),
            GraphQLField(name: "subfield2"),
        ])
        
        try! fragment._add(child: GraphQLField(name: "subfield3"))
        
        XCTAssertEqual(fragment._graphQLFormat, "" ~
            "... on User {" ~
            "    subfield1" ~
            "    subfield2" ~
            "    subfield3" ~
            "}" ~
            ""
        )
    }
    
    static var allTests = [
        ("testInit", testInit),
        ("testStringRepresentable", testStringRepresentable),
    ]
}
