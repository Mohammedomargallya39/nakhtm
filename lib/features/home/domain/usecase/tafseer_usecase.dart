import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/tafseer_entity.dart';
import '../repository/home_base_repository.dart';

class TafseerUseCase implements UseCase<TafseerEntity, TafseerParams> {
  final HomeBaseRepository repository;

  TafseerUseCase(this.repository);

  @override
  Future<Either<Failure,TafseerEntity>> call(TafseerParams params) async {
    return await repository.tafseer(
      tafseerId: params.tafseerId,
      surahId: params.surahId,
      ayahId: params.ayahId,
    );
  }
}

class TafseerParams extends Equatable {
  final int tafseerId;
  final int surahId;
  final int ayahId;

  const TafseerParams({
    required this.tafseerId,
    required this.surahId,
    required this.ayahId,
  });

  @override
  List<Object> get props => [
    tafseerId,
    surahId,
    ayahId,
  ];
}