import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city: String = "Moscow"

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter city", text: $city)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                Spacer()
                                
                            }
                        )
                        .padding(.horizontal)

                    Button(action: {
                        viewModel.loadWeather(for: city)
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 30, trailing: 10))
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(10)
                }
                .padding(.top, 10)


                if viewModel.forecasts.isEmpty {
                    Spacer()
                    Text("No data. Enter city and press Search.")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List(viewModel.forecasts, id: \.date) { day in
                        HStack(alignment: .top) {
                            AsyncImage(url: URL(string: "https:\(day.day.condition.icon)")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .padding(.top, 4)

                            VStack(alignment: .leading, spacing: 6) {
                                Text(day.date)
                                    .font(.headline)

                                Text(day.day.condition.text)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                HStack {
                                    Text("🌡 \(Int(day.day.avgtemp_c))°C")
                                    Text("💨 \(Int(day.day.maxwind_kph)) kph")
                                    Text("💧 \(Int(day.day.avghumidity))%")
                                }
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                        .padding(.vertical, 4)
                    }
                    .listStyle(.plain)

                }
            }
            .navigationTitle("Weather Forecast")
        }
        .onAppear {
            viewModel.loadWeather(for: city)
        }
    }
}
