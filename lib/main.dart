
import 'package:flutter/material.dart';
import 'viewmodels/food_to_go_viewmodel.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const FoodToGoApp());
}

class FoodToGoApp extends StatefulWidget {
  const FoodToGoApp({super.key});

  @override
  State<FoodToGoApp> createState() => _FoodToGoAppState();
}

class _FoodToGoAppState extends State<FoodToGoApp> {
  late final FoodToGoViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = FoodToGoViewModel();
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
      home: HomeScreen(viewModel: viewModel),
    );
  }
}
