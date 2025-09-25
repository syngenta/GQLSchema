//
//  GraphQLQuery.swift
//  Gryphin-MacOS
//
//  Created by Evgeny Kalashnikov on 10/15/18.
//  Copyright © 2018 Evgeny Kalashnikov. All rights reserved.
//

public enum GraphQLOperationType: Codable {
    case query
    case mutation
}

public struct GraphQLFragmentQuery: Codable {
    public let name: String
    public let body: String
    
    init<Fragment: GraphQLFragment>(fragment: Fragment) {
        self.name = fragment.name
        self.body = fragment.description
    }
}

public protocol GraphQLOperation: CustomStringConvertible, Codable {
    var type: GraphQLOperationType { get }
    var name: String { get }
    var body: String { get }
    var fragmentQuery: GraphQLFragmentQuery? { get }
    init<Fragment: GraphQLFragment>(name: String, body: String, fragment: Fragment)
    init(name: String, body: String)
}

public extension GraphQLOperation {
    
    var description: String {
        return self.body + (self.fragmentQuery?.body ?? "")
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.description == rhs.description
    }
    
    init<Fragment: GraphQLFragment>(field: GraphQLField, fragment: Fragment) {
        self.init(name: field._name, body: field._graphQLFormat, fragment: fragment)
    }
    
    init(field: GraphQLField) {
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

public struct GraphQLOperationCodableBox: Codable {
    public let operation: GraphQLOperation

    enum CodingKeys: String, CodingKey {
        case type
        case operation
    }

    public init(operation: GraphQLOperation) {
        self.operation = operation
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch operation {
        case let operation as GraphQLQuery:
            try container.encode(GraphQLOperationType.query, forKey: .type)
            try container.encode(operation, forKey: .operation)
        case let operation as GraphQLMutation:
            try container.encode(GraphQLOperationType.mutation, forKey: .type)
            try container.encode(operation, forKey: .operation)
        default:
            let context = EncodingError.Context(
                codingPath: encoder.codingPath,
                debugDescription: "Unsupported GraphQLOperation type"
            )
            throw EncodingError.invalidValue(operation, context)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(GraphQLOperationType.self, forKey: .type)
        switch type {
        case .query:
            self.operation = try container.decode(GraphQLQuery.self, forKey: .operation)
        case .mutation:
            self.operation = try container.decode(GraphQLMutation.self, forKey: .operation)
        }
    }
}
