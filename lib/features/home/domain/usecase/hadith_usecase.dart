import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/hadith_entity.dart';
import '../repository/home_base_repository.dart';

class HadithUseCase implements UseCase<List<HadithEntity>, HadithParams> {
  final HomeBaseRepository repository;

  HadithUseCase(this.repository);

  @override
  Future<Either<Failure, List<HadithEntity>>> call(HadithParams params) async {
    return await repository.hadith(
      bookName: params.bookName,
      pageNum: params.pageNum,
    );
  }
}
class HadithParams extends Equatable {
  final String bookName;
  final int pageNum;
  const HadithParams({
    required this.bookName,
    required this.pageNum,
  });
  @override
  List<Object> get props => [
    bookName,
    pageNum,
  ];
}