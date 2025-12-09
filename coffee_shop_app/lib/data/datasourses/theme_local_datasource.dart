import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  Future<void> cacheTheme(String themeName);
  Future<String> getCachedTheme();
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const THEME_KEY = 'THEME_MODE';

  ThemeLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheTheme(String themeName) {
    return sharedPreferences.setString(THEME_KEY, themeName);
  }

  @override
  Future<String> getCachedTheme() {
    final themeName = sharedPreferences.getString(THEME_KEY);
    // إذا لم يتم حفظ قيمة من قبل، أرجع 'system'
    return Future.value(themeName ?? 'system');
  }
}
