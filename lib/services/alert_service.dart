import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'navigation_service.dart';

class AlertService {
  final NavigationService _navigationService = NavigationService();

  void successAlert(String title, String desc, VoidCallback onCancel) {
    showDialog(
      context: _navigationService.navigationKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          icon: SvgPicture.asset('assets/success.svg'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18
            ),
          ),
          content: Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: 14
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: onCancel,
              child: const Text(
                'Tutup',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  void failedAlert(String title, String desc, VoidCallback onCancel) {
    showDialog(
      context: _navigationService.navigationKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          icon: SvgPicture.asset('assets/failed.svg'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18
            ),
          ),
          content: Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: 14
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: onCancel,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFFF4545)
              ),
              child: const Text(
                'Tutup',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  void warningAlert(String title, String desc, VoidCallback onCancel) {
    showDialog(
      context: _navigationService.navigationKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          icon: Image.asset('assets/warning.png', height: 80, width: 80,),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18
            ),
          ),
          content: Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: 14
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: onCancel,
              style: TextButton.styleFrom(
                backgroundColor: Colors.amber
              ),
              child: const Text(
                'Tutup',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  void choiceAlert(String title, String desc, String choice, VoidCallback onYes, VoidCallback onCancel) {
    showDialog(
      context: _navigationService.navigationKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        icon: SvgPicture.asset('assets/questionMark.svg'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18
          ),
        ),
        content: Text(
          desc,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w400,
            fontSize: 14
          ),
        ),
        actions: [
          TextButton(
            onPressed: onYes,
            child: Text(
              choice,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xFFFF4545),
                  fontWeight: FontWeight.w400,
                  fontSize: 14
              ),
            ),
          ),
          TextButton(
            onPressed: onCancel,
            child: const Text(
              'Batal',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14
              ),
            ),
          )
        ],
      )
    );
  }

}
