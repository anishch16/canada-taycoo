import 'package:get/get.dart';
import '../modules/scanner_page/bindings/scanner_page_binding.dart';
import '../modules/scanner_page/views/scanner_page_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGNIN;

  static final routes = [
    GetPage(
      name: _Paths.SCANNER_PAGE,
      page: () => const ScannerPageView(),
      binding: ScannerPageBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
    ),
  ];
}
