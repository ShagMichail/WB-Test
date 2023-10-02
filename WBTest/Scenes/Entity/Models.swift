//
//  Brands.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import Foundation

struct Brand: Decodable {

    let brandId: String
    let title: String
    let thumbUrls: [String]
    let tagIds: [String]
    let slug: String
    let type: String
    let viewsCount: Int
}

struct Query: Decodable {
    let brands: [Brand]
}
