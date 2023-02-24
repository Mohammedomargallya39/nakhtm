import 'package:equatable/equatable.dart';

class AdanEntity extends Equatable {
  Timings timings;
  String date;

  AdanEntity({
    required this.timings,
    required this.date,
  });
  @override
  List<Object?> get props => [
    timings,
    date,
  ];
}

class Timings extends Equatable {
  String fajr;
  String sunrise;
  String dhuhr;
  String asr;
  String maghrib;
  String ishaa;
  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.ishaa
});
  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      maghrib: json['Maghrib'],
      ishaa: json['Isha'],
    );
  }
  @override
  List<Object?> get props =>
      [
        fajr,
        sunrise,
        dhuhr,
        asr,
        maghrib,
        ishaa,
      ];
}