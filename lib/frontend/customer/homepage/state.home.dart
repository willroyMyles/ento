import 'package:ento/frontend/customer/companies/view.companies.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeState extends GetxController {
  final views = [CompaniesView(), CompaniesView()];
}
