//
//  GraphQLTypedField.swift
//  Gryphin
//
//  Created by Dima Bart on 2017-01-16.
//  Copyright © 2017 Dima Bart. All rights reserved.
//

import Foundation

open class GraphQLTypedField: GraphQLField {

    // ----------------------------------
    //  MARK: - Init -
    //
    public required init(name: String, alias: String? = nil, parameters: [GraphQLParameter] = [], children: [GraphQLReferenceType]? = nil) {
        var modifiedChildren: [GraphQLReferenceType] = children ?? []
        
        /* ------------------------------------
         ** A typed field automatically appends
         ** the type meta field. Often used in
         ** fragments where a heterogeneous
         ** collection is returned.
         */
        modifiedChildren.insert(GraphQLField(name: "__typename"), at: 0)
        
        super.init(name: name, alias: alias, parameters: parameters, children: modifiedChildren)
    }
}
