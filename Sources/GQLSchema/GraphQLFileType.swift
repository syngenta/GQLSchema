//
//  GraphQLFileType.swift
//  GQLSchema
//
//  Created by Evegeny Kalashnikov on 30.09.2022.
//

import Foundation

public protocol GraphQLFileType: GraphQLValueType {
    var binary: Data { get }
    var contentType: String { get }
    var filename: String { get }
}
