import 'package:App/layout/shop_app/cubit/state.dart';
import 'package:App/models/shop_app/categories_model.dart';
import 'package:App/models/shop_app/change_fav_model.dart';
import 'package:App/models/shop_app/fav_model.dart';
import 'package:App/models/shop_app/home_model.dart';
import 'package:App/models/shop_app/login_model.dart';
import 'package:App/modules/shop_app/categories/categories_screen.dart';
import 'package:App/modules/shop_app/favorites/favorites_screen.dart';
import 'package:App/modules/shop_app/products/products_screen.dart';
import 'package:App/modules/shop_app/settings/settings_screen.dart';
import 'package:App/shared/components/components.dart';
import 'package:App/shared/components/constants.dart';
import 'package:App/shared/cubit/states.dart';
import 'package:App/shared/network/cache_helper.dart';
import 'package:App/shared/network/dio_helper.dart';
import 'package:App/shared/network/end_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      // printFullText(homeModel.data.banners[0].image);
      // print(homeModel.status);

      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      // printFullText(homeModel.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesModel() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {


      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavModel  changeFavModel;


  void changeFavorites(int productId) {

    favorites[productId]  =!favorites[productId];
    emit(ShopChangeFavoritesState());


    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavModel = ChangeFavModel.fromJson(value.data);
      print(value.data);

      if(!changeFavModel.status){
        favorites[productId]  =!favorites[productId];

      }else{
        getFavoritesModel();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavModel));

    }).catchError((error){

      favorites[productId]  =!favorites[productId];

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel favoritesModel;
  void getFavoritesModel()
  {
    emit(ShopLoadingGetFavoritesState());


    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavState());
    });
  }

  ShopLoginModel userModel;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());


    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel.data.name);

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }


  void updateUserData({
  @required String name,
    @required String email,
    @required String phone,
  })
  {
    emit(ShopLoadingUpdateState());


    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel.data.name);

      emit(ShopSuccessUpdateState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateState());
    });
  }


}
