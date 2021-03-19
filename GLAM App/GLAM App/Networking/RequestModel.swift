//
//  RequestModel.swift
//  GLAM App
//
//  Created by Maddie Min on 3/14/21.
//

import Foundation

struct RequestModel {
    let method: HTTPMethod
    var path: String?
    var parameters: [URLQueryItem]? = []
    var bodyParameters: [String: Any?]? = [:]
    var headers: [HTTPHeader]? = []
    
    func buildRequest() -> URLRequest {
        
        let baseUrl = "" // BASE URL
        let endpoint: String = baseUrl.appending(self.path ?? "")
        var url = URL(string: endpoint)!
        if method == .get {
            var urlComps = URLComponents(string: endpoint)!
            urlComps.queryItems = parameters
            url = urlComps.url!
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
 
        if method == .post {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters ?? [], options: .prettyPrinted)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
        
    }

}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case options = "OPTIONS"
    case trace = "TRACE"
    case connect = "CONNECT"
}

struct HTTPHeader {
    let field: String
    let value: String
}

