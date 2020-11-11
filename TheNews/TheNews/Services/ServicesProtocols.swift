//
//  ServicesProtocols.swift
//  TheNews
//
//  Created by Дарья on 11.11.2020.
//

import Foundation

protocol FetchDataProtocol {
    func fetchData(urlString: String, completion: @escaping (Data?) -> ())
}

protocol NetworkingProtocol {
    func getCurrentData(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}
