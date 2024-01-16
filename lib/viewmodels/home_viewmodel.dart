import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:uas_ppl_2024/models/login_token_model.dart';
import 'package:uas_ppl_2024/viewmodels/base_model.dart';

import '../const.dart';
import '../locator.dart';
import '../models/get_letter_response_model.dart';
import '../services/alert_service.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../services/navigation_service.dart';

class HomeViewModel extends BaseModel {
  final AlertService _alertService = locator<AlertService>();
  final ApiService _apiService = locator<ApiService>();
  final LocalStorageService _localStorageService =
  locator<LocalStorageService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final formKey = GlobalKey<FormState>();
  final nimController = TextEditingController();
  final passwordController = TextEditingController();

  bool loginStatus = false;

  List<SuratList> letterList = [];

  void statusLogged() async {
    loginStatus = await _localStorageService.getBool(localStatusLogin) ?? false;
    if (loginStatus == true) {
      getLetterData();
    }
    setBusy(false);
  }

  void navigateTo(routeName) {
    _navigationService.replaceTo(routeName);
  }

  void loginUser() async {
    if (nimController.text.isEmpty || passwordController.text.isEmpty) {
      _alertService.warningAlert("Peringatan", "Isi Semua Form Yang ada", () {
        _navigationService.pop();
      });
    } else {
      final data = await _apiService.login(
          nimController.text.trim(), passwordController.text);
      if (data == null) {
        _alertService.failedAlert("Gagal", "Server Bermasalah", () {
          _navigationService.pop();
        });
      } else {
        if (data.message == "Berhasil login") {
          await _localStorageService.setBool(localStatusLogin, true);
          final decodedToken = JwtDecoder.decode(data.token!);
          final json = jsonEncode(decodedToken);
          final response = loginTokenModelFromJson(json);
          await _localStorageService.setString(localNimUser, response.nim!);
          await _localStorageService.setString(localNameUser, response.namaLengkap!);
          await _localStorageService.setString(localProdiUser, response.programStudi!);
          await _localStorageService.setString(localPhoneNumberUser, response.nomorTelepon!);
          _alertService.successAlert("Berhasil", "Anda telah login", () {
            _navigationService.replaceTo(homeViewRoute);
            setBusy(false);
          });
        } else {
          _alertService.failedAlert("Gagal", data.message!, () {
            _navigationService.pop();
          });
        }
      }
    }
  }

  void logOut() async {
    _alertService.choiceAlert("Logout", "Keluar dari halaman ini?", "Yes", () async {
      await _localStorageService.clearStorage();
      _navigationService.replaceTo(homeViewRoute);
    }, () {_navigationService.pop();});
  }

  void getLetterData() async {
    final nim = await _localStorageService.getString(localNimUser);
    final data = await _apiService.getLetter(nim!);
    if (data == null) {
      _alertService.failedAlert("Gagal", "Internal server error", () {
        _navigationService.pop();
      });
    } else {
      if (data.suratList!.isEmpty) {
        _alertService.warningAlert(
            "Perhatian", "Anda belum melakukan pengajuan surat", () {
          _navigationService.pop();
        });
      } else {
        for (var value in data.suratList!) {
          letterList.add(SuratList(
              id: value.id,
              nim: value.nim,
              nomorSurat: value.nomorSurat,
              tanggalPengajuan: value.tanggalPengajuan,
              jenisSurat: value.jenisSurat,
              namaPemohon: value.namaPemohon,
              tujuan: value.tujuan,
              statusSurat: value.statusSurat,
              v: value.v,
              keterangan: value.keterangan));
        }
        setBusy(false);
      }
    }
  }
}
