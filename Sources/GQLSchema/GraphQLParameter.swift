//
//  GraphQLParameter.swift
//  Gryphin
//
//  Created by Dima Bart on 2016-12-08.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public struct GraphQLParameter: GraphQLValueType {

    fileprivate let _name:  String
    fileprivate let _value: String

    // ----------------------------------
    //  MARK: - Init -
    //
    private init(name: String, finalValue: String) {
        self._name  = name
        self._value = finalValue
    }

    public init<T: GraphQLValueType>(name: String, value: T) {
        self.init(name: name, finalValue: value._graphQLFormat)
    }

    public init<T: GraphQLValueType>(name: String, value: [T]) {
        self.init(name: name, finalValue: value._graphQLFormat)
    }

    // ----------------------------------
    //  MARK: - GraphQLValueType -
    //
    public var _graphQLFormat: String { "\(self._name): \(self._value)" }
}

// ----------------------------------
//  MARK: - Equatable -
//
extension GraphQLParameter: Equatable {}

public func ==(lhs: GraphQLParameter, rhs: GraphQLParameter) -> Bool {
    return lhs._name == rhs._name && lhs._value._graphQLFormat == rhs._value._graphQLFormat
}
