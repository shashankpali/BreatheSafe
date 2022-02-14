//
//  DetailCityAQIController.swift
//  freshBreath
//
//  Created by Shashank Pali on 13/02/22.
//

import UIKit

final class DetailCityAQIController: UIViewController {
    
    @IBOutlet weak var cityView: AQIView!
    @IBOutlet weak var chartView: BasicBarChart!
    //
    var cityModel: CityModel?
    var timer = Timer()
    let viewModel = DetailAQIViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.build(forModel: cityModel)
    }
    
    @IBAction func hideTapped(_ sender: UIButton) {
        timer.invalidate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func timerSelected(_ sender: UISegmentedControl) {
        viewModel.getUpdate(inSeconds: [0 : 5.0, 1 : 30.0, 2 : 60.0][sender.selectedSegmentIndex], fromUI: true)
    }
}

extension DetailCityAQIController: DetailAQIViewModelDelegate {
    func didUpdatedChart(model: CityModel, data: [DataEntry]) {
        cityView.prepare(forModel: model)
        chartView.updateDataEntries(dataEntries: data, animated: true, scrollToNew: true)
    }
}
