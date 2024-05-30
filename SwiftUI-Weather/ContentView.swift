//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Ben Maduabuchi on 5/24/24.
//

import SwiftUI

struct ContentView: View {
    
    // H Stack : horizontally stacking the elements
    // V Stack : Vertically aligning the items
    // Z Stack : Aligning views on top each other on the z axis, so                 coming out the screen (Layering)
    @State private var isNight = false
    @State private var cityName = "Cupertino"
    
    var body: some View {
        ZStack {
            BackgroundView(isNight : $isNight)
            VStack {
                CityTextView(CityName: "Cupertino, CA")
                MainWeatherView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: "76")
                HStack (spacing : 7){
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: "74")
                    WeatherDayView(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: "74")
                    WeatherDayView(dayOfWeek: "THU", imageName: "wind.snow", temperature: "66")
                    WeatherDayView(dayOfWeek: "FRI", imageName: "sunset.fill", temperature: "74")
                    WeatherDayView(dayOfWeek: "SAT", imageName: "snow", temperature: "25")
                    .padding(.trailing, 7)
                }
                .padding()
                Spacer()
                Button{
                    isNight.toggle()
                }label: {
                    // this is what button looks like
                    WeatherButton(buttonTitle: "Change Day Time", backgroundColor: .white, foregroundColor: .blue)
                }
               
                Spacer()
            }
        }
    }
    
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    
    var dayOfWeek : String
    var imageName : String
    var temperature : String
    
    var body: some View {
        VStack (spacing : 9) {
            Text(dayOfWeek)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60 , height : 60)
            Text(temperature + "°")
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.trailing, 7)
    }
}

struct BackgroundView: View {
    @Binding var isNight : Bool
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing) // everything is a view even color
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct CityTextView: View {
    var CityName : String
    var body: some View{
        Text(CityName)
            .font(.system(size: 32, weight: .medium, design : .default))
            .foregroundColor(.white)
            .padding(20)
    }
}

struct MainWeatherView: View{
    
    var imageName : String
    var temperature : String
    
    var body: some View{
        VStack(spacing : 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180 , height : 180)
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}


