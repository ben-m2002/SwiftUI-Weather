//
//  WeatherService.swift
//  SwiftUI-Weather
//
//  Created by Ben Maduabuchi on 5/30/24.
//

import Foundation


func getCityData(lat: Double, lon: Double) async throws -> cityData? {
    let accessKey = "1fd88c3ac9707f86231be9ddbc628da1"
    let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(accessKey)&units=metric"
    print(urlString)
    guard let url = URL(string: urlString) else {
        throw CDError.invalidURL
    }

    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw CDError.invalidResponse
    }

    do {
        if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
           let main = jsonObject["main"] as? [String: Any],
           let sys = jsonObject["sys"] as? [String: Any],
           let weatherArray = jsonObject["weather"] as? [[String: Any]],
           let weather = weatherArray.first
        {
            let city = jsonObject["name"] as? String ?? "Unknown"
            let country = sys["country"] as? String ?? "Unknown"
            let description = weather["description"] as? String ?? "Unknown"
            let temperature = main["temp"] as? Double ?? 0.0
            let lowTemp = main["temp_min"] as? Double ?? 0.0
            let highTemp = main["temp_max"] as? Double ?? 0.0

            let cityDataObj = cityData(city: city, country: country, description: description,
                                       temperature: temperature, lowTemp: lowTemp, highTemp: highTemp)
            return cityDataObj
        }
    } catch {
        throw CDError.invalidData
    }
    return nil
}

    

enum CDError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

