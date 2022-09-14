// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;
  DirectGeocoding({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory DirectGeocoding.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];

    return DirectGeocoding(
      name: data['name'],
      lat: data['lat'],
      lon: data['lon'],
      country: data['country'],
    );
  }

  @override
  bool operator ==(covariant DirectGeocoding other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.lat == lat &&
        other.lon == lon &&
        other.country == country;
  }

  @override
  int get hashCode {
    return name.hashCode ^ lat.hashCode ^ lon.hashCode ^ country.hashCode;
  }

  @override
  String toString() {
    return 'DirectGeocoding(name: $name, lat: $lat, lon: $lon, country: $country)';
  }

  @override
  List<Object> get props => [name, lat, lon, country];
}
