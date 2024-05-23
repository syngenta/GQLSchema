//
//  ScalarType.swift
//  Gryphin
//
//  Created by Dima Bart on 2017-03-02.
//  Copyright © 2017 Dima Bart. All rights reserved.
//

import Foundation

public protocol GraphQLScalarType: GraphQLValueType {
    var string: String { get }
    init(from string: String) throws
}

public extension GraphQLScalarType {
    var _graphQLFormat: String { self.string._graphQLFormat }
}
