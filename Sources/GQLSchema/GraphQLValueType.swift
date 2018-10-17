//
//  GraphQLValueType.swift
//  Gryphin
//
//  Created by Dima Bart on 2016-12-08.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public protocol GraphQLValueType {
    var _graphQLFormat: String { get }
}

// ----------------------------------
//  MARK: - Hashable & Equatable -
//
extension GraphQLValueType {
    var hashValue: Int {
        return self._graphQLFormat.hashValue
    }
}

public func ==<T: GraphQLValueType>(lhs: T, rhs: T) -> Bool {
    return lhs._graphQLFormat == rhs._graphQLFormat
}

// ----------------------------------
//  MARK: - Foundation -
//
extension String: GraphQLValueType {
    public var _graphQLFormat: String {
        return "\"\(self)\""
    }
}

extension Int: GraphQLValueType {
    public var _graphQLFormat: String {
        return "\(self)"
    }
}

extension Float: GraphQLValueType {
    public var _graphQLFormat: String {
        return "\(self)"
    }
}

extension Double: GraphQLValueType {
    public var _graphQLFormat: String {
        return "\(self)"
    }
}

extension Bool: GraphQLValueType {
    public var _graphQLFormat: String {
        return self ? "true" : "false"
    }
}

extension RawRepresentable where RawValue == String {
    public var _stringRepresentation: String {
        return "\(self.rawValue)"
    }
}
