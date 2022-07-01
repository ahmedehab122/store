import 'package:App/layout/shop_app/cubit/cubit.dart';
import 'package:App/layout/shop_app/cubit/state.dart';
import 'package:App/modules/shop_app/login/shop_login_screen.dart';
import 'package:App/modules/shop_app/search/search_screen.dart';
import 'package:App/shared/components/components.dart';
import 'package:App/shared/cubit/cubit.dart';
import 'package:App/shared/network/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state){},
        builder: (context, state){

          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Store',

              ),

              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen(),);
                  },
                    icon: Icon(
                      Icons.search,
                    ),
                ),

              ],
            ),
            body: cubit.bottomScreen[cubit.currentIndex] ,
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps),
                    label: 'Categories'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorite'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings'
                ),

              ],
            ),
          );
    },);

  }
}
