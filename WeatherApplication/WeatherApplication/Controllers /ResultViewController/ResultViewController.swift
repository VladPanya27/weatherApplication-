//
//  ResultViewController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 23.03.2022.
//

import UIKit
import CoreLocation

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var plasec:[Place] = []
    
    var completion:((CLLocationCoordinate2D) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        view.backgroundColor = .red
    }

    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func update(with places: [Place]) {
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
        GooglePlacesManager.shared.resolveLocation(for: place) { result in
            switch result {
                
            case .success(let coordinate):
                self.completion?(coordinate)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
