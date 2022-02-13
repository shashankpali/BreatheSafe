//
//  CitiesAIQController.swift
//  freshBreath
//
//  Created by Shashank Pali on 12/02/22.
//

import UIKit

class CitiesAQIController: UITableViewController {
    
    let viewModel = CitiesAQIViewModel()
    var dataSource = [CityModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        setupTable()
        setupModel()
    }
    
    func setupModel() {
        viewModel.delegate = self
        viewModel.requestForData()
    }
    
    func setupTable() {
        tableView.register(UINib(nibName: "CityAQICell", bundle: nil), forCellReuseIdentifier: "CityAQICell")
        tableView.rowHeight = 148
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityAQICell", for: indexPath) as! CityAQICell
        cell.prepare(forModel: dataSource[indexPath.row])

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailCityAQIController(nibName: "DetailCityAQIController", bundle: nil)
        detail.cityModel = dataSource[indexPath.row]
        detail.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present( detail, animated: true, completion: nil)
    }

}

extension CitiesAQIController: CitiesAQIViewModelDelegate {
    func didUpdated(citiesAQI: [CityModel]) {
        dataSource = citiesAQI
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
