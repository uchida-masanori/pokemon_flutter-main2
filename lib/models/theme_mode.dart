import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/theme_mode.dart';

// StateNotifier のステート（状態）はイミュータブル（不変）である必要があります。
// ここは Freezed のようなパッケージを利用してイミュータブルにしても OK です。
@immutable
class ThemeMode {
  const ThemeMode({required this.mode});

  // イミュータブルなクラスのプロパティはすべて `final` にする必要があります。
  final ThemeMode? mode;

  // Todo はイミュータブルであり、内容を直接変更できないためコピーを作る必要があります。
  // これはオブジェクトの各プロパティの内容をコピーして新たな Todo を返すメソッドです。
  ThemeMode copyWith({ThemeMode? mode}) {
    return ThemeMode(
      mode: mode ?? this.mode,
    );
  }
}

class ThemeModesNotifier extends StateNotifier<ThemeMode> {
  ThemeModesNotifier() : super(mode!);

  static ThemeMode? get mode => null;
  // ThemeMode _themeMode;

  // ThemeMode get mode => _themeMode;

  void _init(SharedPreferences pref) async {
    ThemeMode mode = (await loadThemeMode(pref)) as ThemeMode;
    mode;
  }

  void update(ThemeMode nextMode) {
    // _themeMode.copyWith(mode: !mode.mode);
    ThemeMode mode = nextMode;
    mode;
  }
}

// 最後に TodosNotifier のインスタンスを値に持つ StateNotifierProvider を作成し、
// UI 側から Todo リストを操作することを可能にします。
final themeModesProvider =
    StateNotifierProvider<ThemeModesNotifier, ThemeMode>((ref) {
  return ThemeModesNotifier();
});
