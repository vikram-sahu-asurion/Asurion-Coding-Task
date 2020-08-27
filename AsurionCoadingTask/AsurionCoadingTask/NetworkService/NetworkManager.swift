//
//  NetworkManager.swift
//  AsurionCoadingTask
//
//  Created by Sahu, Vikram on 25/08/20.
//  Copyright © 2020 Sahu, Vikram. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    func fetchConfig(completion: @escaping ConfigResponseCompletion<ConfigModel>) {
        let url = URL(string:"https://raw.githubusercontent.com/vikram-sahu-asurion/HostJson/master/config.json")
        
        let task =  URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            // Check for Internet Connection
            if let err = error as NSError?, err.domain == NSURLErrorDomain, err.code == NSURLErrorNotConnectedToInternet {
                completion(.failure(error: ServiceError(type: .NoInternet, message: err.localizedDescription)))
                return
            }
            
            guard let data = data else{
                completion(.failure(error: ServiceError(type: .notFound)))
                return
            }
            
            let decoder = JSONDecoder()
            if let json = try? decoder.decode(ConfigModel.self, from: data){
                completion(.success(domainModel: json))
            }else{
                completion(.failure(error: ServiceError(type: .decodingError)))
            }
            
        }
        
        task.resume()
    }
    
    func fetchPetsData(completion: @escaping PetsResponseCompletion<PetsModel>) {
        let url = URL(string:"https://raw.githubusercontent.com/vikram-sahu-asurion/HostJson/master/pets.json")
        
        let task =  URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            // Check for Internet Connection
            if let err = error as NSError?, err.domain == NSURLErrorDomain, err.code == NSURLErrorNotConnectedToInternet {
                completion(.failure(error: ServiceError(type: .NoInternet, message: err.localizedDescription)))
                return
            }
            
            guard let data = data else{
                completion(.failure(error: ServiceError(type: .notFound)))
                return
            }
            
            let decoder = JSONDecoder()
            if let json = try? decoder.decode(PetsModel.self, from: data){
                completion(.success(domainModel: json))
            }else{
                completion(.failure(error: ServiceError(type: .decodingError)))
            }
        }

        task.resume()
    }

}
