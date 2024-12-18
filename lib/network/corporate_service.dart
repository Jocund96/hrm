import 'dart:convert';

import 'package:mobile_ung/dto/corporate/corporate.list.dto.dart';
import 'package:mobile_ung/dto/document/document.income.dto.dart';

import '../http.dart';

class CorporateService {
  // ignore: prefer_single_quotes
  Future<CorporateListDto> getCorporateList({IncomeDocumentsBody data = IncomeDocumentsBody.initial, String value = ""}) async {
    final response = await api.post('/employee-work/corporate-directory?search=$value', data: data.toJson());

    final Map<String, dynamic> jsonMap = json.decode(response.toString());
    final responseData = CorporateListDto.fromJson(jsonMap);

    // PaginationDto.initial.toJson()

    return responseData;
  }

  Future<String> getBase64(int id) async {
    final response = await api.get('/universal-document/pdf-by-id/$id');

    if (response.statusCode == 200) {
      // Assuming the response body contains the Base64 string
      return response.data;
    } else {
      throw Exception('Failed to load PDF');
    }
  }
}
