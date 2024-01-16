// To parse this JSON data, do
//
//     final loginTokenModel = loginTokenModelFromJson(jsonString);

import 'dart:convert';

LoginTokenModel loginTokenModelFromJson(String str) => LoginTokenModel.fromJson(json.decode(str));

String loginTokenModelToJson(LoginTokenModel data) => json.encode(data.toJson());

class LoginTokenModel {
  String? id;
  String? nim;
  String? namaLengkap;
  String? programStudi;
  String? nomorTelepon;
  int? iat;

  LoginTokenModel({
    this.id,
    this.nim,
    this.namaLengkap,
    this.programStudi,
    this.nomorTelepon,
    this.iat,
  });

  factory LoginTokenModel.fromJson(Map<String, dynamic> json) => LoginTokenModel(
    id: json["_id"],
    nim: json["nim"],
    namaLengkap: json["nama_lengkap"],
    programStudi: json["program_studi"],
    nomorTelepon: json["nomor_telepon"],
    iat: json["iat"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nim": nim,
    "nama_lengkap": namaLengkap,
    "program_studi": programStudi,
    "nomor_telepon": nomorTelepon,
    "iat": iat,
  };
}
