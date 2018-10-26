//
//  FieldTests.swift
//  Gryphin
//
//  Created by Dima Bart on 2016-12-09.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import XCTest
@testable import GQLSchema

class FieldTests: XCTestCase {

    // ----------------------------------
    //  MARK: - Setup -
    //
    override func setUp() {
        super.setUp()
        
        precondition(Environment.prettyPrint, "Field tests require the \"com.lumyk.GQLSchema.prettyPrint\" environment variable to be set.")
    }
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testBasicField() {
        let node = GraphQLField(name: "query")
        
        XCTAssertEqual(node._name, "query")
        XCTAssertEqual(node._alias, nil)
        XCTAssertEqual(node._parameters.count, 0)
        XCTAssertEqual(node._children.count,   0)
    }
    
    // ----------------------------------
    //  MARK: - Alias -
    //
    func testFieldWithAlias() {
        let node = GraphQLField(name: "issues", alias: "someIssue")
        
        let alias = "someIssue"
        XCTAssertEqual(node._name, "issues")
        XCTAssertEqual(node._alias, alias)
    }
    
    func testEnqueueAlias() {
        let node = GraphQLField(name: "query")
        let genericNode: GraphQLContainerType = node.alias("test")
            
        try! genericNode._add(children: [
            GraphQLField(name: "subfield"),
            GraphQLField(name: "anotherSubfield"),
        ])
        
        let firstChild  = genericNode._children[0] as! GraphQLField
        let secondChild = genericNode._children[1] as! GraphQLField
        
        XCTAssertEqual(firstChild._name, "subfield")
        XCTAssertNotNil(firstChild._alias)
        XCTAssertEqual(firstChild._alias, "test")
        
        XCTAssertEqual(secondChild._name, "anotherSubfield")
        XCTAssertNil(secondChild._alias)
    }
    
    func testEnqueueInvalidAlias() {
        let node = GraphQLField(name: "query")
        
        _ = node.alias("test")
        
        XCTAssertThrowsError(
            try node._add(children: [
                GraphQLInlineFragment(type: "subfield"),
            ])
            
        , "Adding aliases to inline fragments should throw an error.") { error in
            switch error {
            case GraphQLFieldError.InvalidSyntax(_):
                break
            default:
                XCTFail()
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - Parameters -
    //
    func testFieldWithParameters() {
        let parameter = GraphQLParameter(name: "first", value: 30)
        let node      = GraphQLField(name: "issues", parameters: [
            parameter,
        ])
        
        XCTAssertEqual(node._name, "issues")
        XCTAssertEqual(node._parameters[0], parameter)
    }
    
    // TODO: Test child -> parent relationship between children
    
    // ----------------------------------
    //  MARK: - Children -
    //
    func testFieldWithChildren() {
        let child = GraphQLField(name: "edges")
        let node  = GraphQLField(name: "issues", children: [
            child,
        ])
        
        XCTAssertEqual(node._name, "issues")
        let firstChild = node._children[0] as! GraphQLField
        XCTAssertTrue(firstChild == child)
    }
    
    func testParentWhenInitializingWithChild() {
        let child  = GraphQLField(name: "edges")
        let parent = GraphQLField(name: "issues", children: [child])
        
        XCTAssertNotNil(child._parent)
        XCTAssertTrue(parent == child._parent as! GraphQLField)
    }
    
    func testParentWhenAddingChild() {
        let child  = GraphQLField(name: "edges")
        let parent = GraphQLField(name: "issues")
        
        try! parent._add(child: child)
        
        XCTAssertNotNil(child._parent)
        XCTAssertTrue(parent == child._parent as! GraphQLField)
    }
    
    // ----------------------------------
    //  MARK: - StringRepresentable -
    //
    func testFieldsWithChildren() {
        
        let root = GraphQLField(name: "query", children: [
            GraphQLField(name: "issues", parameters: [
                GraphQLParameter(name: "first", value: 30),
            ], children: [
                GraphQLField(name: "edges", children: [
                    GraphQLField(name: "node", children: [
                        GraphQLField(name: "id"),
                        GraphQLField(name: "title"),
                    ])
                ])
            ])
        ])
        
        let query = root._graphQLFormat
        
        XCTAssertEqual(query, "" ~
            "query {" ~
            "    issues(first: 30) {" ~
            "        edges {" ~
            "            node {" ~
            "                id" ~
            "                title" ~
            "            }" ~
            "        }" ~
            "    }" ~
            "}" ~
            ""
        )
    }
    
    func testFieldsWithoutChildren() {
        
        let root = GraphQLField(name: "query", children: [
            GraphQLField(name: "issues", children: [
                GraphQLField(name: "edges", children: [
                    GraphQLField(name: "node", children: [
                        GraphQLField(name: "id"),
                        GraphQLField(name: "title"),
                        GraphQLField(name: "image", parameters: [
                            GraphQLParameter(name: "size", value: 1024),
                        ])
                    ])
                ])
            ])
        ])
        
        let query = root._graphQLFormat
        
        XCTAssertEqual(query, "" ~
            "query {" ~
            "    issues {" ~
            "        edges {" ~
            "            node {" ~
            "                id" ~
            "                title" ~
            "                image(size: 1024)" ~
            "            }" ~
            "        }" ~
            "    }" ~
            "}" ~
            ""
        )
    }
    
    func testFieldAliases() {
        
        let root = GraphQLField(name: "query", children: [
            GraphQLField(name: "issues", children: [
                GraphQLField(name: "edges", children: [
                    GraphQLField(name: "node", children: [
                        GraphQLField(name: "image", alias: "smallImage", parameters: [
                            GraphQLParameter(name: "size", value: 125),
                        ]),
                        GraphQLField(name: "image", alias: "largeImage", parameters: [
                            GraphQLParameter(name: "size", value: 1024),
                        ]),
                    ])
                ])
            ])
        ])
        
        let query = root._graphQLFormat
        XCTAssertEqual(query, "" ~
            "query {" ~
            "    issues {" ~
            "        edges {" ~
            "            node {" ~
            "                smallImage: image(size: 125)" ~
            "                largeImage: image(size: 1024)" ~
            "            }" ~
            "        }" ~
            "    }" ~
            "}" ~
            ""
        )
    }
    
    static var allTests = [
        ("testBasicField", testBasicField),
        ("testFieldWithAlias", testFieldWithAlias),
        ("testEnqueueAlias", testEnqueueAlias),
        ("testEnqueueInvalidAlias", testEnqueueInvalidAlias),
        ("testFieldWithParameters", testFieldWithParameters),
        ("testFieldWithChildren", testFieldWithChildren),
        ("testParentWhenInitializingWithChild", testParentWhenInitializingWithChild),
        ("testParentWhenAddingChild", testParentWhenAddingChild),
        ("testFieldsWithChildren", testFieldsWithChildren),
        ("testFieldsWithoutChildren", testFieldsWithoutChildren),
        ("testFieldAliases", testFieldAliases),
    ]
}
