//
//  TypedFieldTests.swift
//  Gryphin
//
//  Created by Dima Bart on 2017-01-29.
//  Copyright © 2017 Dima Bart. All rights reserved.
//

import XCTest
@testable import GQLSchema

class TypedFieldTests: XCTestCase {

    // ----------------------------------
    //  MARK: - Init -
    //
    func testAppendedTypenameWithoutChildren() {
        let node = GraphQLField(name: "query")
        
        try! node._add(child: GraphQLTypedField(name: "subfield"))
        
        let typedField = node._children[0] as! GraphQLField
        
        XCTAssertEqual(typedField._children.count, 1)
        XCTAssertEqual(typedField._children[0]._name, GraphQL.Key.typeName)
    }
    
    func testAppendedTypenameWithChildren() {
        let node = GraphQLField(name: "query")
        
        try! node._add(child: GraphQLTypedField(name: "subfield", children: [
            GraphQLField(name: "subfield1"),
            GraphQLField(name: "subfield2"),
        ]))
        
        let typedField = node._children[0] as! GraphQLField
        
        XCTAssertEqual(typedField._children.count, 3)
        XCTAssertEqual(typedField._children[0]._name, GraphQL.Key.typeName)
        XCTAssertEqual(typedField._children[1]._name, "subfield1")
        XCTAssertEqual(typedField._children[2]._name, "subfield2")
    }
    
    static var allTests = [
        ("testAppendedTypenameWithoutChildren", testAppendedTypenameWithoutChildren),
        ("testAppendedTypenameWithChildren", testAppendedTypenameWithChildren),
    ]
}
