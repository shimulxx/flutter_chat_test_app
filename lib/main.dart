import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_test_app/app_constants/app_constants.dart';
import 'package:flutter_chat_test_app/injection_work.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/controller/list_screen_cubit.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/controller/list_screen_state.dart';
import 'package:flutter_chat_test_app/screen/chat_list_screen/data_model/chat_item_data.dart';
import 'app_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  registerAllDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: const ColorScheme.dark(primary: Colors.white)),
      onGenerateRoute: di<AppRouter>().onGenerateRoute,
    );
  }
}











