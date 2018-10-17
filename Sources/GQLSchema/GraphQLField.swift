//
//  __Field.swift
//  Gryphin
//
//  Created by Dima Bart on 2016-12-12.
//  Copyright © 2016 Dima Bart. All rights reserved.
//

import Foundation

enum GraphQLFieldError: Error {
    case InvalidSyntax(String)
}

public class GraphQLField: GraphQLContainerType {
    
    public var _name:       String
    public var _alias:      String?
    public var _parameters: [GraphQLParameter]
    
    public var _parent:     GraphQLContainerType?
    public var _children:  [GraphQLReferenceType] = []
    
    private var enquedAlias: String?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public required init(name: String, alias: String? = nil, parameters: [GraphQLParameter] = [], children: [GraphQLReferenceType]? = nil) {
        self._name       = name
        self._alias      = alias?.aliasPrefixed
        self._parameters = parameters
        
        if let children = children {
            try! self._add(children: children)
        }
    }
    
    // ----------------------------------
    //  MARK: - Alias -
    //
    public func alias(_ alias: String) -> Self {
        self.enquedAlias = alias.aliasPrefixed
        return self
    }
    
    private func applyEnqueuedAliasTo(_ child: GraphQLReferenceType) throws {
        guard let alias = self.enquedAlias else {
            return
        }
        
        guard let field = child as? GraphQLField else {
            throw GraphQLFieldError.InvalidSyntax("Alias can only be applied to Field types.")
        }
        
        field._alias = alias
        
        self.enquedAlias = nil
    }
    
    // ----------------------------------
    //  MARK: - Children -
    //
    public func _add(children: [GraphQLReferenceType]) throws {
        if !children.isEmpty {
            
            if let child = children.first {
                try self.applyEnqueuedAliasTo(child)
            }
            
            children.forEach {
                $0._parent = self
            }
            self._children.append(contentsOf: children)
        }
    }
    
    @discardableResult
    public func fragment<Fragment: GraphQLFragment>(_ fragment: Fragment) -> Self {
        return self.fragment(name: fragment.name)
    }
    
    public func fragment(name: String) -> Self {
        let fragment_ = GraphQLField(name: "..." + name)
        try! self._add(children: [fragment_])
        return self
    }
}

// ----------------------------------
//  MARK: - GraphQLValueType -
//
extension GraphQLField {
    public var _graphQLFormat: String {
        var representation: String
        
        if let alias = self._alias {
            representation = "\(self._indent)\(alias): \(self._name)"
        } else {
            representation = "\(self._indent)\(self._name)"
        }
        
        if !self._parameters.isEmpty {
            let keyValues      = self._parameters.map { $0._graphQLFormat }
            let keyValueString = keyValues.joined(separator: " ")
            representation    += "(\(keyValueString))"
        }
        
        if !self._children.isEmpty {
            let children       = self._children.map { $0._graphQLFormat }
            let joinedChildren = children.joined()
            
            representation += "\(self._space){\(self._newline)"
            representation += joinedChildren
            representation += "\(self._indent)}"
        }
        
        representation += self._newline
        
        return representation
    }
}
