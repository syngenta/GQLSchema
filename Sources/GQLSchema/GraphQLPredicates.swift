//
//  GraphQLQueryPredicates.swift
//  Gryphin-MacOS
//
//  Created by Evgeny Kalashnikov on 10/15/18.
//  Copyright © 2018 Evgeny Kalashnikov. All rights reserved.
//

public protocol GraphQLPredicativeFeilds {
    var value: (property: String, value: Any) { get }
}

public enum GraphQLPredicates<T> {
    /// equals
    case eq(_ value: T)
    
    /// not equal to
    case not_eq(_ value: T)
    
    /// matches
    case matches(_ value: T)
    
    /// doesn't match
    case does_not_match(_ value: T)
    
    /// less than
    case lt(_ value: T)
    
    /// less than or equal to
    case lteq(_ value: T)
    
    /// greater than
    case gt(_ value: T)
    
    /// greater than or equal to
    case gteq(_ value: T)
    
    /// in
    case `in`(_ value: [T])
    
    /// not in
    case not_in(_ value: [T])
    
    /// contains
    case cont(_ value: T)
    
    /// doesn't contain
    case not_cont(_ value: T)
    
    /// starts with
    case start(_ value: T)
    
    /// doesn't start with
    case not_start(_ value: T)
    
    /// ends with
    case end(_ value: T)
    
    /// doesn't end with
    case not_end(_ value: T)
    
    /// is null
    case null(_ value: Bool)
    
    /// is not null
    case not_null(_ value: Bool)
    
    func predicate(property: String) -> (property: String, value: Any) {
        let key = property + "_"
        switch self {
        case .eq(let value): return (key + "eq", value)
        case .not_eq(let value): return (key + "not_eq", value)
        case .matches(let value): return (key + "matches", value)
        case .does_not_match(let value): return (key + "does_not_match", value)
        case .lt(let value): return (key + "lt", value)
        case .lteq(let value): return (key + "lteq", value)
        case .gt(let value): return (key + "gt", value)
        case .gteq(let value): return (key + "gteq", value)
        case .in(let value): return (key + "in", value)
        case .not_in(let value): return (key + "not_in", value)
        case .cont(let value): return (key + "cont", value)
        case .not_cont(let value): return (key + "not_cont", value)
        case .start(let value): return (key + "start", value)
        case .not_start(let value): return (key + "not_start", value)
        case .end(let value): return (key + "end", value)
        case .not_end(let value): return (key + "not_end", value)
        case .null(let value): return (key + "null", value ? "true" : "false")
        case .not_null(let value): return (key + "not_null", value ? "true" : "false")
        }
    }
}
