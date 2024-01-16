import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:uas_ppl_2024/models/create_letter_response_model.dart';
import 'package:uas_ppl_2024/models/get_letter_response_model.dart';
import 'dart:convert';

import 'package:uas_ppl_2024/models/login_response_model.dart';

class ApiService {
  final baseUrlUser = "http://reza.software-creative-indonesia.my.id/api";

  Future<LoginResponseModel?> login(
    String nim,
    String password,
  ) async {
    final client = http.Client();
    try {
      final url = Uri.parse('$baseUrlUser/login');
      var body = jsonEncode({"nim": nim, "password": password});
      final response = await client.post(
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
        },
        url,
        body: body,
      );
      print('Response body: ${response.body}');
      final responseData = loginResponseModelFromJson(response.body);
      return responseData;
    } catch (e, s) {
      print('[Login] error occurred $e | $s');
      return null;
    }
  }

  Future<CreateLetterResponseModel?> createLetter(
      String nim,
      String nomorSurat,
      String tanggalPengajuan,
      String jenisSurat,
      String namaPemohon,
      String tujuan,
      String statusSurat,
      String keterangan,
      String nomorTelepon,
      ) async {
    final client = http.Client();
    print("object");
    try {
      final url = Uri.parse('$baseUrlUser/surat');
      var body = jsonEncode({

          "nim": nim,
          "nomor_surat": nomorSurat,
          "tanggal_pengajuan": tanggalPengajuan,
          "jenis_surat": jenisSurat,
          "nama_pemohon": namaPemohon,
          "tujuan": tujuan,
          "status_surat": statusSurat,
          "keterangan": keterangan,
          "nomor_telepon": nomorTelepon

      });
      final response = await client.post(
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
        },
        url,
        body: body,
      );
      final responseData = createLetterResponseModelFromJson(response.body);
      print(response.body);
      return responseData;
    } catch (e, s) {
      print("[Create Surat $e | $s");
      return null;
    }
  }

  Future<GetLetterResponseModel?> getLetter(String nim) async {
    final client = http.Client();
    try {
      final url = Uri.parse('$baseUrlUser/surat/$nim');
      final response = await client.post(
        url,
      );
      final responseData = getLetterResponseModelFromJson(response.body);
      print(response.body);
      return responseData;
    } catch (e,s) {
      print("[Get Letter] $e | $s");
      return null;
    }
  }
}
