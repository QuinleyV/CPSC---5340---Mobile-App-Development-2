import SwiftUI

struct WeatherDetailView: View {
    let weather: WeatherDisplayModel

    var body: some View {
        List {
            Section("Detailed Weather") {
                Text("Min Temp: \(weather.minTemp)")
                Text("Max Temp: \(weather.maxTemp)")
                Text("Wind Speed: \(weather.windSpeed)")
                Text("Pressure: \(weather.pressure)")
            }
        }
        .navigationTitle("Weather Details")
    }
}
