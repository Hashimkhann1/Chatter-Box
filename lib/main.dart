import 'package:chatter_box/firebase_options.dart';
import 'package:chatter_box/view/splash_view/splash_view.dart';
import 'package:chatter_box/view_model/bloc/current_user_bloc/current_user_bloc/current_user_bloc.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_bloc/loading_bloc.dart';
import 'package:chatter_box/view_model/bloc/pick_image_from_gallery/pick_image_bloc/pick_image_bloc.dart';
import 'package:chatter_box/view_model/chat_view_model/chat_view_model.dart';
import 'package:chatter_box/view_model/current_user_view_model/current_user_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoadingBloc()),
          BlocProvider(create: (_) => PickImageBloc(ChatViewModel())),
          BlocProvider(create: (_) => CurrentUserBloc(CurrentUserViewModel())
          )
        ],
        child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        // home: BottomNavigatorView()
        home: const SplashView()
    ));
  }
}

