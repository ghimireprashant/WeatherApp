//
//  ApixuDataMappings.swift
//  WeatherApp
//
//  Created by Nyisztor, Karoly on 10/26/17.
//  Copyright © 2017 Nyisztor, Karoly. All rights reserved.
//

import Foundation

struct ApixuWeatherContainer: Codable {
    var current: ApixuWeatherCurrent
}

struct ApixuWeatherCurrent: Codable {
    var temp_c: Float
    var temp_f: Float
    var condition: ApixuWeatherCondition
}

struct ApixuWeatherCondition: Codable {
    var text: String
    var icon: String // icon image url
}

