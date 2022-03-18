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
    
    func loadDataWeather (lat: CLLocationDegrees, lon:CLLocationDegrees, completion: @escaping () -> Void?) {
        network.loadWeatherWithLatAndLon(lat: lat, lon: lon) { [weak self] weatherData  in
            if let completData = weatherData {
                self?.weatherModel.append(completData)
            }
            completion()
        }
    }
}
