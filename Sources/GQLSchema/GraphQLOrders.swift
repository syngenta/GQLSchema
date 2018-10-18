//
//  GraphQLOrders.swift
//  Gryphin-MacOS
//
//  Created by Evgeny Kalashnikov on 10/15/18.
//  Copyright © 2018 Evgeny Kalashnikov. All rights reserved.
//

public protocol GraphQLOrderableFeilds {
    var value: (property: String, value: String) { get }
}

public enum GraphQLOrders: String {
    /// sorting asc
    case asc
    
    /// sorting asc
    case desc
    
    func order(property: String) -> (property: String, value: String) {
        switch self {
        case .asc: return (property, "asc")
        case .desc: return (property, "desc")
        }
    }
}
