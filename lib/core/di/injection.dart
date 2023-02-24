import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/home/date/data_source/home_remote_date_source.dart';
import '../../features/home/date/repository/home_repository.dart';
import '../../features/home/domain/repository/home_base_repository.dart';
import '../../features/home/domain/usecase/adan_usecase.dart';
import '../../features/home/domain/usecase/hadith_usecase.dart';
import '../../features/home/domain/usecase/tafseer_usecase.dart';
import '../../features/home/presentation/controller/bloc.dart';
import '/core/network/local/cache_helper.dart';
import '/core/network/remote/dio_helper.dart';
import '/core/network/repository.dart';
import '/core/util/cubit/cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerLazySingleton(
    () => AppBloc(),
  );

  sl.registerLazySingleton(
        () => HomeCubit(
          adanUseCase: sl(),
          tafseerUseCase: sl(),
          hadithUseCase: sl(),
        ),
  );

  sl.registerLazySingleton<Repository>(
    () => RepoImplementation(
      dioHelper: sl(),
      cacheHelper: sl(),
    ),
  );

  // Repository

  sl.registerLazySingleton<HomeBaseRepository>(
        () => HomeRepoImplementation(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => AdanUseCase(sl()));
  sl.registerLazySingleton(() => TafseerUseCase(sl()));
  sl.registerLazySingleton(() => HadithUseCase(sl()));




  //Data sources

  sl.registerLazySingleton<HomeBaseRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(dioHelper: sl()),
  );

  // Core
  sl.registerLazySingleton<DioHelper>(
    () => DioImpl(),
  );

  sl.registerLazySingleton<CacheHelper>(
    () => CacheImpl(
      sl(),
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
