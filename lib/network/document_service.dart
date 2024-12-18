import 'package:mobile_ung/dto/document/document.income.dto.dart';
import 'package:mobile_ung/dto/document/document.list.dto.dart';
import 'package:mobile_ung/dto/document/document.list.resolution.dto.dart';

import '../http.dart';

class DocumentService {
  static Future<DocumentListDto> getDocumentIncome({IncomeDocumentsBody data = IncomeDocumentsBody.initial}) async {
    final response = await api.post('/universal-document/income', data: data.toJson());
    final responseData = DocumentListDto.fromJson(response.data);

    return responseData;
  }

  Future<DocumentListDto> getDocumentSend({IncomeDocumentsBody data = IncomeDocumentsBody.initial}) async {
    final response = await api.post('/universal-document/send', data: data.toJson());
    final responseData = DocumentListDto.fromJson(response.data);

    return responseData;
  }

  static Future<DocumentListResolutionDto> getDocumentRegistration({IncomeDocumentsBody data = IncomeDocumentsBody.initial}) async {
    final response = await api.post('/document-registration/list-send', data: data.toJson(), queryParameters: {'type': 'REGISTRATION'});
    final responseData = DocumentListResolutionDto.fromJson(response.data);

    return responseData;
  }

  static Future<DocumentListResolutionDto> getDocumentResolution({IncomeDocumentsBody data = IncomeDocumentsBody.initial}) async {
    final response = await api.post('/document-resolution/list', data: data.toJson());
    final responseData = DocumentListResolutionDto.fromJson(response.data);

    return responseData;
  }

  Future<String> getBase64(int id) async {
    final response = await api.get('/universal-document/pdf-by-id/$id');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load PDF');
    }
  }
}
