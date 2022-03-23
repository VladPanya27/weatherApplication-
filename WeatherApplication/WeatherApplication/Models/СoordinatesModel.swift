//
//  СoordinatesModel.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 22.03.2022.
//

import Foundation
import CoreLocation

class СoordinatesModel {
    var lon: CLLocationDegrees
    var lat:CLLocationDegrees
    
    init(lon:CLLocationDegrees, lan:CLLocationDegrees) {
        self.lon = lon
        self.lat = lan
    }
}
