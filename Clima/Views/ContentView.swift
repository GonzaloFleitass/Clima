//
//  ContentView.swift
//  Climna
//
//  Created by Gonzalo Fleitas on 21/7/24.
//
//
//  ContentView.swift
//  Climna
//
//  Created by Gonzalo Fleitas on 21/7/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: WeatherResponse?
    @State var errorMessage: String?

    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    weatherView(weather: weather)
                   
                } else {
                    LoadingView()
                        .task {
                            await fetchWeather(for: location)
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .background(Color(hue: 0.56, saturation: 0.955, brightness: 0.48))
        .preferredColorScheme(.dark)
    }

    func fetchWeather(for location: CLLocationCoordinate2D) async {
        do {
            weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
        } catch WeatherManager.WeatherError.invalidURL {
            errorMessage = "URL inválida."
        } catch WeatherManager.WeatherError.requestFailed {
            errorMessage = "Fallo en la solicitud."
        } catch WeatherManager.WeatherError.invalidResponse {
            errorMessage = "Respuesta inválida del servidor."
        } catch WeatherManager.WeatherError.decodingFailure {
            errorMessage = "Error al decodificar los datos."
        } catch {
            errorMessage = "Error desconocido: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
