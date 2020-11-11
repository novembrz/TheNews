//
//  NetworkService.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import Foundation

class NetworkService: NetworkingProtocol {
    
    func getCurrentData(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else {return}
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {return}
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
    
}
