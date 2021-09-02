//
//  ViewController.swift
//  WeatherApp
//
//  Created by Prashant Ghimire on 9/2/21.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var cityTextField: UITextField!
  @IBOutlet weak var weatherLabel: UILabel!
  
  private lazy var controller = OpenWeatherMapNetworkController(backupController: ApixuNetworkController())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let city = textField.text, !city.isEmpty else {
      self.weatherLabel.text = "City name is emplty"
      return true
    }
    controller.fetchCurrentWeatherData(city: city) { WeatherData, error in
      if let data = WeatherData {
        self.weatherLabel.text = "Weather in \(city): \(data.condition), \(data.temperature) \(data.unit.rawValue)"
      } else {
        self.weatherLabel.text = "There is no weather in your location!"
      }
    }
    return true
  }
}
