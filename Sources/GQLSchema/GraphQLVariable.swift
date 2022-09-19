//
//  GraphQLVariable.swift
//  GQLSchema
//
//  Created by Evegeny Kalashnikov on 15.09.2022.
//

import Foundation

/// Struct for GraphQL variable
public struct GraphQLVariable {
    let type: String
    let name: String
    let value: GraphQLValueType

    /// Initialiser
    /// - Parameters:
    ///   - type: string value of variable type, should include *!* if not optional (example "Int" - if optional, "Int!" - if not optional)
    ///   - name: variable name can be specified by your discretion
    ///   - value: can be specified only with value that has realisation of protocol *GraphQLValueType*
    public init(type: String, name: String, value: GraphQLValueType) {
        self.type = type
        self.name = name
        self.value = value
    }

    public var declaration: String { "$" + self.name + ": " + self.type }
    public var bodyValue: String { "\"\(self.name)\": \(self.value._graphQLFormat)" }
}
