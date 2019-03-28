//
//  Content.swift
//  Blog
//
//  Created by 1 on 20.03.19.
//  Copyright © 2019 Bogdan Magala. All rights reserved.
//

import Foundation

public struct Content: Codable {
    let id: Int?
    let name, shortName: String?
    let privateAccess: Bool?
    let created, updated: Int?
}
