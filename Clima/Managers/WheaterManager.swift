import Foundation
import CoreLocation

struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
    let name: String
    let wind: wind
   
    
    struct Main: Codable {
        let feels_like : Double
        let temp: Double
        let temp_min:Double
        let temp_max: Double
        let humidity: Double
        
    
    }
    let visibility: Int
    
    struct wind: Codable{
        let speed:Double
        let deg: Int
    }
    struct Weather: Codable {
        let description: String
        let main: String
    }
    
    
    }

class WeatherManager {
    enum WeatherError: Error {
        case invalidURL
        case requestFailed
        case invalidResponse
        case decodingFailure
    }
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherResponse {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=2072eafd7cdb7c394365260fc246bf0a&units=metric") else {
            throw WeatherError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw WeatherError.requestFailed
            }
            
            let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return decodedData
            
        } catch {
            switch error {
            case is WeatherError:
                throw error // Re-lanzar errores específicos de WeatherError
            default:
                throw WeatherError.decodingFailure // Capturar cualquier otro error de decodificación
            }
        }
    }
}

func fetchWeather() {
    let weatherManager = WeatherManager()
    let latitude: CLLocationDegrees = 37.7749
    let longitude: CLLocationDegrees = -122.4194
    
    Task {
        do {
            let weather = try await weatherManager.getCurrentWeather(latitude: latitude, longitude: longitude)
            print("Temperatura actual: \(weather.main.temp) grados Celsius")
            print("Descripción del clima: \(weather.weather.first?.description ?? "No disponible")")
        } catch {
            print("Error al obtener el clima: \(error)")
        }
    }
}

// Llama a la función desde el contexto adecuado
//fetchWeather()
