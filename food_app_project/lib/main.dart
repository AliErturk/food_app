import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_project/cubit/anayayfa_cubit.dart';
import 'package:food_app_project/cubit/detay_sayfa_cubit.dart';
import 'package:food_app_project/cubit/login_sayfa_cubit.dart';
import 'package:food_app_project/cubit/register_sayfa_cubit.dart';
import 'package:food_app_project/cubit/sepet_sayfa_cubit.dart';
import 'package:food_app_project/cubit/adet_cubit.dart';
import 'package:food_app_project/cubit/yemekler_firebase_cubit.dart';
import 'package:food_app_project/views/login_sayfa.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit(),),
        BlocProvider(create: (context) => DetaySayfaCubit(),),
        BlocProvider(create: (context) => SepetSayfaCubit(),),
        BlocProvider(create: (context)=>AdetCubit()),
        BlocProvider(create: (context) => LoginSayfaCubit(),),
        BlocProvider(create: (context) => RegisterSayfaCubit(),),
        BlocProvider(create: (context) => YemeklerFirebaseCubit(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.green,
        ),
        home:  LoginSayfa(),
      ),
    );
  }
}
