import 'package:code95_task/cubit/query_cubit.dart';
import 'package:code95_task/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      builder: () => MultiBlocProvider(
       providers:  [
         BlocProvider(create: (context) => QueryCubit(),),

       ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Outfit',
          primarySwatch: Colors.blue,
        ),
        home:  HomeScreen(),
      ),
    ),);
  }
}
