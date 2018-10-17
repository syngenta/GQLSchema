//
//  FragmentTests.swift
//  GQLSchemaTests
//
//  Created by Evgeny Kalashnikov on 10/17/18.
//

import XCTest
@testable import GQLSchema

fileprivate class TestField: GraphQLField {
    
    public var code: TestField {
        let field = GraphQLField(name: "code", parameters: [])
        try! self._add(child: field)
        
        return self
    }
    
    public var created_at: TestField {
        let field = GraphQLField(name: "created_at", parameters: [])
        try! self._add(child: field)
        
        return self
    }
    
    public var description: TestField {
        let field = GraphQLField(name: "description", parameters: [])
        try! self._add(child: field)
        
        return self
    }
}

fileprivate class Fragment: GraphQLFragment {
    static var typeName: String = "TestField"
    
    var field: TestField
    var name: String
    
    required init(name: String, field: TestField) {
        self.name = name
        self.field = field
    }
}

class FragmentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit() {
        let fragment = Fragment { _ = $0
            .code
            .description
            .created_at
        }
        
        XCTAssertEqual(fragment.name, Fragment.typeName + "Fragment")
        XCTAssertEqual(fragment.name, Fragment.defaultName)
        
        print(fragment.description)
        
        let wrongFragment = """
        fragment TestFieldFragment on TestField {
            code
            description
        }
        
        """
        
        let correctFragment = """
        fragment TestFieldFragment on TestField {
            code
            description
            created_at
        }
        
        """
        
        XCTAssertNotEqual(fragment.description, wrongFragment)
        XCTAssertEqual(fragment.description, correctFragment)
        
        let fragment2 = Fragment(name: "myFragment") { _ = $0
            .code
            .description
            .created_at
        }
        
        let correctFragment2 = """
        fragment myFragment on TestField {
            code
            description
            created_at
        }
        
        """
        
        XCTAssertEqual(fragment2.description, correctFragment2)
    }
    
    func testAddingFragment() {
        let fragment = Fragment { _ = $0
            .code
            .description
            .created_at
        }
        
        let field = TestField(name: "getTestFields").fragment(fragment)
        
        print(field._graphQLFormat)
        
        let fieldText = """
        getTestFields {
            ...TestFieldFragment
        }
        
        """
        XCTAssertEqual(field._graphQLFormat, fieldText)
    }
}
