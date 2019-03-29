//
//  Forecast.swift
//  Weather
//
//  Created by wayne.lv on 2019/3/29.
//

import Foundation

/// The weather data for a location at a specific time.
public struct Forecast: Decodable {

    /// The requested latitude.
    public let latitude: Double

    /// The requested longitude.
    public let longitude: Double

    /// The IANA timezone name for the requested location (e.g. "America/New_York"). Rely on local user settings over this property.
    public let timezone: String

    /// Severe weather `Alert`s issued by a governmental weather authority for the requested location.
    public let alerts: [Alert]?

    /// The current weather conditions at the requested location.
    public let currently: DataPoint?

    /// The daily weather conditions at the requested location for the next week aligned to midnight of the day.
    public let daily: DataBlock?

    /// Data fields associated with a `Forecast`.
    public enum Field: String, Decodable {

        /// Current weather conditions.
        case currently = "currently"

        /// Day-by-day weather conditions for the next week.
        case daily = "daily"

        /// Severe weather alerts.
        case alerts = "alerts"

        /// Miscellaneous metadata.
        case flags = "flags"
    }
    
}


