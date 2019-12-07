import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sharlist/data/datasources/user_remote_data_source.dart';
import 'package:sharlist/data/repositories/auth_repository_impl.dart';
import 'package:sharlist/domain/services/auth_service.dart';
import 'package:sharlist/domain/usecases/sign_in_anonymously.dart';
import 'package:sharlist/domain/usecases/sign_in_with_google.dart';
import 'package:sharlist/presentation/bloc/auth/auth_bloc.dart';

final sl = GetIt.instance;

void setUpDependencies() {
  // Bloc
  sl.registerFactory(() => AuthBloc(signInAnonymously: sl(), signInWithGoogle: sl()));

  // Use cases
  sl.registerLazySingleton(() => SignInAnonymously(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  
  // Services
  sl.registerLazySingleton<AuthService>(() => AuthRepositoryImpl(dataSource: sl()));

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(firestore: sl(), auth: sl(), googleSignIn: sl()));

  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => Firestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
}
