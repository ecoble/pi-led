//
//  HTTPManager.swift
//  GLAM App
//
//  Created by Maddie Min on 3/14/21.
//

import Foundation

class HTTPManager {

    private let decoder: JSONDecoder

    public init(_ decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    public func sendRequest<T: Decodable>(_ objectType: T.Type,
                                      with requestModel: RequestModel,
                                      completion: @escaping  (T?, Error?) -> Void)  {

        let request = requestModel.buildRequest()
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(error!)
                return
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(response, nil)
            }
            catch {
                print(error)
                completion(nil, error)
            }
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
    }
    
    public func postRequest(with requestModel: RequestModel,
                                      completion: @escaping  (HTTPURLResponse?, Error?) -> Void)  {

        let request = requestModel.buildRequest()
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil && data != nil else {
                print(error!)
                return
            }
            let response = response as? HTTPURLResponse
            completion(response, nil)
    
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
    }
}
