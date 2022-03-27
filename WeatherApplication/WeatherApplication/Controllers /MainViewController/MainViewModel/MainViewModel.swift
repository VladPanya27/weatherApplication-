//
//  ViewModelMainController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

import Foundation
import UIKit
import CoreLocation

class MainViewModel {
    
    let network = NetworkManager()
    
    var dailyWeatherModel:[Daily] = []
    
    var hourlyWeatherModel:[Current] = []
    
    var currentWeatherModel: Current?
    
    var weatherModel:WeatherModel?
    
    func loadDataWeather (lat: CLLocationDegrees, lon:CLLocationDegrees, completion: @escaping () -> Void?) {
        network.loadWeatherWithLatAndLon(lat: lat, lon: lon) { [weak self] weatherData  in
            if let weatherDailyData = weatherData?.daily {
                self?.dailyWeatherModel = weatherDailyData
                self?.dailyWeatherModel.removeLast(4)
                guard let weather = weatherData else {return}
                guard let currentWeather = weather.current else {return}
                self?.weatherModel = weather
                self?.currentWeatherModel = currentWeather
                guard let weatherHoutly = weatherData?.hourly else {return}
                self?.hourlyWeatherModel = weatherHoutly
                self?.hourlyWeatherModel.removeLast(24)
            }
            completion()
        }
    }
}
