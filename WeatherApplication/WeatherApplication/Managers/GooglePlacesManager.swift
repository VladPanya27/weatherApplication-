//
//  GooglePlacesManager.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 23.03.2022.
//

import Foundation
import GooglePlaces
import CoreLocation

class GooglePlacesManager {
    
    static let shared = GooglePlacesManager()
    
    private let client = GMSPlacesClient.shared()
    
    private init() {}
    
    func findPlaces(query:String, completion: @escaping (Result<[PlaceModel], Error>) -> Void) {
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        
        client.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil) { result, error in
            guard let result = result, error == nil else {
                completion(.failure(PlaceError.failedToFind))
                return
            }
            let places:[PlaceModel] = result.compactMap { PlaceModel(name: $0.attributedFullText.string, identifire: $0.placeID)
            }
            completion(.success(places))
        }
    }
    
    func resolveLocation(for plase: PlaceModel, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        client.fetchPlace(fromPlaceID: plase.identifire, placeFields: .coordinate, sessionToken: nil) { googlePlace, error in
            guard let googlePlace = googlePlace?.coordinate, error == nil else {return}
            let coordinate = CLLocationCoordinate2D(latitude: googlePlace.latitude, longitude: googlePlace.longitude)
            completion(.success(coordinate))
        }
    }
}
