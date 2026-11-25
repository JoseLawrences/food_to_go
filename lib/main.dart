import 'package:flutter/material.dart';

import 'viewmodels/food_to_go_viewmodel.dart';
import 'views/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FoodToGoApp());
}

class FoodToGoApp extends StatefulWidget {
  const FoodToGoApp({super.key});

  @override
  State<FoodToGoApp> createState() => _FoodToGoAppState();
}

class _FoodToGoAppState extends State<FoodToGoApp> {
  late final FoodToGoViewModel viewModel;
  late final Future<void> initialization;

  @override
  void initState() {
    super.initState();

    viewModel = FoodToGoViewModel();
    initialization = viewModel.initialize();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food to Go',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: FutureBuilder<void>(
        future: initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('Unable to load saved app data.'),
              ),
            );
          }

          return HomeScreen(viewModel: viewModel);
        },
      ),
    );
  }
}
