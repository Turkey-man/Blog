//
//  DataModel.swift
//  Blog
//
//  Created by 1 on 15.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import Foundation

public struct ObtainedData: Codable {
    let content: [Content]?
    let first, last: Bool?
    let number, numberOfElements: Int?
    let pageable: Pageable?
    let size: Int?
    let sort: Sort?
    let totalElements, totalPages: Int?
}
