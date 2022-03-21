//
//  ViewModelMainController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

import Foundation
import UIKit
import CoreLocation

class ViewModelMainController: UIViewController {

    let network = NetworkManager()
    
    var dailyWeatherModel:[Daily] = []
        
    var hourly:[Current] = []
    
    var current: Current?
    
    var weatherModel:WeatherModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadDataWeather (lat: CLLocationDegrees, lon:CLLocationDegrees, completion: @escaping () -> Void?) {
        network.loadWeatherWithLatAndLon(lat: lat, lon: lon) { [weak self] weatherData  in
            if let completData = weatherData?.daily {
                self?.dailyWeatherModel.append(contentsOf: completData)
                guard let currentWeather = weatherData?.current else {return}
                self?.weatherModel = weatherData
                self?.current = currentWeather
                guard let weatherHoutly = weatherData?.hourly else {return}
                self?.hourly = weatherHoutly 
            }
            completion()
        }
    }
}
