import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:new_project_flutter/layout/shop_app/cubit/states.dart';
import 'package:new_project_flutter/modules/news_app/search/search_screen.dart';
import 'package:new_project_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:new_project_flutter/shared/components/components.dart';
import 'package:new_project_flutter/shared/network/local/cache_helper.dart';

import '../../modules/shop_app/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
                'Salla',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            actions: [
              IconButton(onPressed: (){
                navigateTo(context, SearchShopScreen());
              }, icon: Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (int index){
              cubit.changeBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: 'Categories'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
