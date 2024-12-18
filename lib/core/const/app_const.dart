import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

abstract class AppConst {
  static const mail = 'uz.ung.docflow@gmail.com';
  static const appLink = 'https://docflow.ung.uz/';
  static const appName = 'UNG - Doc_flow';

  /// images
  static const background = 'assets/images/background.jpg';
  static const logo = 'assets/images/logo.png';
  static const logo0 = 'assets/images/logo0.png';
  static const logo1 = 'assets/images/logo1.png';
  static const noContent = 'assets/images/no_content.jpg';
  static const user_1 = 'assets/images/user.png';

  ///icons
  static const cooperative = 'assets/images/cooperative.png';
  static const cooperativeActive = 'assets/images/cooperativeActive.png';
  static const document = 'assets/images/document.png';
  static const documentActive = 'assets/images/documentActive.png';
  static const home = 'assets/images/home.png';
  static const homeActive = 'assets/images/homeActive.png';
  static const project = 'assets/images/project.png';
  static const projectActive = 'assets/images/projectActive.png';
  static const task = 'assets/images/task.png';
  static const taskActive = 'assets/images/taskActive.png';
  static const arrow = 'assets/images/arrow.png';
  static const plusActive = 'assets/images/plusActive.png';
  static const add = 'assets/images/add.png';
  static const search = 'assets/images/search-normal.png';
  static const profile = 'assets/images/profile.png';
  static const password = 'assets/images/password.png';
  static const appVersion = 'assets/images/app_version.png';
  static const translate = 'assets/images/translate.png';
  static const exit = 'assets/images/exit.png';
  static const user = 'assets/images/user.png';
  static const user_2 = 'assets/images/user_2.png';
  static const arrowRight = 'assets/images/arrow_right.png';
  static const arrowRightRed = 'assets/images/arrow_right_red.png';
  static const message = 'assets/images/message.png';
  static const checkbox = 'assets/images/checkbox.png';
  static const cOwner = 'assets/images/c_owner.png';
  static const clock = 'assets/images/clock.png';
  static const pdfImage = 'assets/images/pdf_image.png';
  static const eye = 'assets/images/eye.png';
  static const arrowDown = 'assets/images/arrow_down.png';
  static const calendar = 'assets/images/calendar.png';
  static const fileUpload = 'assets/images/upload_file.png';

  static const baseUrl = String.fromEnvironment('API_URL');
  static const eImzoUrl = String.fromEnvironment('EIMZO_URL');
}
