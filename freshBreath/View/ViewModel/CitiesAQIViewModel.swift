//
//  CitiesAQIViewModel.swift
//  freshBreath
//
//  Created by Shashank Pali on 12/02/22.
//

import Foundation

class CitiesAQIViewModel {
    
    var citiesAQI = [CityModel]()
    
    func requestForData() {
        WebSocket.shared.connect()
        WebSocket.shared.delegate = self
    }
    
}

extension CitiesAQIViewModel: WebSocketDelegate {
    func didReceive(response: String) {
        guard let data = response.data(using: .utf8) else { return }
        do {
            let responseArray = try JSONDecoder().decode([AQIModel].self, from: data)
            prepareCityModel(responseArray)
        } catch {
            print(error)
        }
    }
}

extension CitiesAQIViewModel {
    
    private func prepareCityModel(_ res: [AQIModel]) {
        
        for model in res {
            let record = AQICityRecord(model)
            
            if let cityModel = citiesAQI.first(where: {$0.name == model.city}) {
                cityModel.update(record: record)
            }else {
                let newCityModel = CityModel(model.city, record: record)
                citiesAQI += [newCityModel]
            }
        }
        
        print(citiesAQI)
    }
}
