import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:uas_ppl_2024/const.dart';
import 'package:uas_ppl_2024/viewmodels/letter_viewmodel.dart';

import 'shared_styles.dart';

class LetterView extends StatefulWidget {
  const LetterView({super.key});

  @override
  State<LetterView> createState() => _LetterViewState();
}

class _LetterViewState extends State<LetterView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => LetterViewModel(),
        onViewModelReady: (model) => model.loginStatus,
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
                  Padding(
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
                  Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: Container(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          model.navigateTo(letterViewRoute);
                        },
                        child: Text(
                          'PENGAJUAN',
                          style: firstStyle,
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                  ),
                  SizedBox(
                    width: 200,
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    verticalSpaceLarge,
                    Text(
                      "PENGAJUAN SURAT",
                      style: secondStyle,
                    ),
                    verticalSpaceLarge,
                    verticalSpaceSmall,
                    Padding(
                      padding: const EdgeInsets.only(left: 200, right: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            width: 200,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/letter.png",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                                Text(
                                  "Surat Dispensasi",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2),
                                ),
                                verticalSpaceSmall,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return UnconstrainedBox(
                                            child: Container(
                                              height: 400,
                                              child: AlertDialog(
                                                title: Text('Surat Dispensasi'),
                                                content: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Nama Dosen',
                                                      ),
                                                      controller: model.namaDosenController,
                                                    ),
                                                    TextFormField(
                                                      controller: model.dateController,
                                                      readOnly: true,
                                                      onTap: () => model.selectDate(context),
                                                      decoration: InputDecoration(
                                                        labelText: 'Tanggal Pelaksanaan',
                                                        suffixIcon: Icon(Icons.calendar_today),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Ajukan'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      model.createLetterDispensasi();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "AJUKAN",
                                          style: firstStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            width: 200,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/letter.png",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                                Text(
                                  "Surat Penundaan Pembayaran",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2),
                                ),
                                verticalSpaceSmall,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return UnconstrainedBox(
                                            child: Container(
                                              height: 400,
                                              child: AlertDialog(
                                                title: Text('Surat Penundaan Pembayaran'),
                                                content: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Total Pembayaran',
                                                      ),
                                                      controller: model.totalPembayaranController,
                                                    ),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Ajukan'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      model.createLetterPenundaanPembayaran();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "AJUKAN",
                                          style: firstStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            width: 200,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/letter.png",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                                Text(
                                  "Surat Kerja Praktik",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2),
                                ),
                                verticalSpaceSmall,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return UnconstrainedBox(
                                            child: Container(
                                              height: 400,
                                              child: AlertDialog(
                                                title: Text('Surat Pengajuan Kerja Praktik'),
                                                content: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Nama Perusahaan',
                                                      ),
                                                      controller: model.tempatKpController,
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Alamat Perusahaan'
                                                      ),
                                                      controller: model.alamatKpController,
                                                    )
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Ajukan'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      model.createLetterKerjaPraktik();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "AJUKAN",
                                          style: firstStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            width: 200,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/letter.png",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                                Text(
                                  "Surat Penelitian",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2),
                                ),
                                verticalSpaceSmall,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return UnconstrainedBox(
                                            child: Container(
                                              height: 400,
                                              child: AlertDialog(
                                                title: Text('Surat Pengajuan Penelitian'),
                                                content: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Judul Penelitian',
                                                      ),
                                                      controller: model.judulPenelitianController,
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Tempat Penelitian'
                                                      ),
                                                      controller: model.tempatPenelitianController,
                                                    )
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Ajukan'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      model.createLetterPenelitian();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "AJUKAN",
                                          style: firstStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 200, right: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            width: 200,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/letter.png",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                                Text(
                                  "Surat Peminjaman Kelas",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2),
                                ),
                                verticalSpaceSmall,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return UnconstrainedBox(
                                            child: Container(
                                              height: 440,
                                              child: AlertDialog(
                                                title: Text('Surat Peminjaman Kelas'),
                                                content: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      readOnly: true,
                                                      controller: model.awalPeminjamanController,
                                                      onTap: () {
                                                        DatePicker.showDateTimePicker(
                                                          context,
                                                          showTitleActions: true,
                                                          onConfirm: (date) {
                                                            setState(() {
                                                              model.startDate = date;
                                                              model.awalPeminjamanController.text =
                                                                  DateFormat('yyyy-MM-dd HH:mm').format(model.startDate);
                                                            });
                                                          },

                                                          currentTime: DateTime.now(),
                                                            locale: LocaleType.id
                                                        );
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: 'Waktu Mulai',
                                                        suffixIcon: Icon(Icons.calendar_today),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      readOnly: true,
                                                      controller: model.akhirPeminjamanController,
                                                      onTap: () {
                                                        DatePicker.showDateTimePicker(
                                                          context,
                                                          showTitleActions: true,
                                                          onConfirm: (date) {
                                                            setState(() {
                                                              model.endDate = date;
                                                              model.akhirPeminjamanController.text =
                                                                  DateFormat('yyyy-MM-dd HH:mm').format(model.endDate);
                                                            });
                                                          },
                                                          currentTime: DateTime.now(),
                                                            locale: LocaleType.id
                                                        );
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: 'Waktu Selesai',
                                                        suffixIcon: Icon(Icons.calendar_today),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                          labelText: 'Ruangan Yang Dipinjam'
                                                      ),
                                                      controller: model.ruanganController,
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                          labelText: 'Tujuan Peminjaman'
                                                      ),
                                                      controller: model.tujuanPeminjamanController,
                                                    )
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Ajukan'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      model.createLetterPeminjamanKelas();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "AJUKAN",
                                          style: firstStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            width: 200,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/letter.png",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                                Text(
                                  "Surat Perbaikan Nilai",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2),
                                ),
                                verticalSpaceSmall,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return UnconstrainedBox(
                                            child: Container(
                                              height: 400,
                                              child: AlertDialog(
                                                title: Text('Surat Perbaikan Nilai'),
                                                content: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Mata Kuliah',
                                                      ),
                                                      controller: model.mataKuliahController,
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                          labelText: 'Semester'
                                                      ),
                                                      controller: model.semesterController,
                                                    )
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Ajukan'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      model.createLetterPerbaikanNilai();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "AJUKAN",
                                          style: firstStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            width: 200,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/letter.png",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                                Text(
                                  "Surat Permohonan",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2),
                                ),
                                verticalSpaceSmall,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return UnconstrainedBox(
                                            child: Container(
                                              height: 400,
                                              child: AlertDialog(
                                                title: Text('Surat Permohonan'),
                                                content: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Keterangan',
                                                      ),
                                                      controller: model.tujuanController,
                                                    ),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Ajukan'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      model.createLetterPermohonan();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "AJUKAN",
                                          style: firstStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            width: 200,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/letter.png",
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
                                Text(
                                  "Surat Pengunduran Diri",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 2),
                                ),
                                verticalSpaceSmall,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return UnconstrainedBox(
                                            child: Container(
                                              height: 400,
                                              child: AlertDialog(
                                                title: Text('Surat Pengunduran Diri'),
                                                content: Column(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Alasan',
                                                      ),
                                                      controller: model.alasanController,
                                                    ),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Ajukan'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      model.createLetterPengunduranDiri();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "AJUKAN",
                                          style: firstStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpaceTiny,
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
                                color: Colors.white,
                                fontSize: 12,
                                letterSpacing: 2),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
