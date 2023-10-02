//
//  BrandsError.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import Foundation

struct BrandsStatus: Decodable {
    let status: BrandsError
}

struct BrandsError: Decodable {
    let errorCode: Int
    let errorMessage: String
    
    enum BrandsKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}
