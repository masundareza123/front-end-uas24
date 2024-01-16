// To parse this JSON data, do
//
//     final getLetterResponseModel = getLetterResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetLetterResponseModel getLetterResponseModelFromJson(String str) => GetLetterResponseModel.fromJson(json.decode(str));

String getLetterResponseModelToJson(GetLetterResponseModel data) => json.encode(data.toJson());

class GetLetterResponseModel {
  bool success;
  List<SuratList> suratList;

  GetLetterResponseModel({
    required this.success,
    required this.suratList,
  });

  factory GetLetterResponseModel.fromJson(Map<String, dynamic> json) => GetLetterResponseModel(
    success: json["success"],
    suratList: List<SuratList>.from(json["suratList"].map((x) => SuratList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "suratList": List<dynamic>.from(suratList.map((x) => x.toJson())),
  };
}

class SuratList {
  String id;
  String nim;
  String nomorSurat;
  DateTime tanggalPengajuan;
  String jenisSurat;
  String namaPemohon;
  String tujuan;
  String statusSurat;
  int v;
  String keterangan;

  SuratList({
    required this.id,
    required this.nim,
    required this.nomorSurat,
    required this.tanggalPengajuan,
    required this.jenisSurat,
    required this.namaPemohon,
    required this.tujuan,
    required this.statusSurat,
    required this.v,
    required this.keterangan,
  });

  factory SuratList.fromJson(Map<String, dynamic> json) => SuratList(
    id: json["_id"],
    nim: json["nim"],
    nomorSurat: json["nomor_surat"],
    tanggalPengajuan: DateTime.parse(json["tanggal_pengajuan"]),
    jenisSurat: json["jenis_surat"],
    namaPemohon: json["nama_pemohon"],
    tujuan: json["tujuan"],
    statusSurat: json["status_surat"],
    v: json["__v"],
    keterangan: json["keterangan"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nim": nim,
    "nomor_surat": nomorSurat,
    "tanggal_pengajuan": "${tanggalPengajuan.year.toString().padLeft(4, '0')}-${tanggalPengajuan.month.toString().padLeft(2, '0')}-${tanggalPengajuan.day.toString().padLeft(2, '0')}",
    "jenis_surat": jenisSurat,
    "nama_pemohon": namaPemohon,
    "tujuan": tujuan,
    "status_surat": statusSurat,
    "__v": v,
    "keterangan": keterangan,
  };
}
