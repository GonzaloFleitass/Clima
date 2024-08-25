//
//  WelcomeView.swift
//  Clima
//
//  Created by Gonzalo Fleitas on 21/7/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        
        VStack{
            
            VStack(spacing:20){
                Image(systemName: "cloud.sun.fill")
                      .resizable() // Hace que la imagen se pueda redimensionar
                      .aspectRatio(contentMode: .fit) // Mantiene la proporción de la imagen
                      .frame(width: 300, height: 100) // Define un tamaño cuadrado de 100x100
                      .foregroundStyle(.white)
                      
                
                Text("Bienviendo A Tu Aplicacion Del Clima").bold().font(.title).foregroundStyle(.white)
                Text("Por favor comparta su ubicacion para poder obtener el clima en su area").padding().foregroundStyle(.white)
                
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation){
                locationManager.requestLocation()
                    
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
            
        
            
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color(hue: 0.56, saturation: 0.955, brightness: 0.48))
    }

}

#Preview {
    WelcomeView()
}
