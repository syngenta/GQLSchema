//
//  CodableTests.swift
//  GQLSchema
//
//  Created by Yevhenii Kalashnikov on 08.09.2025.
//

import XCTest
@testable import GQLSchema

class CodableTests: XCTestCase {

    public final class ItemFragment: GraphQLFragment {

        public static var typeName: String { "Item" }

        private(set) public var name: String
        private(set) public var field: Item
        public required init(name: String, field: Item) {
            self.name = name
            self.field = field
        }
    }

    public final class Item: GraphQLField {

        /// ID of object
        ///  - Value Type: `ID`
        public var id: Self {
            let field = GraphQLField(name: "id", parameters: [])
            try! self._add(child: field)

            return self
        }

        /// MachineTaskGroupFolderMappingItem update time
        ///  - Value Type: `Datetime!`
        public var updated_at: Self {
            let field = GraphQLField(name: "updated_at", parameters: [])
            try! self._add(child: field)

            return self
        }

        /// MachineTaskGroupFolderMappingItem creation time
        ///  - Value Type: `Datetime!`
        public var created_at: Self {
            let field = GraphQLField(name: "created_at", parameters: [])
            try! self._add(child: field)

            return self
        }
    }

    func createItem(id: GraphQLValue<Int>? = nil,
                    updated_at: GraphQLValue<String>? = nil,
                    created_at: GraphQLValue<String>? = nil,
                    _ buildOn: (Item) -> Void) -> GraphQLMutation {

        var parameters: [GraphQLParameter] = []

        if let arg = id { parameters.append(GraphQLParameter(name: "id", value: arg)) }
        if let arg = updated_at { parameters.append(GraphQLParameter(name: "updated_at", value: arg)) }
        if let arg = created_at { parameters.append(GraphQLParameter(name: "created_at", value: arg)) }

        let field = Item(name: "createItem", parameters: parameters)
        buildOn(field)

        return GraphQLMutation(field: field)
    }

    func getItems(id: GraphQLValue<Int>? = nil,
                  limit: GraphQLValue<Int>? = nil,
                  fragment: ItemFragment) -> GraphQLQuery {

        var parameters: [GraphQLParameter] = []

        if let arg = id { parameters.append(GraphQLParameter(name: "id", value: arg)) }
        if let arg = limit { parameters.append(GraphQLParameter(name: "limit", value: arg)) }

        let field = Item(name: "getItems", parameters: parameters)
        field.fragment(fragment)

        return GraphQLQuery(field: field, fragment: fragment)
    }

    func testFragmentQuery() {
        let fragment = ItemFragment(name: "Item") { _ = $0
            .id
            .updated_at
            .created_at
        }

        let query = GraphQLFragmentQuery(fragment: fragment)

        let encoder = JSONEncoder()
        do {
            // MARK: - Encode
            let encoded = try encoder.encode(query)
            guard let jsonString = String(data: encoded, encoding: .utf8) else {
                XCTFail("Encoding failed: cannot convert data to string")
                return
            }

            XCTAssertTrue(jsonString.contains(#""name":"Item""#))
            XCTAssertTrue(jsonString.contains(#""body":"fragment Item on Item {\n    id\n    updated_at\n    created_at\n}\n""#))

            // MARK: - Decode
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(GraphQLFragmentQuery.self, from: encoded)
            XCTAssertEqual(decoded.name, "Item")
            XCTAssertEqual(decoded.body, """
                fragment Item on Item {
                    id
                    updated_at
                    created_at
                }

                """
            )
        } catch {
            XCTFail("Encoding failed: \(error) ")
        }
    }

    func testGraphQLMutation() {
        let mutation = createItem(id: .value(123), updated_at: .value("2025-01-01"), created_at: .variable("created")) { item in
            _ = item
                .id
                .updated_at
                .created_at
        }

        let encoder = JSONEncoder()
        do {
            // MARK: - Encode
            let encoded = try encoder.encode(mutation)
            guard let jsonString = String(data: encoded, encoding: .utf8) else {
                XCTFail("Encoding failed: cannot convert data to string")
                return
            }

            XCTAssertTrue(jsonString.contains(#""name":"createItem""#))
            XCTAssertTrue(jsonString.contains(#""body":"createItem(id: 123 updated_at: \"2025-01-01\" created_at: $created) {\n    id\n    updated_at\n    created_at\n}\n""#))

            // MARK: - Decode
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(GraphQLMutation.self, from: encoded)
            XCTAssertEqual(decoded.name, "createItem")
            XCTAssertEqual(decoded.body, """
                createItem(id: 123 updated_at: "2025-01-01" created_at: $created) {
                    id
                    updated_at
                    created_at
                }

                """
            )
        } catch {
            XCTFail("Encoding failed: \(error) ")
        }
    }

    func testGraphQLQuery() {
        let fragment = ItemFragment(name: "Item") { _ = $0
            .id
            .updated_at
            .created_at
        }

        let query = getItems(id: .value(21), limit: .value(10), fragment: fragment)

        let encoder = JSONEncoder()
        do {
            // MARK: - Encode
            let encoded = try encoder.encode(query)
            guard let jsonString = String(data: encoded, encoding: .utf8) else {
                XCTFail("Encoding failed: cannot convert data to string")
                return
            }

            XCTAssertTrue(jsonString.contains(#""name":"getItems""#))
            XCTAssertTrue(jsonString.contains(#""body":"getItems(id: 21 limit: 10) {\n    ...Item\n}\n""#))

            // MARK: - Decode
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(GraphQLQuery.self, from: encoded)
            XCTAssertEqual(decoded.name, "getItems")
            XCTAssertEqual(decoded.body, """
                getItems(id: 21 limit: 10) {
                    ...Item
                }

                """
            )
            XCTAssertEqual(decoded.fragmentQuery?.name, "Item")
            XCTAssertEqual(decoded.fragmentQuery?.body, """
                fragment Item on Item {
                    id
                    updated_at
                    created_at
                }

                """
            )
        } catch {
            XCTFail("Encoding failed: \(error) ")
        }
    }


    static var allTests = [
        ("testFragmentQuery", testFragmentQuery),
        ("testGraphQLMutation", testGraphQLMutation),
        ("testGraphQLQuery", testGraphQLQuery)
    ]
}
