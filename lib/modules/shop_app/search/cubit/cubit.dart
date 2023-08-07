import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/models/shop_app/search/Search_model.dart';
import 'package:new_project_flutter/modules/shop_app/search/cubit/states.dart';
import 'package:new_project_flutter/shared/components/constants.dart';
import 'package:new_project_flutter/shared/network/end_point.dart';
import 'package:new_project_flutter/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void Search(String text){

    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
        'text' : text
        }).then((value) {
          searchModel = SearchModel.fromJson(value.data);
          emit(SearchSuccessState());
    }).catchError((error){
          print(error.toString());
          emit(SearchErrorState());
    });

  }
}