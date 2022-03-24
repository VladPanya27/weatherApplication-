//
//  GooglePalcesManager.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 23.03.2022.
//

import Foundation
import GooglePlaces

class GooglePlacesManager {
    
    static let shared = GooglePlacesManager()
    
    private let client = GMSPlacesClient.shared()
    
    let token = GMSAutocompleteSessionToken.init()

    
    private init() {}
    
    func findPlaces(query:String, completion: @escaping (Result<[Place], Error>) -> Void) {
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        
        client.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: token) { result, error in
            guard let result = result, error == nil else {
                completion(.failure(PlaceError.failedToFind))
                return
            print(error)
            }
            let places:[Place] = result.compactMap { Place(name: $0.attributedFullText.string, identifire: $0.placeID)
            }
            print(places)
            completion(.success(places))
        }
    }
    
}
