//
//  WeatherButton.swift
//  SwiftUI-Weather
//
//  Created by Ben Maduabuchi on 5/25/24.
//

import SwiftUI

struct WeatherButton : View{
    var buttonTitle : String
    var backgroundColor : Color
    var foregroundColor : Color
    
    var body : some View{
        Text(buttonTitle)
            .font(.system(size: 18, weight: .heavy, design: .default))
            .frame(width: 280, height: 50)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(10)
    }
}

