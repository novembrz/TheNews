//
//  FetchDataService.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import Foundation

class FetchDataService: FetchDataProtocol {
    
    let networkService: NetworkingProtocol!
    
    init(_ networkService: NetworkService){
        self.networkService = networkService
    }
    
    func fetchData(urlString: String, completion: @escaping (Data?) -> ()) {
        
        networkService.getCurrentData(urlString: urlString) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            completion(data)
        }
    }
}
