// GENERATED FILE - DO NOT EDIT

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:twafok/features/attendance/attendance_di.dart';
import 'package:twafok/features/bottom_nav_bar/bottom_nav_bar_di.dart';
import 'package:twafok/features/buffet/buffet_di.dart';
import 'package:twafok/features/chats/chats_di.dart';
import 'package:twafok/features/others/course_request/course_request_di.dart';
import 'package:twafok/features/others/loan_request/loan_request_di.dart';
import 'package:twafok/features/others/promotion_request/promotion_request_di.dart';
import 'package:twafok/features/permissions/mission/mission_di.dart';
import 'package:twafok/features/permissions/permit_exit_temporary/permit_exit_temporary_di.dart';
import 'package:twafok/features/permissions/settlement/settlement_di.dart';
import 'package:twafok/features/permissions/vacation/vacation_di.dart';
import 'package:twafok/features/profile/profile_di.dart';
import 'package:twafok/features/registration/registration_di.dart';
import 'package:twafok/features/tasks/tasks_di.dart';

final di = GetIt.instance;

class ServicesLocator {
  void init() {
    debugPrint('Initializing ServicesLocator...');

    AttendanceDI();
    RegistrationDI();
    TasksDI();
    BottomNavBarDI();
    CourseRequestDI();
    PromotionRequestDI();
    LoanRequestDI();
    PermitExitTemporaryDI();
    SettlementDI();
    MissionDI();
    VacationDI();
    ProfileDI();
    ChatsDI();
    BuffetDI();

    debugPrint('ServicesLocator initialized successfully!');
  }
}
