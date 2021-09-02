//
//  NetworkController.swift
//  WeatherApp
//
//  Created by Prashant Ghimire on 9/2/21.
//

import Foundation
public protocol NetworkController {
  var backupController: NetworkController? {get}
  func fetchCurrentWeatherData(city: String, completionHandler: @escaping (WeatherData?, NetworkControllerError?) -> ())
  init(backupController: NetworkController?)
}
extension NetworkController {
  var backupController: NetworkController? {
    return nil
  }
}
//(Result<Data, Error>)
public struct WeatherData {
  var temperature: Float
  var condition: String
  var unit: TemperatureUnit
  
}
public enum TemperatureUnit: String {
  case scientific = "K"
  case metric = "C"
  case imperial = "F"
}
public enum NetworkControllerError: Error {
  case invalidURL(String)
  case invalidPayload(URL)
  case forwarded(Error)
}
