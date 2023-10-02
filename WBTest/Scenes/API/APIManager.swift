//
//  ApiManager.swift
//  WBTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import Foundation

enum APIManagerError: Error {
    case serverError(BrandsError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsing server response.")
}

final class APIManager {

    func fetchBrands(url: String, completion: @escaping (Result<[Brand], APIManagerError>)->Void) {
        
        let url = URL(string: url)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Error")
                completion(.failure(.unknown(error!.localizedDescription)))
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("status cod: \((String(describing: httpResponse?.statusCode)))")
                
                guard let saveData = data else {return}
                
                if let decodedQuery = try? JSONDecoder().decode(Query.self, from: saveData) {
                    completion(.success(decodedQuery.brands))
                }
            }
        }.resume()
    }
}
