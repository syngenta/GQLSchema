//
//  OrdersTests.swift
//  GQLSchemaTests
//
//  Created by Evgeny Kalashnikov on 10/17/18.
//

import XCTest
@testable import GQLSchema

class OrdersTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOrders() {
        let asc = GraphQLOrders.asc.order(property: "id")
        XCTAssertEqual(asc.property, "id")
        XCTAssertEqual(asc.value, "asc")
        
        let desc = GraphQLOrders.desc.order(property: "id")
        XCTAssertEqual(desc.property, "id")
        XCTAssertEqual(desc.value, "desc")
    }
    
    func testEnum() {
        enum Orders: GraphQLOrderableFeilds {
            var value: (property: String, value: String) {
                switch self {
        
                case .additional_info(let value): return value.order(property: "additional_info")
                case .area(let value): return value.order(property: "area")
                }
            }
        
            case additional_info(_ value: GraphQLOrders)
            case area(_ value: GraphQLOrders)
        }
        
        let asc = Orders.additional_info(.asc).value
        XCTAssertEqual(asc.property, "additional_info")
        XCTAssertEqual(asc.value, "asc")
        
        let desc = Orders.area(.desc).value
        XCTAssertEqual(desc.property, "area")
        XCTAssertEqual(desc.value, "desc")
    }
}
