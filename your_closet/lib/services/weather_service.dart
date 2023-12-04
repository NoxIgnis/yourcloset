class WeatherData {
  final temp;
  final description;
  final main;

  WeatherData({required this.temp, required this.description, required this.main});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temp: json['main']['temp'],
      description: json['weather'][0]['description'],
      main: json['weather'][0]['main'],
    );
  }
}