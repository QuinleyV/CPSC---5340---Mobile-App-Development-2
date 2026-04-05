import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var weather: WeatherDisplayModel?
    @Published var isLoading = false
    @Published var errorMessage = ""

    private let service = WeatherService()

    func getWeather() async {
        guard !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please enter a city name."
            return
        }

        isLoading = true
        errorMessage = ""
        weather = nil

        do {
            weather = try await service.fetchWeather(for: city)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
