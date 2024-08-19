import 'package:hamonapp/Pages/DashBoard/Screens.dart';
import 'package:get/get.dart';
import 'package:hamonapp/Pages/RegistrationPage/Screens.dart';
import '../Pages/ClassRooms/Screens.dart';
import '../Pages/StudentsPage/Screens.dart';
import '../Pages/SubjectsPage/Screens.dart';
import 'ConstantRoutes.dart';

class Routes {
  static List<GetPage> allRoutes = [
    GetPage<dynamic>(
        name: ConstantRoutes.dashboard,
        page: () => const DashBoardScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.students,
        page: () => const StudentsScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.subject,
        page: () => const SubjectsScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.classroom,
        page: () => const ClassRoomScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.register,
        page: () => const RegisterScreens(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
   ];
}
