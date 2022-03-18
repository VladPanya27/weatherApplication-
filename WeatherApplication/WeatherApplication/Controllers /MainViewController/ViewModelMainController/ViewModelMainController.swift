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

    var weatherModel:[WeatherModel] = []
    
    let network = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadDataWeather (with lat: CLLocationDegrees, with lon:CLLocationDegrees, completion: @escaping (Error?) -> Void) {
        network.loadWeatherLatAndLon(with: lat, with: lon) { [weak self] weatherData, weatherDataError  in
            if let completData = weatherData {
                self?.weatherModel.append(completData)
                completion(nil)
            } else {
                completion(weatherDataError)
            }
        }
    }
}
