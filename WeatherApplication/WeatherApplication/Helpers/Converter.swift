//
//  Converter.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 25.03.2022.
//

import Foundation

class Converter {
    
    static func fahrenheitToCelsius(with model: Daily) -> String? {
        let convert = "\(Int((((model.temp?.min)!)) - 273.15))°/ \(Int(((model.temp?.max)!) - 273.15))°"
        
        return convert
    }
    
}
