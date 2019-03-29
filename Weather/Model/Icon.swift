//
//  Icon.swift
//  Weather
//
//  Created by wayne.lv on 2019/3/29.
//

import Foundation

/// Types of weather conditions. Additional values may be defined in the future, so be sure to use a default.
public enum Icon: String, Decodable {

    /// A clear day.
    case clearDay = "clear-day"

    /// A clear night.
    case clearNight = "clear-night"

    /// A rainy day or night.
    case rain = "rain"

    /// A snowy day or night.
    case snow = "snow"

    /// A sleety day or night.
    case sleet = "sleet"

    /// A windy day or night.
    case wind = "wind"

    /// A foggy day or night.
    case fog = "fog"

    /// A cloudy day or night.
    case cloudy = "cloudy"

    /// A partly cloudy day.
    case partlyCloudyDay = "partly-cloudy-day"

    /// A partly cloudy night.
    case partlyCloudyNight = "partly-cloudy-night"

}
