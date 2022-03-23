//
//  NetworkManager.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

import Foundation
import UIKit
import CoreLocation
import Alamofire

enum СomponentsOfTheRequest {
    
    case baseUrl, path, lat, lon, keyApi
   
    var component: String {
        switch self {
        case .baseUrl: return "https://api.openweathermap.org"
        case .path: return "/data/2.5/onecall?"
        case .lat: return "lat="
        case .lon: return "&lon="
        case .keyApi: return "&appid=6890632eadfe8b1a00cae24970811d87"
        }
    }
}

class NetworkManager {
    
    func loadWeatherWithLatAndLon(lat: CLLocationDegrees, lon:CLLocationDegrees, completion: @escaping (WeatherModel?) -> Void ) {
        
        let request = СomponentsOfTheRequest.baseUrl.component + СomponentsOfTheRequest.path.component + СomponentsOfTheRequest.lat.component + "\(lat)" + СomponentsOfTheRequest.lon.component + "\(lon)" + СomponentsOfTheRequest.keyApi.component
        
        print(request)
        AF.request(request).responseJSON { data in
            print(data)
        }
        AF.request(request) .validate()
           .responseDecodable(of:WeatherModel.self) { weather in
            guard weather.error == nil else { return print(weather.error) }
            if let data = weather.value {
                        completion(data)
            }
        }
    }
}

