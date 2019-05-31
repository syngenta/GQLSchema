//
//  GraphQLFragment.swift
//  Gryphin
//
//  Created by Evgeny Kalashnikov on 10/12/18.
//  Copyright © 2018 Dima Bart. All rights reserved.
//

import Foundation

public protocol GraphQLFragment: CustomStringConvertible {
    associatedtype Field: GraphQLField
    static var typeName: String { get }
    var field: Field { get }
    var name: String { get }
    init(name: String, field: Field)
}

public extension GraphQLFragment {
    
    static var defaultName: String {
        return Self.typeName + "Fragment"
    }
    
    init(name: String = Self.defaultName, _ buildOn: (Field) -> Void) {
        let field = Field(name: "fragment \(name) on \(Self.typeName)", parameters: [])
        buildOn(field)
        self = Self.init(name: name, field: field)
    }
    
    var description: String {
        return self.field._graphQLFormat
    }
}
