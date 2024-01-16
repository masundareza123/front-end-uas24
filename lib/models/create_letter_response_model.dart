// To parse this JSON data, do
//
//     final createLetterResponseModel = createLetterResponseModelFromJson(jsonString);

import 'dart:convert';

CreateLetterResponseModel createLetterResponseModelFromJson(String str) => CreateLetterResponseModel.fromJson(json.decode(str));

String createLetterResponseModelToJson(CreateLetterResponseModel data) => json.encode(data.toJson());

class CreateLetterResponseModel {
  bool? success;
  String? message;
  Surat? surat;

  CreateLetterResponseModel({
    this.success,
    this.message,
    this.surat,
  });

  factory CreateLetterResponseModel.fromJson(Map<String, dynamic> json) => CreateLetterResponseModel(
    success: json["success"],
    message: json["message"],
    surat: json["surat"] == null ? null : Surat.fromJson(json["surat"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "surat": surat?.toJson(),
  };
}

class Surat {
  String? nim;
  String? nomorSurat;
  String? tanggalPengajuan;
  String? jenisSurat;
  String? namaPemohon;
  String? tujuan;
  String? statusSurat;
  String? keterangan;
  String? nomorTelepon;
  String? id;
  int? v;

  Surat({
    this.nim,
    this.nomorSurat,
    this.tanggalPengajuan,
    this.jenisSurat,
    this.namaPemohon,
    this.tujuan,
    this.statusSurat,
    this.keterangan,
    this.nomorTelepon,
    this.id,
    this.v,
  });

  factory Surat.fromJson(Map<String, dynamic> json) => Surat(
    nim: json["nim"],
    nomorSurat: json["nomor_surat"],
    tanggalPengajuan: json["tanggal_pengajuan"],
    jenisSurat: json["jenis_surat"],
    namaPemohon: json["nama_pemohon"],
    tujuan: json["tujuan"],
    statusSurat: json["status_surat"],
    keterangan: json["keterangan"],
    nomorTelepon: json["nomor_telepon"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "nim": nim,
    "nomor_surat": nomorSurat,
    "tanggal_pengajuan": tanggalPengajuan,
    "jenis_surat": jenisSurat,
    "nama_pemohon": namaPemohon,
    "tujuan": tujuan,
    "status_surat": statusSurat,
    "keterangan": keterangan,
    "nomor_telepon": nomorTelepon,
    "_id": id,
    "__v": v,
  };
}