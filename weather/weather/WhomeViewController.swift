//
//  WhomeViewController.swift
//  weather
//
//  Created by Dadanov Alexey on 14.12.16.
//  Copyright © 2016 Dadanov Alexey. All rights reserved.
//

import UIKit
import Alamofire


class WhomeViewController: UIViewController {
   
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var wheaterLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var uButton: UIButton!
    @IBAction func updateButton(sender: UIButton) {
        weather.downloadData() {
             self.updateUI()
        }
    }
    var weather = dataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weather.downloadData {
            self.updateUI()
        }
        
    }
    
    func updateUI() {
        dateLabel.text = weather.date
        degreesLabel.text = "\(weather.temp)"
        cityLabel.text = weather.location
        wheaterLabel.text = weather.weather
        weatherImage.image = UIImage(named: weather.weather)
    }
}




