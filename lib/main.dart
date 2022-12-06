// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './settings.dart';
import './poke_list.dart';
import './models/theme_mode.dart';
import './models/pokemon.dart';
import './models/favorite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  // final themeModeNotifier = ThemeModeNotifier(pref);
  // final pokemonsNotifier = PokemonsNotifier();
  // final favoritesNotifier = FavoritesNotifier();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  Widget build(BuildContext context, WidgetRef ref) {
    List<ThemeMode> mode = ref.watch(themeModesProvider);
    return MaterialApp(
      title: 'Pokemon Flutter',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: mode,
      home: const TopPage(),
    );
  }
}

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int currentbnb = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          children: const [PokeList(), Settings()],
          index: currentbnb,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          setState(
            () => currentbnb = index,
          )
        },
        currentIndex: currentbnb,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
    );
  }
}
