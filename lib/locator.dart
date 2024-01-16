import 'package:get_it/get_it.dart';

import 'services/alert_service.dart';
import 'services/api_service.dart';
import 'services/local_storage_service.dart';
import 'services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setUpLocator(){
  locator.registerLazySingleton(() => AlertService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => LocalStorageService());
  locator.registerLazySingleton(() => NavigationService());
}
