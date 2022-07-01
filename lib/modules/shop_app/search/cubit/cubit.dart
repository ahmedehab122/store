import 'package:App/models/shop_app/search_model.dart';
import 'package:App/modules/shop_app/search/cubit/state.dart';
import 'package:App/shared/components/constants.dart';
import 'package:App/shared/network/dio_helper.dart';
import 'package:App/shared/network/end_point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() :super(SearchInitialState());


  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data:
        {
          'text': text,
        },
    ).then((value){
      model= SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
      
    }).catchError((error){
      emit(SearchErrorState());
    });
  }

}