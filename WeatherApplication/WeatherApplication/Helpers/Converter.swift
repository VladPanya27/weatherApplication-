//
//  Converter.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 25.03.2022.
//

import Foundation

class Converter {
    static func fahrenheitToCelsius(with min: Double, with max: Double) -> String {
        let convert = "\(Int(((min)) - 273.15))°/ \(Int(((max)) - 273.15))°"
        
        return convert
    }
    
}
