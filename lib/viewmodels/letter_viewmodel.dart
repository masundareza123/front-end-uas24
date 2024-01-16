import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  final TextEditingController namaDosenController = TextEditingController();
  final TextEditingController tglPelaksanaanController =
      TextEditingController();

  final TextEditingController totalPembayaranController =
      TextEditingController();

  final TextEditingController tempatKpController = TextEditingController();
  final TextEditingController alamatKpController = TextEditingController();

  final TextEditingController judulPenelitianController =
      TextEditingController();
  final TextEditingController tempatPenelitianController =
      TextEditingController();

  final TextEditingController tanggalPeminjamanController =
      TextEditingController();
  final TextEditingController waktuPeminjamanController =
      TextEditingController();
  final TextEditingController tujuanPeminjamanController =
      TextEditingController();

  final TextEditingController semesterController = TextEditingController();
  final TextEditingController mataKuliahController = TextEditingController();

  final TextEditingController tujuanController = TextEditingController();

  final TextEditingController alasanController = TextEditingController();

  String formatDateTimeNow() {
    DateTime now = DateTime.now();
    var format = DateFormat('EEEE, d MMMM yyyy | HH:mm WIB', 'id_ID');
    String formattedDate = format.format(now);
    print(formattedDate);
    return formattedDate;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
        selectedDate = picked;
        dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      setBusy(false);
    }
  }

  bool loginStatus = false;

  void statusLogged() async {
    loginStatus = await _localStorageService.getBool(localStatusLogin) ?? false;
    setBusy(false);
  }

  void navigateTo(routeName) {
    _navigationService.navigateTo(routeName);
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

  void createLetterDispensasi() async {
    if (namaDosenController.text.isEmpty ||
        dateController.text.isEmpty) {
      _alertService.warningAlert("Perhatian", "Lengkapi data pengajuan", () {
        _navigationService.pop();
      });
    } else {
      final nim = await _localStorageService.getString(localNimUser);
      final nomorTelepon =
          await _localStorageService.getString(localPhoneNumberUser);
      final namaPemohon = await _localStorageService.getString(localNameUser);
      print(nim);
      print(nomorTelepon);
      print(namaPemohon);
      final data = await _apiService.createLetter(
          nim!,
          "$nim-${DateTime.now().toString()}",
          formatDateTimeNow(),
          "Surat Dispensasi",
          namaPemohon!,
          "-",
          "waiting",
          "${namaDosenController.text} | ${dateController.text}",
          nomorTelepon!,);
      if(data == null){
        _alertService.failedAlert("Gagal", "Internal server error", () {_navigationService.pop();});
      } else {
        if (data.success == true) {
          _alertService.successAlert("Berhasil", "Surat pengajuan telah dibuat",
                  () {
                _navigationService.replaceTo(homeViewRoute);
              });
        } else {
          _alertService.failedAlert("Gagal", data.message!, () {
            _navigationService.pop();
          });
        }
      }
    }
  }
}
