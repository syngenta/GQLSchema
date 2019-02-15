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

public enum GraphQLPredicates {
    /// equals
    case eq(_ value: Any, key: String)
    
    /// not equal to
    case not_eq(_ value: Any, key: String)
    
    /// matches
    case matches(_ value: Any, key: String)
    
    /// doesn't match
    case does_not_match(_ value: Any, key: String)
    
    /// less than
    case lt(_ value: Any, key: String)
    
    /// less than or equal to
    case lteq(_ value: Any, key: String)
    
    /// greater than
    case gt(_ value: Any, key: String)
    
    /// greater than or equal to
    case gteq(_ value: Any, key: String)
    
    /// in
    case `in`(_ value: [Any], key: String)
    
    /// not in
    case not_in(_ value: [Any], key: String)
    
    /// contains
    case cont(_ value: Any, key: String)
    
    /// doesn't contain
    case not_cont(_ value: Any, key: String)
    
    /// starts with
    case start(_ value: Any, key: String)
    
    /// doesn't start with
    case not_start(_ value: Any, key: String)
    
    /// ends with
    case end(_ value: Any, key: String)
    
    /// doesn't end with
    case not_end(_ value: Any, key: String)
    
    /// is null
    case null(_ value: Bool, key: String)
    
    /// is not null
    case not_null(_ value: Bool, key: String)
    
    public func predicate(property: String) -> (property: String, value: Any) {
        let key = property + "_"
        switch self {
        case .eq(let value, _): return (key + "eq", value)
        case .not_eq(let value, _): return (key + "not_eq", value)
        case .matches(let value, _): return (key + "matches", value)
        case .does_not_match(let value, _): return (key + "does_not_match", value)
        case .lt(let value, _): return (key + "lt", value)
        case .lteq(let value, _): return (key + "lteq", value)
        case .gt(let value, _): return (key + "gt", value)
        case .gteq(let value, _): return (key + "gteq", value)
        case .in(let value, _): return (key + "in", value)
        case .not_in(let value, _): return (key + "not_in", value)
        case .cont(let value, _): return (key + "cont", value)
        case .not_cont(let value, _): return (key + "not_cont", value)
        case .start(let value, _): return (key + "start", value)
        case .not_start(let value, _): return (key + "not_start", value)
        case .end(let value, _): return (key + "end", value)
        case .not_end(let value, _): return (key + "not_end", value)
        case .null(let value, _): return (key + "null", value ? "true" : "false")
        case .not_null(let value, _): return (key + "not_null", value ? "true" : "false")
        }
    }
    
    func value(_ value: Any, key: String, code: String) -> String {
        if let value = value as? String {
            return "\\\"\(key)_\(code)\\\":\\\"\(value)\\\""
        } else if let value = value as? Int {
            return "\\\"\(key)_\(code)\\\":\(value)"
        } else if let value = value as? Float {
            return "\\\"\(key)_\(code)\\\":\(value)"
        } else if let value = value as? Bool {
            return "\\\"\(key)_\(code)\\\":\(value ? "true" : "false")"
        } else if let value = value as? [Any] {
            return "\\\"\(key)_\(code)\\\":\(value)"
        }
        return "\\\"\(key)_\(code)\\\":\(value)"
    }
    
    public var _graphQLFormat: String {
        switch self {
        case .eq(let value, let key): return self.value(value, key: key, code: "eq")
        case .not_eq(let value, let key): return self.value(value, key: key, code: "not_eq")
        case .matches(let value, let key): return self.value(value, key: key, code: "matches")
        case .does_not_match(let value, let key): return self.value(value, key: key, code: "does_not_match")
        case .lt(let value, let key): return self.value(value, key: key, code: "lt")
        case .lteq(let value, let key): return self.value(value, key: key, code: "lteq")
        case .gt(let value, let key): return self.value(value, key: key, code: "gt")
        case .gteq(let value, let key): return self.value(value, key: key, code: "gteq")
        case .in(let value, let key): return self.value(value, key: key, code: "in")
        case .not_in(let value, let key): return self.value(value, key: key, code: "not_in")
        case .cont(let value, let key): return self.value(value, key: key, code: "cont")
        case .not_cont(let value, let key): return self.value(value, key: key, code: "not_cont")
        case .start(let value, let key): return self.value(value, key: key, code: "start")
        case .not_start(let value, let key): return self.value(value, key: key, code: "not_start")
        case .end(let value, let key): return self.value(value, key: key, code: "end")
        case .not_end(let value, let key): return self.value(value, key: key, code: "not_end")
        case .null(let value, let key): return self.value(value, key: key, code: "null")
        case .not_null(let value, let key): return self.value(value, key: key, code: "not_null")
        }
    }
}
