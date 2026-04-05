import Foundation

struct GeoResponse: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}

struct WeatherResponse: Codable {
    let name: String
    let main: MainInfo
    let weather: [WeatherInfo]
    let wind: WindInfo
}

struct MainInfo: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int
    let pressure: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
        case pressure
    }
}

struct WeatherInfo: Codable, Identifiable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WindInfo: Codable {
    let speed: Double
}

struct WeatherDisplayModel {
    let cityName: String
    let temperature: String
    let feelsLike: String
    let description: String
    let humidity: String
    let minTemp: String
    let maxTemp: String
    let windSpeed: String
    let pressure: String
}
