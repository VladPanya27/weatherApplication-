//
//  CompassDirection.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 21.03.2022.
//

import Foundation

class Compass {
    
    static func direction(for heading: Double) -> String? {
        if heading < 0 { return nil }

        let directions = ["↓", "↙", "←", "↖", "↑", "↗", "→", "↘"]
        let index = Int((heading + 22.5) / 45.0) & 7
        return directions[index]
    }
}
