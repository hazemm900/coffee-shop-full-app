import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/core/logic/promotion_engine.dart';
import 'package:coffee_shop_app/data/datasourses/firebase_auth_datasource.dart';
import 'package:coffee_shop_app/data/datasourses/firestore_datasource.dart';
import 'package:coffee_shop_app/data/datasourses/theme_local_datasource.dart';
import 'package:coffee_shop_app/data/repositories/UserRepositoryImpl.dart';
import 'package:coffee_shop_app/data/repositories/auth_repository_impl.dart';
import 'package:coffee_shop_app/data/repositories/cart_repository_impl.dart';
import 'package:coffee_shop_app/data/repositories/checkout_repository_impl.dart';
import 'package:coffee_shop_app/data/repositories/notification_repository_impl.dart';
import 'package:coffee_shop_app/data/repositories/order_repository_impl.dart';
import 'package:coffee_shop_app/data/repositories/product_repository_impl.dart';
import 'package:coffee_shop_app/data/repositories/promotion_repository_impl.dart';
import 'package:coffee_shop_app/data/repositories/theme_repository_impl.dart';
import 'package:coffee_shop_app/domain/repositories/auth_repository.dart';
import 'package:coffee_shop_app/domain/repositories/cart_repository.dart';
import 'package:coffee_shop_app/domain/repositories/checkout_repository.dart';
import 'package:coffee_shop_app/domain/repositories/notification_repository.dart';
import 'package:coffee_shop_app/domain/repositories/order_repository.dart';
import 'package:coffee_shop_app/domain/repositories/product_repository.dart';
import 'package:coffee_shop_app/domain/repositories/promotion_repository.dart';
import 'package:coffee_shop_app/domain/repositories/theme_repository.dart';
import 'package:coffee_shop_app/domain/repositories/user_repository.dart';
import 'package:coffee_shop_app/domain/usecases/add_product_to_cart_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/award_points_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/clear_cart_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/get_active_promotions_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/get_cart_items_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/get_categories_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/get_my_orders_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/get_notifications_stream_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/get_products_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/get_theme_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/get_user_profile_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/login_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/logout_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/place_order_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/redeem_points_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/register_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/remove_product_from_cart_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/save_theme_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/update_product_quantity_usecase.dart';
import 'package:coffee_shop_app/domain/usecases/validate_promo_code_usecase.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/cart_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/cart_viewmodel/checkout_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/home_viewmodel/home_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/register_viewmodel/login_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/my_orders_viemodel/my_orders_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/notification_viewmodel/notifications_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/profile_viewmodel/profile_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/register_viewmodel/register_viewmodel.dart';
import 'package:coffee_shop_app/presentation/view/viewmodel/settings_viewmodel/settings_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

void setupServiceLocator({required SharedPreferences prefs}) {
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerLazySingleton<SharedPreferences>(() => prefs);
  }

  // ViewModels
  sl.registerFactory(() => LoginViewModel(sl()));
  sl.registerFactory(() => RegisterViewModel(sl()));
  sl.registerFactory(() => HomeViewModel(sl(), sl(), sl()));
  sl.registerFactory(
    () => CartViewModel(sl(), sl(), sl(), sl(), sl(), sl(), sl()),
  );
  sl.registerFactory(() => ProfileViewModel(sl()));
  sl.registerFactory(() => MyOrdersViewModel(sl()));
  sl.registerLazySingleton(() => SettingsViewModel(sl(), sl()));
  sl.registerFactory(
    () => NotificationsViewModel(getNotificationsStreamUsecase: sl()),
  );
  sl.registerFactory(() => CheckoutViewModel(sl(), sl(), sl(), sl()));

  // Usecases
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => GetProductsUsecase(sl()));
  sl.registerLazySingleton(() => AddProductToCartUsecase(sl()));
  sl.registerLazySingleton(() => GetCartItemsUsecase(sl()));
  sl.registerLazySingleton(() => RemoveProductFromCartUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductQuantityUsecase(sl()));
  sl.registerLazySingleton(() => PlaceOrderUsecase(sl()));
  sl.registerLazySingleton(() => ClearCartUsecase(sl()));
  sl.registerLazySingleton(() => GetUserProfileUsecase(sl()));
  sl.registerLazySingleton(() => GetMyOrdersUsecase(sl()));
  sl.registerLazySingleton(() => AwardPointsUsecase(sl()));
  sl.registerLazySingleton(() => RedeemPointsUsecase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUsecase(sl()));
  sl.registerLazySingleton(() => GetThemeUsecase(sl()));
  sl.registerLazySingleton(() => SaveThemeUsecase(sl()));
  sl.registerLazySingleton(() => GetNotificationsStreamUsecase(sl()));
  sl.registerLazySingleton(() => GetActivePromotionsUsecase(sl()));
  sl.registerLazySingleton(() => ValidatePromoCodeUsecase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );
  sl.registerSingleton<CartRepository>(CartRepositoryImpl());
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(firestoreDataSource: sl(), firebaseAuth: sl()),
  );
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(firestoreDataSource: sl(), firebaseAuth: sl()),
  );
  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(sl()));
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(dataSource: sl(), firebaseAuth: sl()),
  );
  sl.registerLazySingleton<PromotionRepository>(
    () => PromotionRepositoryImpl(sl()),
  );

  // Data Sources
  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<FirestoreDataSource>(
    () => FirestoreDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(sl()),
  );

  // --- Core ---
  sl.registerLazySingleton(() => PromotionEngine());

  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
