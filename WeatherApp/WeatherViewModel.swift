import Foundation

class WeatherViewModel: ObservableObject {
    @Published var forecasts: [ForecastDay] = []

    private let service = WeatherService()

    func loadWeather(for city: String) {
        service.fetchWeather(for: city) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.forecasts = data
                case .failure(let error):
                    print("Error: \(error)")
                    self.forecasts = []
                }
            }
        }
    }
}
