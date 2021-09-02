//
//  OpenWeatherMapModel.swift
//  WeatherApp
//
//  Created by Prashant Ghimire on 9/2/21.
//

import Foundation
struct OpenMapWeatherData: Codable{
  var weather: [OpenMapWeather]
  var main: OpenMapWeatherMain
  
}
struct OpenMapWeather: Codable{
  var id: Int
  var main: String
  var description: String
  var icon: String
  
}
struct OpenMapWeatherMain: Codable{
  var temp: Float
}
