//
//  GraphQLVariable.swift
//  GQLSchema
//
//  Created by Evegeny Kalashnikov on 15.09.2022.
//

import Foundation

/// Struct for GraphQL variable
public struct GraphQLVariable: Codable {

    public enum ValueType: Codable {
        case value(String)
        case file(GraphQLFile)

        var value: String {
            switch self {
                case .value(let string): string
                case .file(let file): "null"
            }
        }

        public var isFile: Bool {
            switch self {
                case .value: false
                case .file: true
            }
        }
    }

    public let type: String
    public let name: String
    public let value: ValueType

    /// Initialiser
    /// - Parameters:
    ///   - type: string value of variable type, should include *!* if not optional (example "Int" - if optional, "Int!" - if not optional)
    ///   - name: variable name can be specified by your discretion
    ///   - value: can be specified only with value that has realisation of protocol *GraphQLValueType*
    public init(type: String, name: String, value: GraphQLValueType) {
        self.type = type
        self.name = name
        if let value = value as? GraphQLFile {
            self.value = .file(value)
        } else {
            self.value = .value(value._graphQLFormat)
        }
    }

    /// Initialiser
    /// - Parameters:
    ///   - type: string value of variable type, should include *!* if not optional (example "Int" - if optional, "Int!" - if not optional)
    ///   - name: variable name can be specified by your discretion
    ///   - file: can be specified with GraphQLFile data type
    public init(type: String, name: String, file: GraphQLFile) {
        self.type = type
        self.name = name
        self.value = .file(file)
    }

    public var declaration: String { "$" + self.name + ": " + self.type }
    public var bodyValue: String { "\"\(self.name)\": \(self.value.value)" }
}
