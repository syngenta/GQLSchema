//
//  GraphQLContainerType.swift
//  Gryphin
//
//  Created by Dima Bart on 2016-12-08.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

public protocol GraphQLContainerType: GraphQLReferenceType {
    var _children:   [GraphQLReferenceType]  { get set }
    var _parameters: [GraphQLParameter]      { get }
    
    func _add(children: [GraphQLReferenceType]) throws
}

extension GraphQLContainerType {
    
    // ----------------------------------
    //  MARK: - Children -
    //
    public func _add(child: GraphQLReferenceType) throws {
        try _add(children: [child])
    }
    
    public func _add(children: [GraphQLReferenceType]) throws {
        if !children.isEmpty {
            children.forEach {
                $0._parent = self
            }
            self._children.append(contentsOf: children)
        }
    }
}

public func ==(lhs: GraphQLContainerType, rhs: GraphQLContainerType) -> Bool {
    return lhs === rhs
}
