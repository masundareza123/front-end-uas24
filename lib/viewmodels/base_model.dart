import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;

  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  DateTime? _currentBackPressTime;


  Future<bool> onWillPop(BuildContext context) async {
    DateTime now = DateTime.now();

    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tekan kembali untuk keluar'),
        ),
      );

      return false;
    }
    return true;
  }
}
