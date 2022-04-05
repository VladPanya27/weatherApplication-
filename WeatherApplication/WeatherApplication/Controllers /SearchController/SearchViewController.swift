//
//  SearchViewController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 23.03.2022.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let searchVC = UISearchController(searchResultsController: nil)
    
    var completion:((CLLocationCoordinate2D) -> Void)?
    
    private var places:[PlaceModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        settingSearchBar()
        view.backgroundColor = UIColor.weatherBlue
    }
    
   private func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlacesCell.nib(), forCellReuseIdentifier: PlacesCell.identifire)
    }
    
   private func settingSearchBar() {
        searchVC.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.navigationItem.titleView = searchVC.searchBar
        searchVC.hidesNavigationBarDuringPresentation = false
        self.navigationController?.navigationBar.topItem?.title = ""
        searchVC.searchBar.backgroundColor = UIColor.weatherBlue
        searchVC.searchBar.searchTextField.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .white
    }
    
   private func update(with places: [PlaceModel]) {
        self.places = places
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlacesCell.identifire, for: indexPath)
        cell.textLabel?.text = places[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        
        GooglePlacesManager.shared.resolveLocation(for: place) { [weak self] result in
            switch result {
            case .success(let coordinate):
                self?.completion?(coordinate)
                self?.navigationController?.popViewController(animated: false)
                self?.searchVC.isActive = false
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        
        GooglePlacesManager.shared.findPlaces(query: query) { [weak self] result in
            switch result {
            case .success(let place):
                DispatchQueue.main.async {
                    self?.update(with: place)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
