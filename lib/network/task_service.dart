import 'dart:convert';

import 'package:mobile_ung/dto/document/document.income.dto.dart';
import 'package:mobile_ung/dto/task/task.income.dto.dart';
import 'package:mobile_ung/dto/task/task.list.dto.dart';

import '../http.dart';

class TaskService {
  Future<TaskListDto> getTaskIncomeList({IncomeDocumentsBody data = IncomeDocumentsBody.initial, String value = ''}) async {
    final response = await api.post('/task/income?search=$value', data: data.toJson());

    final Map<String, dynamic> jsonMap = json.decode(response.toString());
    final responseData = TaskListDto.fromJson(jsonMap);

    // PaginationDto.initial.toJson()

    return responseData;
  }

  Future<TaskListDto> getTaskSendList({IncomeDocumentsBody data = IncomeDocumentsBody.initial, String value = ''}) async {
    final response = await api.post('/task/send?search=$value', data: data.toJson());

    final Map<String, dynamic> jsonMap = json.decode(response.toString());
    final responseData = TaskListDto.fromJson(jsonMap);

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

  Future<TaskIncomeDto> getTaskById(int id) async {
    final response = await api.get('/task/get-by-id/$id');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.toString());
      final responseData = TaskIncomeDto.fromJson(jsonMap);

      return responseData;
    } else {
      throw Exception('Failed to load Dto');
    }
  }
}
