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
        let query = GraphQLQuery(body: "boby")
        
        XCTAssertEqual(query.body, "boby")
        XCTAssertEqual(query.queryType, .query)
        XCTAssertNil(query.fragmentQuery)
    }
    
    func testInitQueryFragment() {
        let fragment = Fragment()
        let query = GraphQLQuery(body: "boby", fragment: fragment)
        
        XCTAssertEqual(query.body, "boby")
        XCTAssertEqual(query.queryType, .query)
        XCTAssertEqual(query.fragmentQuery?.name, "TypeFragment")
        XCTAssertEqual(query.fragmentQuery?.body, "field\n")
    }
    
    func testInitMutation() {
        let mutation = GraphQLMutation(body: "boby")
        
        XCTAssertEqual(mutation.body, "boby")
        XCTAssertEqual(mutation.queryType, .mutation)
        XCTAssertNil(mutation.fragmentQuery)
    }

    func testInitMutationFragment() {
        let fragment = Fragment()
        let mutation = GraphQLMutation(body: "boby", fragment: fragment)
        
        XCTAssertEqual(mutation.body, "boby")
        XCTAssertEqual(mutation.queryType, .mutation)
        XCTAssertEqual(mutation.fragmentQuery?.name, "TypeFragment")
        XCTAssertEqual(mutation.fragmentQuery?.body, "field\n")
    }
}
