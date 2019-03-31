//
//  DarkSkyService.swift
//  Weather
//
//  Created by wayne.lv on 2019/3/31.
//

import Foundation
import Alamofire

class DarkSkyService {

    fileprivate enum Key {
        
        static let apiKey = "c3058f0521895f96e24491029a21f763"
    }

    enum ServiceError: Error {

        /// Error due to unknown cause.
        case decodeError
    }

    static var shared = DarkSkyService(apiKey: Key.apiKey)

    private let apiKey: String
    private static let hostURL = "https://api.darksky.net/forecast/"

    public init(apiKey key: String) {
        apiKey = key
    }

    func getForecast(latitude lat: Double, longitude lon: Double, extendHourly: Bool = false, excludeFields: [Forecast.Field] = [], completion: @escaping (Result<Forecast>) -> Void) {
        let url = buildForecastURL(latitude: lat, longitude: lon, time: nil, extendHourly: extendHourly, excludeFields: excludeFields)

        Alamofire.request(url).responseData { response in
            switch response.result {
            case let .success(data):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                do {
                    let weather = try decoder.decode(Forecast.self, from: data)
                    completion(Result.success(weather))
                } catch {
                    completion(Result.failure(ServiceError.decodeError))
                }
            case let .failure(error):
                completion(Result.failure(error))
            }
        }
    }

    private func buildForecastURL(latitude lat: Double, longitude lon: Double, time: Date?, extendHourly: Bool, excludeFields: [Forecast.Field]) -> URL {
        // Build URL path
        var urlString = DarkSkyService.hostURL + apiKey + "/\(lat),\(lon)"
        if let time = time {
            let timeString = String(format: "%.0f", time.timeIntervalSince1970)
            urlString.append(",\(timeString)")
        }

        // Build URL query parameters
        let urlBuilder = URLComponents(string: urlString)!
        return urlBuilder.url!
    }

}
