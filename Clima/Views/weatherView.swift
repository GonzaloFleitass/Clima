//
//  weatherView.swift
//  Clima
//
//  Created by Gonzalo Fleitas on 14/8/24.
//

import SwiftUI

struct weatherView: View {
    var weather: WeatherResponse
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5){
                    Text(weather.name).bold().font(.title)
                    Text("Hoy, \(Date().formatted(.dateTime.month().day().hour().minute()))").fontWeight(.light)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack{
                        VStack(spacing: 20){
                            Image(systemName:"sun.max.fill").font(.system(size: 40))
                            
                            Text(weather.weather[0].main)
                        }
                        .frame(width:150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.temp.roundDouble() + "°") .font(.system(size: 100))
                                .fontWeight( .bold)
                                .padding()
                        }
                    Spacer()
                        .frame(height: 80)
                    AsyncImage(url: URL(string: "https://pngimg.com/d/city_PNG38.png")) { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(width: 350)
                             
                    }
                placeholder:{
                    ProgressView()
                }
                    Spacer()
                       
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack{
                Spacer()
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Clima actual")
                        .bold()
                        .padding(.bottom)
                    HStack{
                        WeatherRow(logo:"thermometer", name:"min temp", value:(weather.main.temp_min.roundDouble() + "°"))
                        Spacer()
                        WeatherRow(logo:"thermometer", name:"max temp", value:(weather.main.temp_max.roundDouble() + "°"))
                        
                    }
                    HStack{
                        WeatherRow(logo:"wind", name:"Velocidad del viento", value:(weather.wind.speed.roundDouble() + "m/s"))
                        Spacer()
                        WeatherRow(logo:"humidity", name:"Humedad", value:(weather.main.humidity.roundDouble() + "%"))
                        
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.56, saturation: 0.955, brightness: 0.48))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight ])
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.56, saturation: 0.955, brightness: 0.48))
        .preferredColorScheme(.dark)
    }
}

    
    struct WeatherView_Previews: PreviewProvider{
        static var previews: some View{
            weatherView(weather: previewWeather)
        }
    }

