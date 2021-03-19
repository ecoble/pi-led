//
//  WeatherViewController.swift
//  GLAM App
//
//  Created by Maddie Min on 3/13/21.
//

import Foundation
import SwiftUI
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherOutlineButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    var locationManager = CLLocationManager()
    var latitude: Double = 41.8781
    var longitude: Double = -87.6298
    var forecast: Forecast = Forecast()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backItem?.title = "Home"
        //self.navigationController!.navigationBar.tintColor = UIColor.black
        self.navigationItem.title = "LEDs"
        
        
        colorButton.layer.cornerRadius = 15.0
        weatherOutlineButton.layer.cornerRadius = 15.0
        weatherOutlineButton.layer.borderWidth = 0.5
        weatherOutlineButton.layer.borderColor = UIColor.label.cgColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if `switch`.isOn {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.requestAlwaysAuthorization()
            locationManager.startMonitoringSignificantLocationChanges()
        }
        let r = CGFloat(Double(UserDefaults.standard.string(forKey: "red") ?? "0") ?? 0)
        let g = CGFloat(Double(UserDefaults.standard.string(forKey: "green") ?? "0") ?? 0)
        let b = CGFloat(Double(UserDefaults.standard.string(forKey: "blue") ?? "0") ?? 0)
        let a = CGFloat(Double(UserDefaults.standard.string(forKey: "alpha") ?? "0") ?? 0)
        colorButton.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: a)
        
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        if `switch`.isOn {
            self.forecast = Services.getWeather(latitude: self.latitude, longitude: self.longitude)
            determineLightColor(temp: self.forecast.main.temp)
            updateWeatherDisplay(temp: Int(self.forecast.main.temp), description: self.forecast.weather[0].description, humidity: self.forecast.main.humidity)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if `switch`.isOn {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            self.latitude = locValue.latitude
            self.longitude = locValue.longitude
            self.forecast = Services.getWeather(latitude: self.latitude, longitude: self.longitude)
            determineLightColor(temp: self.forecast.main.temp)
            updateWeatherDisplay(temp: Int(self.forecast.main.temp), description: self.forecast.weather[0].description, humidity: self.forecast.main.humidity)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    func determineLightColor(temp: Double) {
        
        var color = UIColor.systemTeal
        if temp <= 32 {
            color = UIColor.systemBlue
        }
        else if temp <= 45 {
            color = UIColor.systemGreen
        }
        else if temp <= 65 {
            color = UIColor.systemYellow
        }
        else if temp <= 75 {
            color = UIColor.systemOrange
        }
        else {
            color = UIColor.systemRed
        }
        
        let components = color.cgColor.components
        let red = abs(Int((components?[0] ?? 0) * 255.0))
        let green = abs(Int((components?[1] ?? 0) * 255.0))
        let blue = abs(Int((components?[2] ?? 0) * 255.0))
        let alpha = abs(Int((components?[3] ?? 0) * 255.0))
        
        let defaults = UserDefaults.standard
        defaults.set(red, forKey: "red")
        defaults.set(green, forKey: "green")
        defaults.set(blue, forKey: "blue")
        defaults.set(alpha, forKey: "alpha")
        
        colorButton.backgroundColor = color
        Services.setColor(red: Int(red), green: Int(green), blue: Int(blue))
    }
    
    func updateWeatherDisplay(temp: Int, description: String, humidity: Int) {
        
        tempLabel.text = String(temp) + " ºF"
        conditionLabel.text = description
        precipLabel.text = String(humidity)
        
    }
}
