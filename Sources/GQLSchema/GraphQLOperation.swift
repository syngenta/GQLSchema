//
//  GraphQLQuery.swift
//  Gryphin-MacOS
//
//  Created by Evgeny Kalashnikov on 10/15/18.
//  Copyright © 2018 Evgeny Kalashnikov. All rights reserved.
//

public enum GraphQLOperationType {
    case query
    case mutation
}

public struct GraphQLFragmentQuery {
    public let name: String
    public let body: String
    
    init<Fragment: GraphQLFragment>(fragment: Fragment) {
        self.name = fragment.name
        self.body = fragment.description
    }
}

public protocol GraphQLOperation {
    var type: GraphQLOperationType { get }
    var name: String { get }
    var body: String { get }
    var fragmentQuery: GraphQLFragmentQuery? { get }
    init<Fragment: GraphQLFragment>(name: String, body: String, fragment: Fragment)
    init(name: String, body: String)
}

public extension GraphQLOperation {
    public init<Fragment: GraphQLFragment>(field: GraphQLField, fragment: Fragment) {
        self.init(name: field._name, body: field._graphQLFormat, fragment: fragment)
    }
    
    public init(field: GraphQLField) {
        self.init(name: field._alias ?? field._name, body: field._graphQLFormat)
    }
}


public struct GraphQLQuery: GraphQLOperation {
    
    public var type: GraphQLOperationType {
        return .query
    }
    
    public private(set) var name: String
    public private(set) var body: String
    public private(set) var fragmentQuery: GraphQLFragmentQuery?
    
    public init<Fragment: GraphQLFragment>(name: String, body: String, fragment: Fragment) {
        self.name = name
        self.body = body
        self.fragmentQuery = GraphQLFragmentQuery(fragment: fragment)
    }
    
    public init(name: String, body: String) {
        self.name = name
        self.body = body
        self.fragmentQuery = nil
    }
}

public struct GraphQLMutation: GraphQLOperation {
    
    public var type: GraphQLOperationType {
        return .mutation
    }
    
    public private(set) var name: String
    public private(set) var body: String
    public private(set) var fragmentQuery: GraphQLFragmentQuery?
    
    public init<Fragment: GraphQLFragment>(name: String, body: String, fragment: Fragment) {
        self.name = name
        self.body = body
        self.fragmentQuery = GraphQLFragmentQuery(fragment: fragment)
    }
    
    public init(name: String, body: String) {
        self.name = name
        self.body = body
        self.fragmentQuery = nil
    }
}
