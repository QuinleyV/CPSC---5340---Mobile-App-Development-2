import Foundation

enum WeatherError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidCity
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .invalidCity:
            return "City not found."
        case .decodingError:
            return "Failed to decode weather data."
        }
    }
}

final class WeatherService {
    private let apiKey = "YOUR_API_KEY_HERE"

    func fetchWeather(for city: String) async throws -> WeatherDisplayModel {
        let location = try await fetchCoordinates(for: city)
        let weather = try await fetchCurrentWeather(lat: location.lat, lon: location.lon)

        return WeatherDisplayModel(
            cityName: "\(weather.name), \(location.country)",
            temperature: "\(Int(weather.main.temp))°F",
            feelsLike: "\(Int(weather.main.feelsLike))°F",
            description: weather.weather.first?.description.capitalized ?? "N/A",
            humidity: "\(weather.main.humidity)%",
            minTemp: "\(Int(weather.main.tempMin))°F",
            maxTemp: "\(Int(weather.main.tempMax))°F",
            windSpeed: "\(weather.wind.speed) mph",
            pressure: "\(weather.main.pressure) hPa"
        )
    }

    private func fetchCoordinates(for city: String) async throws -> GeoResponse {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(encodedCity)&limit=1&appid=\(apiKey)"

        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw WeatherError.invalidResponse
        }

        let results = try JSONDecoder().decode([GeoResponse].self, from: data)

        guard let first = results.first else {
            throw WeatherError.invalidCity
        }

        return first
    }

    private func fetchCurrentWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=imperial"

        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw WeatherError.invalidResponse
        }

        do {
            return try JSONDecoder().decode(WeatherResponse.self, from: data)
        } catch {
            throw WeatherError.decodingError
        }
    }
}
