//
//  MapMarker.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 04.04.2022.
//

import UIKit
import CoreLocation

protocol MapMarker: AnyObject
{
    var markerCoordinate: CLLocationCoordinate2D { get set }
    var markerTitle: String { get set }
    var markerColour: UIColor { get set }
    var markerClusterTitle: String { get set }
    var markerClusterColour: UIColor { get set }
    var markerClusterCount: Int { get set }
    
    var markerHashValue: Int { get }
    func isEqualToMarker(_ v: MapMarker) -> Bool
}
