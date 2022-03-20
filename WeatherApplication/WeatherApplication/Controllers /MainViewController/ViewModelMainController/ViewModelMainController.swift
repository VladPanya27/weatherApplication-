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

    var dailyWeatherModel:[Daily] = []
    
    let network = NetworkManager()
    
    var current: Current?
    
    var weatherModel:WeatherModel?
    
    var hourly = [Current]()
    
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
                guard ((self?.hourly = weatherData!.hourly) != nil) else {return}
            }
            completion()
        }
    }
}
