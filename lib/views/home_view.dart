import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:uas_ppl_2024/services/alert_service.dart';
import 'package:uas_ppl_2024/services/api_service.dart';
import 'package:uas_ppl_2024/services/local_storage_service.dart';
import 'package:uas_ppl_2024/services/navigation_service.dart';
import 'package:uas_ppl_2024/viewmodels/home_viewmodel.dart';
import 'package:uas_ppl_2024/views/letter_view.dart';

import '../const.dart';
import '../locator.dart';
import 'shared_styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.statusLogged(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: Container(
            width: 40,
            height: 40,
            child: Image.asset("assets/Logo UKRI.png", fit: BoxFit.cover),
          ),
          leadingWidth: 100,
          toolbarHeight: 100,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SISTEM INFORMASI UNIT",
                style: firstStyle,
              ),
              verticalSpaceSuperTiny,
              Text(
                "TATA USAHA FAKULTAS (TUFAK)",
                style: firstStyle,
              ),
            ],
          ),
          actions: [
            Visibility(
              visible: model.loginStatus,
              child: Padding(
                padding: EdgeInsets.only(right: 25),
                child: Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      model.navigateTo(homeViewRoute);
                    },
                    child: Text(
                      'BERANDA',
                      style: firstStyle,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: model.loginStatus,
              child: Padding(
                padding: EdgeInsets.only(right: 25),
                child: Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LetterView()),
                      );
                    },
                    child: Text(
                      'PENGAJUAN',
                      style: firstStyle,
                    ),
                  ),
                ),
              ),
            ),
            model.loginStatus == true ? Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              padding: EdgeInsets.all(10),
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: InkWell(
                  onTap: () {
                    model.logOut();
                  },
                  child: Text(
                    "Logout",
                    style: firstStyle,
                  ),
                ),
              ),
            ) : Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              padding: EdgeInsets.all(10),
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return UnconstrainedBox(
                          child: Container(
                            height: 400,
                            child: AlertDialog(
                              title: Text('Form Login'),
                              content: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'NIM',
                                    ),
                                    controller: model.nimController,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                    ),
                                    controller: model.passwordController,
                                    obscureText: true,
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Login'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    model.loginUser();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    "LOGIN",
                    style: firstStyle,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpaceMassive,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 400,
                    child: Column(
                      children: [
                        Text(
                          "Sistem Informasi Unit Tata Usaha Fakultas (TUFAK)",
                          style: secondStyle,
                        ),
                        verticalSpaceSmall,
                        Text(
                          "Sistem yang dirancang khusus untuk memfasilitasi proses administrasi fakultas, dimana pada sistem tersebut dapat melakukan pengajuan, pelacakan, melihat riwayat, dan mencetak surat",
                          style: thirdStyle,
                        ),
                        verticalSpaceMedium,
                        Visibility(
                          visible: model.loginStatus == false ? false : true,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LetterView()),
                                );
                              },
                              child: Container(
                                width: 200,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Pengajuan Surat",
                                    style: firstStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  horizontalSpaceMedium,
                  Container(
                    width: 400,
                    height: 400,
                    child: Image.asset("assets/study.png"),
                  )
                ],
              ),
              verticalSpaceMassive,
              verticalSpaceMassive,
              Visibility(
                visible: model.letterList.isNotEmpty ? true : false,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 220),
                        width: 400,
                        child: Text(
                          "TRACKING SURAT",
                          style: secondStyle,
                        ),
                      ),
                    ),
                    verticalSpaceLarge,
                    Container(
                      width: double.infinity,
                      color: Colors.orange,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          verticalSpaceMedium,
                          Text(
                          model.letterList.isNotEmpty ? model.letterList.last.jenisSurat! : "",
                            style: secondStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 300,
                                child: InkWell(
                                  onTap: () {
                                    print("Tap Before");
                                  },
                                  child: Icon(
                                    Icons.chevron_left,
                                    color: Colors.black54,
                                    size: 250,
                                  ),
                                ),
                              ),
                              horizontalSpaceSmall,
                              Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: model.letterList.isNotEmpty && model.letterList.last.statusSurat! == "waiting" ? Colors.deepPurple : Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/waiting.png",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover, // Adjust as needed
                                      ),
                                    ),
                                  ),
                                  verticalSpaceSmall,
                                  Text(
                                    "Waiting",
                                    style: fourthStyle,
                                  ),
                                ],
                              ),
                              horizontalSpaceSmall,
                              Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: model.letterList.isNotEmpty && model.letterList.last.statusSurat! == "process" ? Colors.deepPurple : Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/process.png",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover, // Adjust as needed
                                      ),
                                    ),
                                  ),
                                  verticalSpaceSmall,
                                  Text(
                                    "Process",
                                    style: fourthStyle,
                                  ),
                                ],
                              ),
                              horizontalSpaceSmall,
                              Column(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: model.letterList.isNotEmpty && model.letterList.last.statusSurat! == "finish" ? Colors.deepPurple : Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/finish.png",
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover, // Adjust as needed
                                      ),
                                    ),
                                  ),
                                  verticalSpaceSmall,
                                  Text(
                                    "Finish",
                                    style: fourthStyle,
                                  ),
                                ],
                              ),
                              horizontalSpaceSmall,
                              Container(
                                height: 300,
                                child: InkWell(
                                  onTap: () {
                                    print("Tap Next");
                                  },
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Colors.black54,
                                    size: 250,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceMassive,
                    Center(
                      child: Text(
                        "HISTORY SURAT",
                        style: secondStyle,
                      ),
                    ),
                    verticalSpaceMedium,
                    Container(
                      margin: EdgeInsets.only(left: 100, right: 100),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Disetujui",
                                style: firstStyle,
                              ),
                            ),
                          ),
                          verticalSpaceSmall,
                          Container(
                            child: Container(
                              height: 200,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pengajuan Seminar Proposal",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 2),
                                      ),
                                      verticalSpaceTiny,
                                      Text(
                                        "Senin, 15 Januari 2024 | 21.19 WIB",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 2),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Image.asset(
                                        "assets/approved.png",
                                        width: 100,
                                        height: 100,
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    verticalSpaceSmall,
                    Container(
                      margin: EdgeInsets.only(left: 100, right: 100),
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Ditolak",
                                style: firstStyle,
                              ),
                            ),
                          ),
                          verticalSpaceSmall,
                          Container(
                            child: Container(
                              height: 200,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pengajuan Seminar Proposal",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 2),
                                      ),
                                      verticalSpaceTiny,
                                      Text(
                                        "Senin, 15 Januari 2024 | 21.19 WIB",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 2),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                      "assets/rejected.png",
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpaceMassive,
              Container(
                padding: EdgeInsets.all(32),
                width: double.infinity,
                color: Colors.deepPurple,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/facebook.png"),
                        horizontalSpaceTiny,
                        Image.asset("assets/instagram.png"),
                        horizontalSpaceTiny,
                        Image.asset("assets/linkedin.png"),
                        horizontalSpaceTiny,
                        Image.asset("assets/tik-tok.png"),
                        horizontalSpaceTiny,
                        Image.asset("assets/twitter.png"),
                      ],
                    ),
                    verticalSpaceSmall,
                    Text(
                      "© 2024 TUFAK Inc. All rights reserved",
                      style: TextStyle(
                          color: Colors.white, fontSize: 12, letterSpacing: 2),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
