import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/adan_entity.dart';
import '../entities/hadith_entity.dart';
import '../entities/tafseer_entity.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, List<AdanEntity>>> adan({
    required String year,
    required String month,
    required String day,
    required String lat,
    required String lng,
    required String method,
  });
  Future<Either<Failure, TafseerEntity>> tafseer({
    required int tafseerId,
    required int surahId,
    required int ayahId,
  });
  Future<Either<Failure, List<HadithEntity>>> hadith({
    required String bookName,
    required int pageNum,
  });


}