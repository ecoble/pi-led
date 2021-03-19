//
//  Response.swift
//  GLAM App
//
//  Created by Maddie Min on 3/14/21.
//

import Foundation

struct Response<T: Codable>: Codable {
    var code: Int
    var status: Bool
    var message: String?
    var data : T?
}
