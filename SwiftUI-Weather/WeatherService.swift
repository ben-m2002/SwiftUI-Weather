//
//  WeatherService.swift
//  SwiftUI-Weather
//
//  Created by Ben Maduabuchi on 5/30/24.
//

import Foundation


func getCityData (cityName : String) async throws -> cityData? {
    let accessKey = "4801a057bf55f6d0a706fab178fcdece"
    let urlString = "http://api.weatherstack.com/current?access_key=\(accessKey)&query=\(cityName)"
    guard let url = URL(string : urlString) else {
        throw CDError.invalidURL
    }
  
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
        throw CDError.invalidResponse
    }
    do {
        if let jsonObject = try JSONSerialization.jsonObject(with: data, options : []) as? [String : Any],
           let location = jsonObject["location"] as? [String : Any],
           let current = jsonObject["current"] as? [String : Any]{
                
            let city = location["name"] as? String ?? "Unknown"
            let localtime = location["localtime"] as? String ?? "Unknown"
            let descriptions = current["weather_descriptions"] as? [String] ?? ["Unknown"]
            let temperature = current["temperature"] as? Int ?? 0
            let humidity = current["humidity"] as? Int ?? 0
            let uvIndex = current["uv_index"] as? Int ?? 0
            
            let cityDataObj = cityData(city: city,
                                       localtime: localtime
                                       , descriptions: descriptions,
                                       temperature: temperature,
                                       humidity: humidity,
                                       Uv_index: uvIndex)
            return cityDataObj
            }
    }catch
    {
        throw CDError.invalidData
    }
    return nil
}
    

enum CDError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

