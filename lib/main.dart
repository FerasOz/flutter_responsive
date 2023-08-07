import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_project_flutter/layout/news_app/news_layout.dart';
import 'package:new_project_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:new_project_flutter/layout/shop_app/shop_layout.dart';
import 'package:new_project_flutter/layout/social_app/cubit/cubit.dart';
import 'package:new_project_flutter/layout/social_app/social_layout.dart';
import 'package:new_project_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:new_project_flutter/shared/components/components.dart';
import 'package:new_project_flutter/shared/components/constants.dart';
import 'package:new_project_flutter/shared/cubit/cubit.dart';
import 'package:new_project_flutter/shared/cubit/states.dart';
import 'package:new_project_flutter/shared/network/local/cache_helper.dart';
import 'package:new_project_flutter/shared/network/remote/dio_helper.dart';
import 'package:new_project_flutter/shared/styles/themes.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'layout/todo_app/todo_layout.dart';
import 'modules/bmi/bmi_screen.dart';
import 'modules/counter/counter_screen.dart';
import 'modules/native_code.dart';
import 'modules/shop_app/on_boarding_screen/on_boarding_screen.dart';
import 'modules/social_app/social_login/social_login_screen.dart';
import 'shared/bloc_observer.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('On Message BackGround App');
  print(message.data.toString());
  showToast(text: 'On Message BackGround App', state: ToastStates.SUCCESS);
}

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(const Size(
       /*width*/ 650.0,
       /*height*/ 650.0
    )
    );
  }

  // await Firebase.initializeApp();
  // var token = await FirebaseMessaging.instance.getToken();
  //
  // print(token);
  //
  // FirebaseMessaging.onMessage.listen((event) {
  //   print('On Message App');
  //   print(event.data.toString());
  //   showToast(text: 'On Message App', state: ToastStates.SUCCESS);
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print('On Message Opened App');
  //   print(event.data.toString());
  //   showToast(text: 'On Message Opened App', state: ToastStates.SUCCESS);
  // });
  //
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  // token = CacheHelper.getData(key: 'token');

  // print(token);

  uId = CacheHelper.getData(key: 'uId');

  // if(onBoarding != null){
  //   if(token != null){
  //     widget = ShopLayout();
  //   }else{
  //     widget = ShopLoginScreen();
  //   }
  // }else{
  //   widget = OnBoardingScreen();
  // }

  if(uId != null){
    widget = const SocialLayout();
  }else{
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    isDark,
    widget
  ));
}

class MyApp extends StatelessWidget {

  bool? isDark;
  Widget? startWidget;

  MyApp(this.isDark, this.startWidget);

  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        BlocProvider(create: (context) => AppCubit()..changeTheme(fromShared: isDark,)),
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategoData()..getFavourites()..getUserData()),
        BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              //AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light
            home: NativeCodeScreen()/*startWidget*/,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
