import Foundation

class WeatherService {
    private let apiKey = "cde5317f122c4a44828205349250306" // ← вставь сюда свой ключ

    func fetchWeather(for city: String, completion: @escaping (Result<[ForecastDay], Error>) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=5&aqi=no&alerts=no"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }

            do {
                let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(decoded.forecast.forecastday))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
