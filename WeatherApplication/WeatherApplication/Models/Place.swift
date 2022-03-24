//
//  Place.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 23.03.2022.
//

import Foundation

struct Place {
    let name: String
    let identifire: String
}

enum PlaceError:Error {
    case failedToFind
}
