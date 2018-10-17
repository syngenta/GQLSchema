//
//  GraphQLInlineFragment.swift
//  Gryphin
//
//  Created by Dima Bart on 2017-01-08.
//  Copyright © 2017 Dima Bart. All rights reserved.
//

import Foundation

final class GraphQLInlineFragment: GraphQLContainerType {
    
    var _name:          String
    var _typeCondition: String
    var _parameters:    [GraphQLParameter]
    
    var _parent:        GraphQLContainerType?
    var _children:      [GraphQLReferenceType] = []
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(type: String, children: [GraphQLReferenceType]? = nil) {
        self._name          = ""
        self._typeCondition = type
        self._parameters    = []
        
        if let children = children {
            try! self._add(children: children)
        }
    }
    
    // ----------------------------------
    //  MARK: - GraphQLValueType -
    //
    var _graphQLFormat: String {
        var string = "\(self._indent)... on \(self._typeCondition)"
        
        if !self._children.isEmpty {
            let children       = self._children.map { $0._graphQLFormat }
            let joinedChildren = children.joined()
            
            string += "\(self._space){\(self._newline)"
            string += joinedChildren
            string += "\(self._indent)}"
        }
        
        string += self._newline
        
        return string
    }
}
