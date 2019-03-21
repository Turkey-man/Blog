//
//  Pageable.swift
//  Blog
//
//  Created by 1 on 20.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import Foundation

public struct Pageable: Codable {
    let offset, pageNumber, pageSize: Int
    let paged: Bool
    let sort: Sort
    let unpaged: Bool
}
