import Foundation

struct WeatherResponse: Codable {
    let forecast: Forecast
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
}

struct Day: Codable {
    let avgtemp_c: Double
    let maxtemp_c: Double
    let mintemp_c: Double
    let maxwind_kph: Double
    let avghumidity: Double
    let condition: Condition
}

struct Condition: Codable {
    let text: String
    let icon: String
}
