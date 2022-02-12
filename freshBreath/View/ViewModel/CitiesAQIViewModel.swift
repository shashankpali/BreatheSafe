//
//  CitiesAQIViewModel.swift
//  freshBreath
//
//  Created by Shashank Pali on 12/02/22.
//

import Foundation

protocol CitiesAQIViewModelDelegate {
    func didUpdated(citiesAQI: [CityModel])
}

class CitiesAQIViewModel {
    
    var citiesAQI = [CityModel]()
    var delegate : CitiesAQIViewModelDelegate?
    
    func requestForData() {
        WebSocket.shared.connection(urlString: "ws://city-ws.herokuapp.com/")
        WebSocket.shared.delegate = self
    }
    
}

extension CitiesAQIViewModel: WebSocketDelegate {
    func didReceive(response: String) {
        guard let data = response.data(using: .utf8) else { return }
        do {
            let responseArray = try JSONDecoder().decode([AQIModel].self, from: data)
            prepareCitiesAQI(responseArray)
        } catch {
            print(error)
        }
    }
}

extension CitiesAQIViewModel {
    
    private func prepareCitiesAQI(_ res: [AQIModel]) {
        
        for model in res {
            let record = AQICityRecord(model)
            
            if let cityModel = citiesAQI.first(where: {$0.name == model.city}) {
                cityModel.update(record: record)
            }else {
                let newCityModel = CityModel(model.city, record: record)
                citiesAQI += [newCityModel]
            }
        }
        
        delegate?.didUpdated(citiesAQI: Array(citiesAQI.sorted{$0.name < $1.name}))
    }
}
