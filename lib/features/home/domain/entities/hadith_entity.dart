import 'package:equatable/equatable.dart';

class HadithEntity extends Equatable {
  int hadithId;
  String hadithArabic;

  HadithEntity({
    required this.hadithId,
    required this.hadithArabic,
  });

  @override
  List<Object?> get props => [
    hadithId,
    hadithArabic,
  ];
}
