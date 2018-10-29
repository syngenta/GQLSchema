//
//  GraphQLOperationTests.swift
//  GQLSchemaTests
//
//  Created by Evgeny Kalashnikov on 10/18/18.
//

import XCTest
@testable import GQLSchema

fileprivate struct Fragment: GraphQLFragment {
    
    init(name: String, field: GraphQLField) {
        self.init()
    }
    
    static var typeName: String {
        return "Type"
    }
    var field: GraphQLField
    var name: String
    
    init() {
        self.name = Fragment.defaultName
        self.field = GraphQLField(name: "field")
    }
}

class GraphQLOperationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitQuery() {
        let query = GraphQLQuery(name: "Name", body: "boby")
        
        XCTAssertEqual(query.name, "Name")
        XCTAssertEqual(query.body, "boby")
        XCTAssertEqual(query.type, .query)
        XCTAssertNil(query.fragmentQuery)
    }
    
    func testInitQueryField() {
        let field = GraphQLField(name: "Name", children: [ GraphQLField(name: "boby")])
        let query = GraphQLQuery(field: field)
        
        XCTAssertEqual(query.name, "Name")
        XCTAssertEqual(query.body, "Name {\n    boby\n}\n")
        XCTAssertEqual(query.type, .query)
        XCTAssertNil(query.fragmentQuery)
    }
    
    func testInitQueryFragment() {
        let fragment = Fragment()
        let query = GraphQLQuery(name: "Name", body: "boby", fragment: fragment)
        
        XCTAssertEqual(query.name, "Name")
        XCTAssertEqual(query.body, "boby")
        XCTAssertEqual(query.type, .query)
        XCTAssertEqual(query.fragmentQuery?.name, "TypeFragment")
        XCTAssertEqual(query.fragmentQuery?.body, "field\n")
    }
    
    func testInitQueryFragmentField() {
        let fragment = Fragment()
        let field = GraphQLField(name: "Name", children: [ GraphQLField(name: "boby")])
        let query = GraphQLQuery(field: field, fragment: fragment)
        
        XCTAssertEqual(query.name, "Name")
        XCTAssertEqual(query.body, "Name {\n    boby\n}\n")
        XCTAssertEqual(query.type, .query)
        XCTAssertEqual(query.fragmentQuery?.name, "TypeFragment")
        XCTAssertEqual(query.fragmentQuery?.body, "field\n")
    }
    
    func testInitMutation() {
        let mutation = GraphQLMutation(name: "Name", body: "boby")
        
        XCTAssertEqual(mutation.name, "Name")
        XCTAssertEqual(mutation.body, "boby")
        XCTAssertEqual(mutation.type, .mutation)
        XCTAssertNil(mutation.fragmentQuery)
    }
    
    func testInitMutationField() {
        let field = GraphQLField(name: "Name", children: [ GraphQLField(name: "boby")])
        let mutation = GraphQLMutation(field: field)
        
        XCTAssertEqual(mutation.name, "Name")
        XCTAssertEqual(mutation.body, "Name {\n    boby\n}\n")
        XCTAssertEqual(mutation.type, .mutation)
        XCTAssertNil(mutation.fragmentQuery)
    }

    func testInitMutationFragment() {
        let fragment = Fragment()
        let mutation = GraphQLMutation(name: "Name", body: "boby", fragment: fragment)
        
        XCTAssertEqual(mutation.name, "Name")
        XCTAssertEqual(mutation.body, "boby")
        XCTAssertEqual(mutation.type, .mutation)
        XCTAssertEqual(mutation.fragmentQuery?.name, "TypeFragment")
        XCTAssertEqual(mutation.fragmentQuery?.body, "field\n")
    }
    
    func testInitMutationFragmentField() {
        let fragment = Fragment()
        let field = GraphQLField(name: "Name", children: [ GraphQLField(name: "boby")])
        let mutation = GraphQLMutation(field: field, fragment: fragment)
        
        XCTAssertEqual(mutation.name, "Name")
        XCTAssertEqual(mutation.body, "Name {\n    boby\n}\n")
        XCTAssertEqual(mutation.type, .mutation)
        XCTAssertEqual(mutation.fragmentQuery?.name, "TypeFragment")
        XCTAssertEqual(mutation.fragmentQuery?.body, "field\n")
    }
    
    func testEquitable() {
        let query = GraphQLQuery(name: "Name", body: "boby")
        let query2 = GraphQLQuery(name: "Name", body: "boby")

        XCTAssert(query == query2)
    }
}
