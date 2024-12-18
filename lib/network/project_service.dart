import 'dart:convert';

import 'package:mobile_ung/dto/document/document.income.dto.dart';
import 'package:mobile_ung/dto/project-menu/project.dto.dart';
import 'package:mobile_ung/dto/project-menu/project.list.dto.dart';

import '../http.dart';

class ProjectService {
  Future<ProjectListDto> getProjectList({IncomeDocumentsBody data = IncomeDocumentsBody.initial, String value = ''}) async {
    final response = await api.post('/project/list?search=$value', data: data.toJson());

    final Map<String, dynamic> jsonMap = json.decode(response.toString());
    final responseData = ProjectListDto.fromJson(jsonMap);

    return responseData;
  }

  Future<ProjectListDto> getProjectListByYur({IncomeDocumentsBody data = IncomeDocumentsBody.initial, String value = ''}) async {
    final response = await api.post('/project/list-by-yur?search=$value', data: data.toJson());

    final Map<String, dynamic> jsonMap = json.decode(response.toString());
    final responseData = ProjectListDto.fromJson(jsonMap);

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

  Future<ProjectDto> getProjectById(int id) async {
    final response = await api.get('/project/get-by-id/$id');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.toString());
      final responseData = ProjectDto.fromJson(jsonMap);

      return responseData;
    } else {
      throw Exception('Failed to load Dto');
    }
  }
}
