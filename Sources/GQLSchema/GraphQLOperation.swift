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
    let name: String
    let body: String
    
    init<Fragment: GraphQLFragment>(fragment: Fragment) {
        self.name = fragment.name
        self.body = fragment.description
    }
}

public protocol GraphQLOperation {
    var queryType: GraphQLOperationType { get }
    var body: String { get }
    var fragmentQuery: GraphQLFragmentQuery? { get }
}


public struct GraphQLQuery: GraphQLOperation {
    
    public var queryType: GraphQLOperationType {
        return .query
    }
    
    public private(set) var body: String
    public private(set) var fragmentQuery: GraphQLFragmentQuery?
    
    init<Fragment: GraphQLFragment>(body: String, fragment: Fragment) {
        self.body = body
        self.fragmentQuery = GraphQLFragmentQuery(fragment: fragment)
    }
    
    init(body: String) {
        self.body = body
        self.fragmentQuery = nil
    }
}

public struct GraphQLMutation: GraphQLOperation {
    
    public var queryType: GraphQLOperationType {
        return .mutation
    }
    
    public private(set) var body: String
    public private(set) var fragmentQuery: GraphQLFragmentQuery?
    
    init<Fragment: GraphQLFragment>(body: String, fragment: Fragment) {
        self.body = body
        self.fragmentQuery = GraphQLFragmentQuery(fragment: fragment)
    }
    
    init(body: String) {
        self.body = body
        self.fragmentQuery = nil
    }
}
