//
//  DataModel.swift
//  Blog
//
//  Created by 1 on 15.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import Foundation

public struct ObtainedData: Codable {
    let content: [Content]
    let first, last: Bool
    let number, numberOfElements: Int
    let pageable: Pageable
    let size: Int
    let sort: Sort
    let totalElements, totalPages: Int
}

public struct Content: Codable {
    let id: Int
    let name, shortName: String
    let privateAccess: Bool
    let created, updated: Int
}

public struct Pageable: Codable {
    let offset, pageNumber, pageSize: Int
    let paged: Bool
    let sort: Sort
    let unpaged: Bool
}

public struct Sort: Codable {
    let sorted, unsorted: Bool
}

public struct Login: Codable {
    let token: String?
    let duration: Int?
    let message: String?
}
