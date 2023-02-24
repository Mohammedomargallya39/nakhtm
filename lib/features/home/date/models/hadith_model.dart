import '../../domain/entities/hadith_entity.dart';

class HadithModel extends HadithEntity {
  HadithModel({
    required hadithId,
    required hadithArabic,
  }) : super(hadithId:hadithId, hadithArabic: hadithArabic);

  factory HadithModel.fromJson(Map<String, dynamic> json) {
    return HadithModel(
      hadithId: json['id'],
      hadithArabic: json['hadithArabic'],
    );
  }
}