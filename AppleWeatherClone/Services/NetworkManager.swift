//
//  NetworkManager.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 15.07.2024.
//

import Foundation
import Alamofire

class NetworkManager<T: Decodable> {
    
    private let baseURL: String
    private let apiKey: String
    private let endpoint: String
    private let parameters: [String: String]
    
    init(baseURL: String, apiKey: String, endPoint: String, parameters: [String: String]) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.endpoint = endPoint
        self.parameters = parameters
    }
    
    func fetchData(completion: @escaping (Result<T, Error>) -> Void) {
        
        let fullPath = baseURL + endpoint
        
        AF.request(fullPath, parameters: parameters).responseDecodable(of: T.self) { response in
            
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
