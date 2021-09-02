//
//  OpenWeatherMapNetworkController.swift
//  WeatherApp
//
//  Created by Prashant Ghimire on 9/2/21.
//

import Foundation
final class OpenWeatherMapNetworkController: NetworkController {
  let backupController: NetworkController?
  
  init(backupController: NetworkController? = nil) {
    self.backupController = backupController
  }
  
  public var tempUnit: TemperatureUnit = .imperial
  
  private func simulateFailure() -> NetworkControllerError? {
    return nil
      //.forwarded(NSError(domain: "OpenWeatherMapNetworkController", code: -1, userInfo: nil))
  }
  
  func fetchCurrentWeatherData(city: String, completionHandler: @escaping (WeatherData?, NetworkControllerError?) -> ()) {
    
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    
    let endPoint = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=\(tempUnit)&appid=\(API.key)"
    
    let safeURLString = endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    
    guard let safeUrlString = safeURLString, let endPointURL = URL(string: safeUrlString) else {
      completionHandler(nil, NetworkControllerError.invalidURL(safeURLString ?? ""))
      return
    }
    
    let dataTask = session.dataTask(with: endPointURL) { data, response, error in
      guard self.simulateFailure() == nil else {
        if let backup = self.backupController {
          print("Using backupcontroller")
          backup.fetchCurrentWeatherData(city: city, completionHandler: completionHandler)
        }
        return
      }
      guard error == nil else {
        completionHandler(nil, NetworkControllerError.forwarded(error!))
        return
      }
      guard let jsonData = data else {
        completionHandler(nil, NetworkControllerError.invalidPayload(endPointURL))
        return
      }
      self.decode(jsonData: jsonData, endpointURL: endPointURL, completionHandler: completionHandler)
    }
    dataTask.resume()
  }
  
  private func decode(jsonData: Data, endpointURL: URL, completionHandler: @escaping (WeatherData?, NetworkControllerError?) -> Void) {
    let decoder = JSONDecoder()
    do {
      let weatherInfo = try decoder.decode(OpenMapWeatherData.self, from: jsonData)
      
      let weatherData = WeatherData(temperature: weatherInfo.main.temp, condition: (weatherInfo.weather.first?.main ?? "?"), unit: self.tempUnit)
      completionHandler(weatherData, nil)
    } catch let error {
      completionHandler(nil, NetworkControllerError.forwarded(error))
    }
  }
}
private enum API {
  static let key = "b4dae223e50f67a0dcdde8a2039560f7"
}
