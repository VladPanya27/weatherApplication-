//
//  MapViewController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 22.03.2022.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    var completion:((CLLocationCoordinate2D) -> Void)?
    
    private var currentCoordinate:CLLocationCoordinate2D!
    
    private var map: GMSMapView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocation()
        prepareMap()
        map.delegate = self
    }
    
    private func prepareMap() {
        guard let coordinate = locationManager.location?.coordinate else {return}
        currentCoordinate = coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 15.0)
        self.map = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.mapView.addSubview(map)
        reverseGeocode()
        addMarker(coordinate: currentCoordinate)
    }
    
    private func reverseGeocode() {
        let geocoder = GMSGeocoder.init()
        geocoder.reverseGeocodeCoordinate(currentCoordinate) { [weak self] response, error in
            if (error != nil) {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            if let parsed = response?.firstResult() {
                var addressString = ""
                if parsed.subLocality != nil {
                    addressString = addressString + parsed.subLocality! + ", "
                }
                if parsed.thoroughfare != nil {
                    addressString = addressString + parsed.thoroughfare! + ", "
                }
                if parsed.locality != nil {
                    addressString = addressString + parsed.locality! + ", "
                }
                if parsed.country != nil {
                    addressString = addressString + parsed.country! + ", "
                }
                if parsed.postalCode != nil {
                    addressString = addressString + parsed.postalCode! + " "
                }
                self?.label.text = addressString
            }
        }
    }
    
    @IBAction func selectAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        completion?(currentCoordinate)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
   private func requestLocation() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension MapViewController: GMSMapViewDelegate {
    
   private func addMarker(coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = coordinate
        marker.map = map
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        map.clear()
        addMarker(coordinate: coordinate)
        self.currentCoordinate = coordinate
        reverseGeocode()
    }
}
