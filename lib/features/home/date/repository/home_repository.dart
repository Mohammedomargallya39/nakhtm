import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/adan_entity.dart';
import '../../domain/entities/hadith_entity.dart';
import '../../domain/entities/tafseer_entity.dart';
import '../../domain/repository/home_base_repository.dart';
import '../data_source/home_remote_date_source.dart';


typedef CallAdan = Future<List<AdanEntity>> Function();
typedef CallTafseer = Future<TafseerEntity> Function();
typedef CallHadith = Future<List<HadithEntity>> Function();

class HomeRepoImplementation extends HomeBaseRepository {
  final HomeBaseRemoteDataSource remoteDataSource;

  HomeRepoImplementation({
    required this.remoteDataSource,
  });

  Future<Either<Failure, List<AdanEntity>>> fetchData(
      CallAdan mainMethod,
      ) async {
    try {
      final adanData = await mainMethod();
      return Right(adanData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<AdanEntity>>> adan(
      {
        required String year,
        required String month,
        required String day,
        required String lat,
        required String lng,
        required String method,
      }) async {
    return await fetchData(()
    {
      return remoteDataSource.adan(
        year: year,
        month: month,
        day: day,
        lat: lat,
        lng: lng,
        method: method,
      );
    });
  }


  Future<Either<Failure, TafseerEntity>> fetchTafseer(
      CallTafseer mainMethod,
      ) async {
    try {
      final tafseerData = await mainMethod();
      return Right(tafseerData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, TafseerEntity>> tafseer(
      {
        required int tafseerId,
        required int surahId,
        required int ayahId,
      }) async {
    return await fetchTafseer(()
    {
      return remoteDataSource.tafseer(
        tafseerId: tafseerId,
        surahId: surahId,
        ayahId: ayahId,
      );
    });
  }


  Future<Either<Failure, List<HadithEntity>>> fetchHadith(
      CallHadith mainMethod,
      ) async {
    try {
      final hadithData = await mainMethod();
      return Right(hadithData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        error: e.error,
        code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<HadithEntity>>> hadith(
      {
        required String bookName,
        required int pageNum,
      }) async {
    return await fetchHadith(()
    {
      return remoteDataSource.hadith(
        bookName: bookName,
        pageNum: pageNum,

      );
    });
  }



}