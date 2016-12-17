//
//  dataModel.swift
//  weather
//
//  Created by Dadanov Alexey on 17.12.16.
//  Copyright © 2016 Dadanov Alexey. All rights reserved.
//

import UIKit
import Alamofire

class dataModel {

    private var _date: Double?
    private var _temp: String?
    private var _location: String?
    private var _weather: String?
    typealias JSONStandard = Dictionary<String, AnyObject>
    
    let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Vladimir&units=metric&APPID=3285a0552ad9c2f93e32bcaf0485b48d")!
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let date = Date(timeIntervalSince1970: _date!)
        return (_date != nil) ? "Today, \(dateFormatter.string(from: date))" : "Date Invalid"
    }
    
    var temp: String {
        return _temp ?? "0 °C"
    }
    
    var location: String {
        return _location ?? "Location Invalid"
    }
    
    var weather: String {
        return _weather ?? "Weather Invalid"
    }

    func downloadData(completed: @escaping ()-> ()) {
        
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            let result = response.result
            print(response)
            if let dict = result.value as? JSONStandard,
                let main = dict["main"] as? JSONStandard,
                let temp = main["temp"] as? Double,
                let weatherArray = dict["weather"] as? [JSONStandard],
                let weather = weatherArray[0]["main"] as? String,
                let name = dict["name"] as? String,
                let sys = dict["sys"] as? JSONStandard,
                let country = sys["country"] as? String,
                let dt = dict["dt"] as? Double {
                
                self._temp = String(format: "%.0f °C", temp)
                self._weather = weather
                self._location = "\(name), \(country)"
                self._date = dt
                print()
            }
            
            completed()
        })
    }

    
}



