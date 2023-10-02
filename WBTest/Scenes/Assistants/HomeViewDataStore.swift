//
//  BrandsDataStore.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit

protocol BrandsDataStore: AnyObject {
    var brands: [(Brand, Bool)] { get set }
}

final class HomeViewDataStore: BrandsDataStore {
    
    var brands: [(Brand, Bool)] = []
    
    static let shared = HomeViewDataStore()
    
    init() {}
    
}
