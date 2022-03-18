//
//  NetworkManager.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

import Foundation
import UIKit
import Alamofire
import CoreLocation

enum СomponentsOfTheRequest {
    
    case baseUrl, componentPath, lat, lon, keyApi
    
    var component: String {
        switch self {
        case .baseUrl: return "https://api.openweathermap.org"
        case .componentPath: return "/data/2.5/weather?"
        case .lat: return "lat="
        case .lon: return "&lon="
        case .keyApi: return "&appid=6890632eadfe8b1a00cae24970811d87"
        }
    }
}

class NetworkManager {
    
    func loadWeatherLatAndLon(lat: CLLocationDegrees, lon:CLLocationDegrees, completion: @escaping (WeatherModel?, Error?) -> Void ) {
        
        let request = СomponentsOfTheRequest.baseUrl.component + СomponentsOfTheRequest.componentPath.component + СomponentsOfTheRequest.lat.component + "\(lat)" + СomponentsOfTheRequest.lon.component + "\(lon)" + СomponentsOfTheRequest.keyApi.component
    
        AF.request(request) .validate()
            .responseDecodable(of:WeatherModel.self) { weather in
                if let error = weather.error {
                    completion(nil, error)
                } else if let data = weather.value {
                    completion(data, nil)
            }
        }
    }
}
