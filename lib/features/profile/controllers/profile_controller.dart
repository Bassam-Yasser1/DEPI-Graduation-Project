import 'package:Boslah/core/functions/is_dark.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final fullName = ''.obs;
  final lightTheme = (!isDark()).obs;
  final isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  String splitName(String name) {
    if (name.isEmpty) return "";
    List<String> parts = name.trim().split(" ");

    if (parts.isEmpty) return "";
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
  }
}
