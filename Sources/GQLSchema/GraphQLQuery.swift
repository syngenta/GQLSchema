//
//  GraphQLQuery.swift
//  Gryphin-MacOS
//
//  Created by Evgeny Kalashnikov on 10/15/18.
//  Copyright © 2018 Dima Bart. All rights reserved.
//

public struct GraphQLQuery {
    public enum QueryType {
        case query
        case mutation
    }
    
    public let queryType: QueryType
    public let body: String
    public let fragmentBody: String?
}
