//
//  SearchViewController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 23.03.2022.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchVC = UISearchController(searchResultsController: nil)
    
    var completion:((CLLocationCoordinate2D) -> Void)?
    
    var plasec:[PlaceModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        settingSearchBar()
        view.backgroundColor = UIColor.weatherBlue
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func settingSearchBar() {
        searchVC.searchResultsUpdater = self
        searchVC.obscuresBackgroundDuringPresentation = false
        navigationItem.titleView = searchVC.searchBar
        definesPresentationContext = true
        navigationController?.navigationBar.isTranslucent = false
        searchVC.hidesNavigationBarDuringPresentation = false
        searchVC.searchBar.backgroundColor = UIColor.weatherBlue
        searchVC.searchBar.searchTextField.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func update(with places: [PlaceModel]) {
        self.plasec = places
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plasec.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = plasec[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let place = plasec[indexPath.row]
        
        GooglePlacesManager.shared.resolveLocation(for: place) { [weak self] result in
            switch result {
            case .success(let coordinate):
                DispatchQueue.main.async {
                    self?.completion?(coordinate)
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let place):
                DispatchQueue.main.async {
                    self.update(with: place)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}


