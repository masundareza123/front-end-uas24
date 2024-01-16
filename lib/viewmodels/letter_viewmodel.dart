import 'package:flutter/material.dart';
import 'package:uas_ppl_2024/viewmodels/base_model.dart';

import '../const.dart';
import '../locator.dart';
import '../services/alert_service.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_service.dart';

class LetterViewModel extends BaseModel {
  final AlertService _alertService = locator<AlertService>();
  final ApiService _apiService = locator<ApiService>();
  final LocalStorageService _localStorageService =
  locator<LocalStorageService>();
  final NavigationService _navigationService = locator<NavigationService>();
}