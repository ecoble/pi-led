//
//  Services.swift
//  GLAM App
//
//  Created by Maddie Min on 3/14/21.
//

import Foundation

class Services {
    
    class func getWeather(latitude: Double, longitude: Double) -> Forecast {
        
        var currForecast = Forecast()
        let parameters = [URLQueryItem(name: "lat", value: String(latitude)), URLQueryItem(name: "lon", value: String(longitude)), URLQueryItem(name: "units", value: "imperial"), URLQueryItem(name: "appid", value: "07025b35ccd6fa29ae5368d7fb7c854c")]
        let request = RequestModel(method: .get, path: "https://api.openweathermap.org/data/2.5/weather", parameters: parameters)
        HTTPManager().sendRequest(Forecast.self, with: request) { (response, error) in
            if let forecast = response {
                currForecast = forecast
            }
        }
        return currForecast
    }
    
    class func setColor(red: Int, green: Int, blue: Int) -> () {
        let parameters : [String: Any] = ["red": red, "green": green, "blue": blue]
        let request = RequestModel(method: .post, path: "http://73.36.172.212:8080/color", bodyParameters: parameters)
        HTTPManager().postRequest(with: request) { (response, error) in
            if error != nil {
                print("Error: " + (error?.localizedDescription ?? "Could not retrieve error details"))
            } else {
                print("Color set.")
            }
        }
    }
    
    class func power() {
        let request = RequestModel(method: .get, path: "http://73.36.172.212:8080/power", bodyParameters: nil)
        HTTPManager().postRequest(with: request) { (response, error) in
            if error != nil {
                print("Error: " + (error?.localizedDescription ?? "Could not retrieve error details"))
            } else {
                print("Power switched.")
            }
        }
    }
    
    class func changePattern(pattern: String) {
        //pattern: auto, flash, jump3, fade3, fade7, jump7, red
        let baseUrl = "http://73.36.172.212:8080/"
        let pathUrl = baseUrl.appending(pattern)
        let request = RequestModel(method: .get, path: pathUrl, bodyParameters: nil)
        HTTPManager().postRequest(with: request) { (response, error) in
            if error != nil {
                print("Error: " + (error?.localizedDescription ?? "Could not retrieve error details"))
            } else {
                print("Pattern changed to " + pattern + ".")
            }
        }
    }
    
    
    
}
