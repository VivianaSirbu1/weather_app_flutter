class WeatherData {
  final double temperature;

  WeatherData({
    required this.temperature,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json["temp"],
    );
  }

  Map<String, dynamic> toJson() => {"temp": temperature};
}
