//
//  GraphQLValue.swift
//  GQLSchema
//
//  Created by Evegeny Kalashnikov on 15.09.2022.
//

import Foundation

/// GraphQLValue function parameter for decelerating GraphQL query can contains value or variable
public enum GraphQLValue<T: GraphQLValueType>: GraphQLValueType {

    /// Represents GraphQL literal `null` (explicitly sends `null` as the argument value).
    /// Note: this is not Swift `nil` — use it when you need to override a default value or clear an optional field.
    case null

    /// can be specified only with value that has realisation of protocol *GraphQLValueType*
    case value(T)

    /// gives ability to specify variable instead of value (*name* should be without "$")
    case variable(_ name: String)

    public var _graphQLFormat: String {
        switch self {
        case .null:
            return "null"
        case .value(let value):
            return value._graphQLFormat
        case .variable(let name):
            return "$" + name
        }
    }
}
