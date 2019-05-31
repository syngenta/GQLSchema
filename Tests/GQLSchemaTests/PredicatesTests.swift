//
//  PredicatesTests.swift
//  GQLSchemaTests
//
//  Created by Evgeny Kalashnikov on 10/17/18.
//

import XCTest
@testable import GQLSchema

class PredicatesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPredicates() {
        let eq = GraphQLPredicates.eq(10, key: "id")
        XCTAssertEqual(eq._graphQLFormat, #"\"id_eq\":10"#)
        
        let not_eq = GraphQLPredicates.not_eq(10.0 as Float, key: "id")
        XCTAssertEqual(not_eq._graphQLFormat, #"\"id_not_eq\":10.0"#)
        
        let matches = GraphQLPredicates.matches("10", key: "text")
        XCTAssertEqual(matches._graphQLFormat, #"\"text_matches\":\"10\""#)
        
        let does_not_match = GraphQLPredicates.does_not_match("10", key: "text")
        XCTAssertEqual(does_not_match._graphQLFormat, #"\"text_does_not_match\":\"10\""#)
        
        let lt = GraphQLPredicates.lt(10, key: "id")
        XCTAssertEqual(lt._graphQLFormat, #"\"id_lt\":10"#)
        
        let lteq = GraphQLPredicates.lteq(10, key: "id")
        XCTAssertEqual(lteq._graphQLFormat, #"\"id_lteq\":10"#)
        
        let gt = GraphQLPredicates.gt(["id" : 10], key: "id")
        XCTAssertEqual(gt._graphQLFormat, #"\"id_gt\":["id": 10]"#)
        
        let gteq = GraphQLPredicates.gteq(10, key: "id")
        XCTAssertEqual(gteq._graphQLFormat, #"\"id_gteq\":10"#)
        
        let in_ = GraphQLPredicates.in([10], key: "ids")
        XCTAssertEqual(in_._graphQLFormat, #"\"ids_in\":[10]"#)
        
        let not_in = GraphQLPredicates.not_in([10], key: "ids")
        XCTAssertEqual(not_in._graphQLFormat, #"\"ids_not_in\":[10]"#)

        let cont = GraphQLPredicates.cont("str", key: "description")
        XCTAssertEqual(cont._graphQLFormat, #"\"description_cont\":\"str\""#)
        
        let not_cont = GraphQLPredicates.not_cont("str", key: "description")
        XCTAssertEqual(not_cont._graphQLFormat, #"\"description_not_cont\":\"str\""#)
        
        let start = GraphQLPredicates.start("str", key: "description")
        XCTAssertEqual(start._graphQLFormat, #"\"description_start\":\"str\""#)
    
        let not_start = GraphQLPredicates.not_start("str", key: "description")
        XCTAssertEqual(not_start._graphQLFormat, #"\"description_not_start\":\"str\""#)
        
        let end = GraphQLPredicates.end("str", key: "description")
        XCTAssertEqual(end._graphQLFormat, #"\"description_end\":\"str\""#)
        
        let not_end = GraphQLPredicates.not_end("str", key: "description")
        XCTAssertEqual(not_end._graphQLFormat, #"\"description_not_end\":\"str\""#)
        
        let null = GraphQLPredicates.null(true, key: "description")
        XCTAssertEqual(null._graphQLFormat, #"\"description_null\":true"#)
        
        let not_null = GraphQLPredicates.not_null(false, key: "description")
        XCTAssertEqual(not_null._graphQLFormat, #"\"description_not_null\":false"#)
    }
}
