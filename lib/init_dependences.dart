import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:project_management_app/app/core/common/cubits/user_cubit/app_user_cubit.dart';
import 'package:project_management_app/app/core/network/internet_connection/internet_checker_impl.dart';
import 'package:project_management_app/app/core/network/internet_connection/internet_checker_interface.dart';
import 'package:project_management_app/app/core/secret/supabase_secret.dart';
import 'package:project_management_app/app/features/auth/data/datasources/remote/auth_remote_supabase_datasources.dart';
import 'package:project_management_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:project_management_app/app/features/auth/domain/respository/auth_repository.dart';
import 'package:project_management_app/app/features/auth/domain/usecases/current_user.dart';
import 'package:project_management_app/app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:project_management_app/app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:project_management_app/app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final servicelocator = GetIt.instance;
Future<void> initDependences() async {
  _initAuth();
  final supabase =  await Supabase.initialize(
    url: SupaBaseSecret.baseUrl,
    anonKey: SupaBaseSecret.apiKey
  );
  final appDocumrntDir = await path_provider.getApplicationCacheDirectory();
  Hive.init(appDocumrntDir.path);
  Hive.openBox('projects');
  servicelocator.registerLazySingleton(() => supabase.client);
  servicelocator.registerLazySingleton(() => Hive.box('blogs'));
  servicelocator.registerFactory(() => InternetConnection());
  servicelocator.registerLazySingleton(() => AppUserCubit());
  servicelocator.registerFactory<IConnectionChecker>(() => ConnectionCheckerImpl(servicelocator()));
}
void _initAuth(){
  servicelocator..registerFactory<IAuthRemoteDataSource>(() => AuthRemoteSupaBaseDataSourceImpl(servicelocator()))
  ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
    servicelocator(),
    servicelocator()
    )
  )
  ..registerFactory(() => UserSignUp(servicelocator()))
  ..registerFactory(() => UserSignIn(servicelocator()))
  ..registerFactory(() => CurrentUser(servicelocator()))
  ..registerLazySingleton(() => AuthBloc(
    userSignUp: servicelocator(), 
    userSignIn: servicelocator(), 
    currentUser: servicelocator(),
    appUserCubit: servicelocator()
    )
  );
}