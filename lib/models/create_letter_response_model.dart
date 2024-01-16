// To parse this JSON data, do
//
//     final createLetterResponseModel = createLetterResponseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateLetterResponseModel createLetterResponseModelFromJson(String str) => CreateLetterResponseModel.fromJson(json.decode(str));

String createLetterResponseModelToJson(CreateLetterResponseModel data) => json.encode(data.toJson());

class CreateLetterResponseModel {
  bool success;
  String message;
  Surat surat;

  CreateLetterResponseModel({
    required this.success,
    required this.message,
    required this.surat,
  });

  factory CreateLetterResponseModel.fromJson(Map<String, dynamic> json) => CreateLetterResponseModel(
    success: json["success"],
    message: json["message"],
    surat: Surat.fromJson(json["surat"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "surat": surat.toJson(),
  };
}

class Surat {
  String nim;
  String nomorSurat;
  DateTime tanggalPengajuan;
  String jenisSurat;
  String namaPemohon;
  String tujuan;
  String statusSurat;
  String keterangan;
  String id;
  int v;

  Surat({
    required this.nim,
    required this.nomorSurat,
    required this.tanggalPengajuan,
    required this.jenisSurat,
    required this.namaPemohon,
    required this.tujuan,
    required this.statusSurat,
    required this.keterangan,
    required this.id,
    required this.v,
  });

  factory Surat.fromJson(Map<String, dynamic> json) => Surat(
    nim: json["nim"],
    nomorSurat: json["nomor_surat"],
    tanggalPengajuan: DateTime.parse(json["tanggal_pengajuan"]),
    jenisSurat: json["jenis_surat"],
    namaPemohon: json["nama_pemohon"],
    tujuan: json["tujuan"],
    statusSurat: json["status_surat"],
    keterangan: json["keterangan"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "nim": nim,
    "nomor_surat": nomorSurat,
    "tanggal_pengajuan": "${tanggalPengajuan.year.toString().padLeft(4, '0')}-${tanggalPengajuan.month.toString().padLeft(2, '0')}-${tanggalPengajuan.day.toString().padLeft(2, '0')}",
    "jenis_surat": jenisSurat,
    "nama_pemohon": namaPemohon,
    "tujuan": tujuan,
    "status_surat": statusSurat,
    "keterangan": keterangan,
    "_id": id,
    "__v": v,
  };
}
