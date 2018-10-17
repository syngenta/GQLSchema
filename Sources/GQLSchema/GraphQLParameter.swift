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
    
    init(name: String, value: GraphQLValueType) {
        self.init(name: name, finalValue: value._graphQLFormat)
    }
    
    init(name: String, value: [GraphQLValueType]) {
        let values      = value.map { $0._graphQLFormat }
        let valueString = values.joined(separator: ", ")
        
        self.init(name: name, finalValue: "[\(valueString)]")
    }
    
    init(name: String, value: GraphQLScalarType) {
        self.init(name: name, value: value.string)
    }
    
    init(name: String, value: [GraphQLScalarType]) {
        self.init(name: name, value: value.map { $0.string })
    }
    
    init<T>(name: String, value: T) where T: RawRepresentable, T.RawValue == String {
        self.init(name: name, finalValue: value.rawValue)
    }
    
    init<T>(name: String, value: [T]) where T: RawRepresentable, T.RawValue == String {
        let values      = value.map { $0.rawValue }
        let valueString = values.joined(separator: ", ")
        
        self.init(name: name, finalValue: "[\(valueString)]")
    }
    
    // ----------------------------------
    //  MARK: - GraphQLValueType -
    //
    public var _graphQLFormat: String {
        return "\(self._name): \(self._value)"
    }
}

// ----------------------------------
//  MARK: - Equatable -
//
extension GraphQLParameter: Equatable {}

public func ==(lhs: GraphQLParameter, rhs: GraphQLParameter) -> Bool {
    return lhs._name == rhs._name && lhs._value._graphQLFormat == rhs._value._graphQLFormat
}
