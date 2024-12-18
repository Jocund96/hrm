import 'dart:convert';

import 'package:mobile_ung/dto/project-dashboard/project.dashboard.dto.dart';

import '../dto/project-task/project.task.list.dto.dart';
import '../http.dart';

class DashboardService {
  // ignore: prefer_single_quotes
  Future<ProjectTaskListDto> getProjectTaskData({IncomeDocumentsBody data = IncomeDocumentsBody.initial, String value = ""}) async {
    final response = await api.post('/project-task/my-task-list?search=$value', data: data.toJson());

    final Map<String, dynamic> jsonMap = json.decode(response.toString());
    final responseData = ProjectTaskListDto.fromJson(jsonMap);

    return responseData;
  }

  Future<ProjectDashboardDto> getProjectDashboardParentData() async {
    final response = await api.post('/project-dashboard/parent');

    final Map<String, dynamic> jsonMap = json.decode(response.toString());
    final responseData = ProjectDashboardDto.fromJson(jsonMap);

    return responseData;
  }

  Future<ProjectDashboardDto> getProjectDashboardSubData() async {
    final response = await api.post('/project-dashboard/sub');

    final Map<String, dynamic> jsonMap = json.decode(response.toString());
    final responseData = ProjectDashboardDto.fromJson(jsonMap);

    return responseData;
  }

  Future<ProjectDashboardDto> getProjectDashboardTaskData() async {
    final response = await api.post('/project-dashboard/task');

    final Map<String, dynamic> jsonMap = json.decode(response.toString());
    final responseData = ProjectDashboardDto.fromJson(jsonMap);

    return responseData;
  }

  Future<ProjectDashboardDto> getProjectDashboardSubTaskData() async {
    final response = await api.post('/project-dashboard/sub-task');

    final Map<String, dynamic> jsonMap = json.decode(response.toString());
    final responseData = ProjectDashboardDto.fromJson(jsonMap);

    return responseData;
  }
}
