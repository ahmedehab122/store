// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

//search
//https://newsapi.org/
// v2/everything?
// q=tesla&apiKey=88c9fb6c24d64fa9bc2a32a67abfb36c

import 'package:App/modules/shop_app/login/shop_login_screen.dart';
import 'package:App/shared/components/components.dart';
import 'package:App/shared/network/cache_helper.dart';


void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        ShopLoginScreen(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
