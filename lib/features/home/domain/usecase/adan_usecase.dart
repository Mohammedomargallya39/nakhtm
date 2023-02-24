import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/adan_entity.dart';
import '../repository/home_base_repository.dart';

class AdanUseCase implements UseCase<List<AdanEntity>, AdanParams> {
  final HomeBaseRepository repository;

  AdanUseCase(this.repository);

  @override
  Future<Either<Failure, List<AdanEntity>>> call(AdanParams params) async {
    return await repository.adan(
      year: params.year,
      month: params.month,
      day: params.day,
      lat: params.lat,
      lng: params.lng,
      method: params.method,
    );
  }
}

class AdanParams extends Equatable {
  final String year;
  final String month;
  final String day;
  final String lat;
  final String lng;
  final String method;

  const AdanParams({
    required this.year,
    required this.month,
    required this.day,
    required this.lat,
    required this.lng,
    required this.method,
  });

  @override
  List<Object> get props => [
    year,
    month,
    day,
    lat,
    lng,
    method,
  ];
}