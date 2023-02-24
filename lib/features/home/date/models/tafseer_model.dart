import '../../domain/entities/tafseer_entity.dart';

class TafseerModel extends TafseerEntity {
  TafseerModel({
    required tafseerId,
    required ayahNumber,
    required ayahUrl,
    required tafseerName,
    required tafseer,
  }) : super(ayahNumber: ayahNumber, ayahUrl: ayahUrl,tafseer: tafseer, tafseerId: tafseerId, tafseerName: tafseerName);

  factory TafseerModel.fromJson(Map<String, dynamic> json) {
    return TafseerModel(
      tafseerId: json['tafseer_id'],
      tafseerName: json['tafseer_name'],
      ayahUrl: json['ayah_url'],
      ayahNumber: json['ayah_number'],
      tafseer: json['text'],
    );
  }
}