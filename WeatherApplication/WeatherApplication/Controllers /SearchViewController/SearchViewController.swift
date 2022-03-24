//
//  SearchViewController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 23.03.2022.
//

import UIKit
import GooglePlaces

class SearchViewController: UIViewController, UISearchResultsUpdating {

    let searchVC = UISearchController(searchResultsController: ResultViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingSearchBar()
    }
    
    func settingSearchBar() {
           searchVC.searchBar.backgroundColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
           searchVC.searchBar.tintColor = .white
           searchVC.searchResultsUpdater = self
           navigationItem.titleView = searchVC.searchBar
           searchVC.hidesNavigationBarDuringPresentation = false
           searchVC.automaticallyShowsSearchResultsController = false
           searchVC.searchBar.searchTextField.backgroundColor = .white
           self.navigationController?.navigationBar.tintColor = UIColor.white
           self.navigationController?.navigationBar.topItem?.title = ""
       }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let place):
                print(place)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
