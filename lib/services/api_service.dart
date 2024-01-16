import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:uas_ppl_2024/models/create_letter_response_model.dart';
import 'package:uas_ppl_2024/models/get_letter_response_model.dart';
import 'dart:convert';

import 'package:uas_ppl_2024/models/login_response_model.dart';

class ApiService {
  final baseUrlUser = "192.168.10.165/api";

  Future<LoginResponseModel?> login(
    String nim,
    String password,
  ) async {
    print(nim);
    print(password);
    final client = http.Client();
    try {
      final url = Uri.parse('$baseUrlUser/login');
      var body = jsonEncode({"nim": nim, "password": password});
      final response = await client.post(
        headers: {
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
      String letterNumber,
      String applyDate,
      String letterType,
      String applicantName,
      String destination,
      String letterStatus,
      String description) async {
    final client = http.Client();
    try {
      final url = Uri.parse('$baseUrlUser/surat');
      var body = jsonEncode({
        {
          "nim": "20211320016",
          "nomor_surat": "101",
          "tanggal_pengajuan": "2024-01-15",
          "jenis_surat": "Surat Penundaan Pembayaran",
          "nama_pemohon": "Muhammad Rizki Fahreza",
          "tujuan": "WR 2 Keuangan",
          "status_surat": "Pending",
          "keterangan": "Rp. 180000"
        }
      });
      final response = await client.post(
        headers: {
          'Content-Type': 'application/json',
        },
        url,
        body: body,
      );
      final responseData = createLetterResponseModelFromJson(response.body);

      return responseData;
    } catch (e) {
      return null;
    }
  }

  Future<GetLetterResponseModel?> getLetter(String nim) async {
    final client = http.Client();
    try {
      final url = Uri.parse('$baseUrlUser/surat/$nim');
      final response = await client.get(
        url,
      );
      final responseData = getLetterResponseModelFromJson(response.body);

      return responseData;
    } catch (e) {
      return null;
    }
  }
}
