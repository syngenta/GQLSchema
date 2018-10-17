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
        let eq = GraphQLPredicates.eq(10).predicate(property: "id")
        XCTAssertEqual(eq.property, "id_eq")
        XCTAssertEqual(eq.value as! Int, 10)
        
        let not_eq = GraphQLPredicates.not_eq(10.0).predicate(property: "id")
        XCTAssertEqual(not_eq.property, "id_not_eq")
        XCTAssertEqual(not_eq.value as! Double, 10)
        
        let matches = GraphQLPredicates.matches("10").predicate(property: "text")
        XCTAssertEqual(matches.property, "text_matches")
        XCTAssertEqual(matches.value as! String, "10")
        
        let does_not_match = GraphQLPredicates.does_not_match("10").predicate(property: "text")
        XCTAssertEqual(does_not_match.property, "text_does_not_match")
        XCTAssertEqual(does_not_match.value as! String, "10")
        
        let lt = GraphQLPredicates.lt(10).predicate(property: "id")
        XCTAssertEqual(lt.property, "id_lt")
        XCTAssertEqual(lt.value as! Int, 10)
        
        let lteq = GraphQLPredicates.lteq(10).predicate(property: "id")
        XCTAssertEqual(lteq.property, "id_lteq")
        XCTAssertEqual(lteq.value as! Int, 10)
        
        let gt = GraphQLPredicates.gt(10).predicate(property: "id")
        XCTAssertEqual(gt.property, "id_gt")
        XCTAssertEqual(gt.value as! Int, 10)
        
        let gteq = GraphQLPredicates.gteq(10).predicate(property: "id")
        XCTAssertEqual(gteq.property, "id_gteq")
        XCTAssertEqual(gteq.value as! Int, 10)
        
        let in_ = GraphQLPredicates.in([10]).predicate(property: "ids")
        XCTAssertEqual(in_.property, "ids_in")
        XCTAssertEqual(in_.value as! [Int], [10])
        
        let not_in = GraphQLPredicates.not_in([10]).predicate(property: "ids")
        XCTAssertEqual(not_in.property, "ids_not_in")
        XCTAssertEqual(not_in.value as! [Int], [10])

        let cont = GraphQLPredicates.cont("str").predicate(property: "description")
        XCTAssertEqual(cont.property, "description_cont")
        XCTAssertEqual(cont.value as! String, "str")
        
        let not_cont = GraphQLPredicates.not_cont("str").predicate(property: "description")
        XCTAssertEqual(not_cont.property, "description_not_cont")
        XCTAssertEqual(not_cont.value as! String, "str")
        
        let start = GraphQLPredicates.start("str").predicate(property: "description")
        XCTAssertEqual(start.property, "description_start")
        XCTAssertEqual(start.value as! String, "str")
    
        let not_start = GraphQLPredicates.not_start("str").predicate(property: "description")
        XCTAssertEqual(not_start.property, "description_not_start")
        XCTAssertEqual(not_start.value as! String, "str")
        
        let end = GraphQLPredicates.end("str").predicate(property: "description")
        XCTAssertEqual(end.property, "description_end")
        XCTAssertEqual(end.value as! String, "str")
        
        let not_end = GraphQLPredicates.not_end("str").predicate(property: "description")
        XCTAssertEqual(not_end.property, "description_not_end")
        XCTAssertEqual(not_end.value as! String, "str")
        
        let null = GraphQLPredicates<String>.null(true).predicate(property: "description")
        XCTAssertEqual(null.property, "description_null")
        XCTAssertEqual(null.value as! String, "true")
        
        let not_null = GraphQLPredicates<String>.not_null(false).predicate(property: "description")
        XCTAssertEqual(not_null.property, "description_not_null")
        XCTAssertEqual(not_null.value as! String, "false")
    }
    
    func testEnum() {
        indirect enum Predicates: GraphQLPredicativeFeilds {

            var value: (property: String, value: Any) {
                switch self {
                case .additional_info(let value): return value.predicate(property: "additional_info")
                case .area(let value): return value.predicate(property: "area")
                }
            }

            case additional_info(_ value: GraphQLPredicates<String>)
            case area(_ value: GraphQLPredicates<Double?>)
        }
        
        let eq = Predicates.area(.eq(10)).value
        XCTAssertEqual(eq.property, "area_eq")
        XCTAssertEqual(eq.value as! Double, 10)
        
        let cont = Predicates.additional_info(.cont("text")).value
        XCTAssertEqual(cont.property, "additional_info_cont")
        XCTAssertEqual(cont.value as! String, "text")
    }
}
