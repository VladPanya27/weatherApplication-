//
//  MainViewController.swift
//  WeatherApplication
//
//  Created by Vlad Panchenko on 18.03.2022.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModelMainController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    }
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HourlyCell.nib(), forCellReuseIdentifier: HourlyCell.identifire)
        tableView.register(WeatherCell.nib(), forCellReuseIdentifier: WeatherCell.identifire)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
