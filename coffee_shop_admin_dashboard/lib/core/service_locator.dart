import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coffee_shop_admin_dashboard/data/datasources/firebase_auth_datasource.dart';
import 'package:coffee_shop_admin_dashboard/data/datasources/firestore_datasource.dart';
import 'package:coffee_shop_admin_dashboard/data/datasources/functions_datasource.dart';
import 'package:coffee_shop_admin_dashboard/data/repositories/auth_repository_impl.dart';
import 'package:coffee_shop_admin_dashboard/data/repositories/notification_repository_impl.dart';
import 'package:coffee_shop_admin_dashboard/data/repositories/order_repository_impl.dart';
import 'package:coffee_shop_admin_dashboard/data/repositories/product_repository_impl.dart';
import 'package:coffee_shop_admin_dashboard/data/repositories/promotion_repository_impl.dart';
import 'package:coffee_shop_admin_dashboard/data/repositories/report_repository_impl.dart';
import 'package:coffee_shop_admin_dashboard/data/repositories/user_repository_impl.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/auth_repository.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/notification_repository.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/order_repository.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/product_repository.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/promotion_repository.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/report_repository.dart';
import 'package:coffee_shop_admin_dashboard/domain/repositories/user_repository.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/add_product_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/add_promotion_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/add_user_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/delete_product_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/delete_promotion_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/delete_user_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/get_all_users_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/get_daily_report_stream_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/get_products_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/get_promotions_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/get_user_orders_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/login_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/logout_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/register_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/send_notification_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/update_product_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/update_promotion_usecase.dart';
import 'package:coffee_shop_admin_dashboard/domain/usecases/update_user_role_usecase.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/UsersViewModel%20.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/products_viewmodel/add_edit_product_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/promotions_viewmodel/add_edit_promotion_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/add_user_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/dashboard_home_viewmodel/dashboard_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/users_viewmodel/delete_user_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/register_viewmodel/login_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/register_viewmodel/logout_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/products_viewmodel/products_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/promotions_viewmodel/promotions_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/register_viewmodel/register_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/send_notification_viewmodel.dart';
import 'package:coffee_shop_admin_dashboard/presentation/viewmodel/user_orders_viewmodel/user_orders_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create an instance of GetIt
final sl = GetIt.instance;

Future<void> setupServiceLocator({required SharedPreferences prefs}) async {
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerLazySingleton<SharedPreferences>(() => prefs);
  }

  // ----------------- Presentation Layer -----------------
  // ViewModels
  // We use registerFactory for ViewModels because we want a new instance each time we create a page.
  sl.registerFactory(() => ProductsViewModel(sl(), sl()));
  sl.registerFactory(() => AddEditProductViewModel(sl(), sl()));
  sl.registerFactory(() => UsersViewModel(sl(), sl()));
  sl.registerFactory(() => AddUserViewModel(sl()));
  sl.registerFactory(() => DeleteUserViewModel(sl()));

  sl.registerFactory(() => LoginViewModel(sl()));
  sl.registerFactory(() => RegisterViewModel(sl()));
  sl.registerFactory(() => LogoutViewModel(sl()));

  sl.registerFactoryParam<UserOrdersViewModel, String, void>(
    (uid, _) => UserOrdersViewModel(sl(), uid),
  );

  sl.registerFactory(() => DashboardViewModel(sl()));
  sl.registerFactory(() => SendNotificationViewModel(sl()));

  sl.registerFactory(() => PromotionsViewModel(sl(), sl()));
  sl.registerFactory(
    () => AddEditPromotionViewModel(
      addPromotionUsecase: sl(),
      updatePromotionUsecase: sl(),
    ),
  );
  // ----------------- Domain Layer -----------------
  // Usecases
  // We use registerLazySingleton because we only need one instance of the usecase throughout the app.
  sl.registerLazySingleton(() => GetProductsUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  sl.registerLazySingleton(() => AddProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));
  sl.registerLazySingleton(() => GetAllUsersUsecase(sl()));
  sl.registerLazySingleton(() => UpdateUserRoleUsecase(sl()));
  sl.registerLazySingleton(() => AddUserUsecase(sl()));
  sl.registerLazySingleton(() => DeleteUserUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => GetUserOrdersUsecase(sl()));
  sl.registerLazySingleton(() => GetDailyReportStreamUsecase(sl()));
  sl.registerLazySingleton(() => SendNotificationUsecase(sl()));
  sl.registerLazySingleton(() => AddPromotionUseCase(sl()));
  sl.registerLazySingleton(() => GetPromotionsUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePromotionUseCase(sl()));
  sl.registerLazySingleton(() => DeletePromotionUseCase(sl()));

  // ----------------- Data Layer -----------------
  // Repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  if (!sl.isRegistered<OrderRepository>()) {
    sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));
  }

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  sl.registerLazySingleton<ReportRepository>(() => ReportRepositoryImpl(sl()));

  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<PromotionRepository>(
    () => PromotionRepositoryImpl(sl()),
  );

  // Data Sources
  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<FirestoreDataSource>(
    () => FirestoreDataSourceImpl(sl(), sl()),
  );

  sl.registerLazySingleton<FunctionsDataSource>(
    () => FunctionsDataSourceImpl(sl()),
  );

  // ----------------- External -----------------
  // We register the FirebaseFirestore instance itself so our data source can use it.
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseFunctions.instance);
}
