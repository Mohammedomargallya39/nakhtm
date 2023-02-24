import 'package:equatable/equatable.dart';

class TafseerEntity extends Equatable {
  int tafseerId;
  String tafseerName;
  String ayahUrl;
  int ayahNumber;
  String tafseer;

  TafseerEntity({
    required this.tafseerId,
    required this.tafseerName,
    required this.ayahUrl,
    required this.ayahNumber,
    required this.tafseer
  });

  @override
  List<Object?> get props => [
    tafseerId,
    tafseerName,
    ayahUrl,
    ayahNumber,
    tafseer,
  ];
}
