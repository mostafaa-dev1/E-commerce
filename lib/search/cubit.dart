import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/core/network/dio_helper/dio_helper.dart';
import 'package:newww/core/network/end_point.dart';
import 'package:newww/search/search_model.dart';
import 'package:newww/search/states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void Search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
            url: SEARCH,
            data: {
              'text': text,
            },
            token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value!.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
