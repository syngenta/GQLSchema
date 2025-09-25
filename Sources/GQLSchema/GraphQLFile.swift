//
//  GraphQLFile.swift
//  GQLSchema
//
//  Created by Evegeny Kalashnikov on 30.09.2022.
//

import Foundation

public struct GraphQLFile: Codable, GraphQLValueType {
    public var _graphQLFormat: String { "null" }

    public let binary: Data
    public let contentType: String
    public let filename: String

    public init(binary: Data, contentType: String, filename: String) {
        self.binary = binary
        self.contentType = contentType
        self.filename = filename
    }
}
