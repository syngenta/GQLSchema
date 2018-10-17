//
//  GraphQLInputType.swift
//  Gryphin
//
//  Created by Dima Bart on 2017-01-12.
//  Copyright © 2017 Dima Bart. All rights reserved.
//

import Foundation

public protocol GraphQLInputType: GraphQLValueType {
    func _representationParameters() -> [GraphQLParameter]
}

extension GraphQLInputType {
    
    public var _graphQLFormat: String {
        let parameters = self._representationParameters().map {
            $0._graphQLFormat
        }.joined(separator: ", ")

        return "{\(parameters)}"
    }
}
