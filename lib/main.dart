import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_crossplatform/body.dart';
import 'package:todo_app_crossplatform/providers/todo_provider.dart';
import 'package:todo_app_crossplatform/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(
    fileName: '.env'
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      builder: (context, child) => const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: defaultTheme,
        home: const DefaultTabController(
          length: 2,
          child: Body(),
        ));
  }
}
