//
//  CitiesAIQController.swift
//  freshBreath
//
//  Created by Shashank Pali on 12/02/22.
//

import UIKit


final class CitiesAQIController: UITableViewController, UISearchResultsUpdating {
    
    let viewModel = CitiesAQIViewModel()
    var citiesModel = [CityModel]()
    var dataSource = [CityModel]()
    var searchText : String?
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Looking for specific city..."
        
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        setupSearch()
        setupTable()
        setupModel()
    }
    
    private func setupSearch() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func setupTable() {
        tableView.register(UINib(nibName: "CityAQICell", bundle: nil), forCellReuseIdentifier: "CityAQICell")
        tableView.rowHeight = 156
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    private func setupModel() {
        viewModel.delegate = self
        viewModel.requestForData()
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

    // MARK: - Search Results Updating
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.count != 0 {
            searchText = searchController.searchBar.text ?? ""
            reloadTable()
        }else {
            searchText = nil
            reloadTable()
        }
        
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    private func reloadTable() {
        if let text = searchText {
            dataSource = citiesModel.filter{$0.name.contains(text)}
        }else {
            dataSource = citiesModel
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension CitiesAQIController: CitiesAQIViewModelDelegate {
    func didUpdated(citiesAQI: [CityModel]) {
        citiesModel = citiesAQI
        reloadTable()
    }
}
