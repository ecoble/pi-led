//
//  Forecast.swift
//  GLAM App
//
//  Created by Maddie Min on 3/14/21.
//

import Foundation

struct Forecast: Codable {
    
    let weather: [Weather]
    let main: Main
    
    init() {
        self.weather = [Weather]()
        self.main = Main()
    }
}

struct Weather: Codable {
    
    let main: String
    let description: String
    
    init(main: String = "", description: String = "") {
        self.main = main
        self.description = description
    }
    
}

struct Main: Codable {
    
    let temp: Double
    let feels_like: Double
    let humidity: Int
    
    init(temp: Double = 50, feels_like: Double = 50, humidity: Int = 30) {
        self.temp = temp
        self.feels_like = feels_like
        self.humidity = humidity
    }
    
}
