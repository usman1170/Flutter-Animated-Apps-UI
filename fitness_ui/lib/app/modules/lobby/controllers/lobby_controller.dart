import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LobbyController extends GetxController {
  final RxString selectedAvatarPath = ''.obs;
  static const String _avatarKey = 'selected_avatar_path';

  @override
  void onInit() {
    super.onInit();
    _loadSavedAvatar();
  }

  Future<void> _loadSavedAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString(_avatarKey);
    if (savedPath != null && savedPath.isNotEmpty) {
      selectedAvatarPath.value = savedPath;
    }
  }

  Future<void> updateAvatar(String newPath) async {
    selectedAvatarPath.value = newPath;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_avatarKey, newPath);
  }
}
