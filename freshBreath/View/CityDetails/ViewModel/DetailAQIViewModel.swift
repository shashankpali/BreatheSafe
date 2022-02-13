//
//  DetailAQIViewModel.swift
//  freshBreath
//
//  Created by Shashank Pali on 14/02/22.
//

import UIKit

protocol DetailAQIViewModelDelegate {
    func didUpdatedChart(model: CityModel, data: [DataEntry])
}

final class DetailAQIViewModel {
    
    var cityModel: CityModel?
    var timer = Timer()
    var delegate : DetailAQIViewModelDelegate?
    
    func build(forModel: CityModel?) {
        
        cityModel = forModel
        
        guard cityModel != nil else {return}
        var time = 0
        var arr = loadHistory()
        
        timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) {[unowned self] (timer) in
            guard let records = cityModel?.records else {return}
            
            let max = records.max{$0.aqi > $1.aqi}!
            
            let rec = records.last!
            let val = Float(rec.aqi / max.aqi) / 1.5
            arr += [DataEntry(color: UIColor.forStatus(rec.status), height: val, textValue: rec.aqiString, title: String.asMinAndSec(Date()))]
            time += 3
            
            delegate?.didUpdatedChart(model: cityModel!, data: arr)
        }
        timer.fire()
    }
    
    private func loadHistory() -> [DataEntry] {
        guard let records = cityModel?.records else {return []}
        var arr = [DataEntry]()
        let max = records.max{$0.aqi > $1.aqi}!
        for rec in records {
            let val = Float(rec.aqi / max.aqi) / 1.5
            arr += [DataEntry(color: UIColor.forStatus(rec.status), height: val, textValue: rec.aqiString, title: String.asMinAndSec(rec.time))]
        }
        return arr
    }
    
}
