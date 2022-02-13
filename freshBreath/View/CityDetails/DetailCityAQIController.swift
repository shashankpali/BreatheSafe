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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let model = cityModel else {return}
        cityView.prepare(forModel: model)
        
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) {[unowned self] (timer) in
            guard let records = cityModel?.records else {return}
            let max = records.max{$0.aqi > $1.aqi}!
            var arr = [DataEntry]()
            for rec in records {
                let val = Float(rec.aqi / max.aqi) / 1.5
                arr += [DataEntry(color: UIColor.forStatus(rec.status), height: val, textValue: rec.aqiString, title: String.forTime(rec.time))]
            }
            chartView.updateDataEntries(dataEntries: arr, animated: true)
        }
        timer.fire()
    }

    @IBAction func hideTapped(_ sender: UIButton) {
        timer.invalidate()
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
