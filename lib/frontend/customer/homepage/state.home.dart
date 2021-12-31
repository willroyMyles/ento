import 'package:ento/frontend/customer/companies/view.companies.dart';
import 'package:ento/services/fbMessaging.service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeState extends GetxController {
  final views = [CompaniesView(), CompaniesView()];

  @override
  void onInit() {
    super.onInit();
    messagingService.initialize();
  }
}
