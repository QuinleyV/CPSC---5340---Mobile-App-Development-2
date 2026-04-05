import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Simple Weather")
                    .font(.largeTitle)
                    .bold()

                TextField("Enter city name", text: $viewModel.city)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                Button("Get Weather") {
                    Task {
                        await viewModel.getWeather()
                    }
                }
                .buttonStyle(.borderedProminent)

                if viewModel.isLoading {
                    ProgressView("Loading...")
                }

                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                if let weather = viewModel.weather {
                    List {
                        Section("Current Weather") {
                            Text("City: \(weather.cityName)")
                            Text("Temperature: \(weather.temperature)")
                            Text("Feels Like: \(weather.feelsLike)")
                            Text("Condition: \(weather.description)")
                            Text("Humidity: \(weather.humidity)")
                        }

                        Section {
                            NavigationLink("View Details") {
                                WeatherDetailView(weather: weather)
                            }
                        }
                    }
                }

                Spacer()
            }
            .padding(.top)
        }
    }
}
