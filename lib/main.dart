import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure_app/Utils/common_widget/app_string.dart';
import 'package:structure_app/Utils/routes/routes.dart';
import 'package:structure_app/Utils/routes/routes_name.dart';
import 'package:structure_app/features/Home/domain/bloc/home_bloc.dart';
import 'package:structure_app/features/InternetConnection/domain/bloc/network_bloc.dart';
import 'package:structure_app/features/Login/domain/bloc/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NetworkBloc()),
        BlocProvider(create: (BuildContext context) => LoginBloc()),
           BlocProvider(create: (BuildContext context) => HomeBloc()),
      ],
      child: MaterialApp(
        title: AppString.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue.shade800,
          hintColor: Colors.blue.shade800,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor:  Colors.blue.shade800),
        ),
        initialRoute: RoutesName.splashView,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
