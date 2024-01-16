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

  final ScrollController scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  final nimController = TextEditingController();
  final passwordController = TextEditingController();

  int indexHistory = 0;
  bool loginStatus = false;

  List<SuratList> letterList = [];
  List<SuratList> letterListApproved = [];
  List<SuratList> letterListDeclined = [];

  Color colors = Colors.black;

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
          await _localStorageService.setString(
              localNameUser, response.namaLengkap!);
          await _localStorageService.setString(
              localProdiUser, response.programStudi!);
          await _localStorageService.setString(
              localPhoneNumberUser, response.nomorTelepon!);
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
    _alertService.choiceAlert("Logout", "Keluar dari halaman ini?", "Yes",
        () async {
      await _localStorageService.clearStorage();
      _navigationService.replaceTo(homeViewRoute);
    }, () {
      _navigationService.pop();
    });
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
          if (value.statusSurat == "finish") {
            letterListApproved.add(SuratList(
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
          if (value.statusSurat == "decline") {
            letterListDeclined.add(SuratList(
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
        }
        letterListApproved = letterListApproved.reversed.toList();
        letterListDeclined = letterListDeclined.reversed.toList();
        indexHistory = letterList.length - 1;
        setBusy(false);
      }
    }
  }

  void before() {
    if (indexHistory > 0) {
      indexHistory -= 1;
      colors = Colors.black;
      setBusy(false);
    } else {
      colors = Colors.black12;
      setBusy(false);
    }
    print("[Kurang] $indexHistory");
  }

  Future<void> after() async {
    print("[letter length] ${letterList.length}");
    if (letterList.length - 1 == indexHistory) {
      _alertService.warningAlert("Perhatian", "Semua data telah ditampilkan",
          () {
        _navigationService.pop();
      });
    } else {
      indexHistory += 1;
      setBusy(false);
    }
    print("[Tambah] $indexHistory");
  }
}
