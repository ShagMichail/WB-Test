//
//  HomeViewModel.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import Foundation

final class HomeControllerViewModel {
    
    var onBrandsUpdated: (()->Void)?
    var onErrorMessage: ((APIManagerError)->Void)?
    
    var servise = APIManager()
    var dataStore: BrandsDataStore = HomeViewDataStore.shared
    
    private(set) var brands: [(Brand, Bool)] = [] {
        didSet {
            dataStore.brands = brands
            self.onBrandsUpdated?()
        }
    }
    
    let urlString = "https://vmeste.wildberries.ru/api/guide-service/v1/getBrands"
    
    init() {
        self.fetchBrands()
    }
    
    public func fetchBrands() {
        
        servise.fetchBrands(url: urlString) { [weak self] result in
            switch result {
            case .success(let brands):
                self?.brands = []
                for i in brands {
                    self?.brands.append((i,false))
                }
                print("DEBUG PRINT:", "\(brands.count) brands fetched.")
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
        
    }
}
