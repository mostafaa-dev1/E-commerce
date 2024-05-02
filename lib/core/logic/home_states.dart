import 'package:newww/features/favourites_screen/model/favourites_model.dart';
import 'package:newww/core/logic/home_cubit.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class NavBottomStates extends ShopStates {}

class LoadingHomeScreen extends ShopStates {}

class GetDataSuccessfuly extends ShopStates {}

class GetDataError extends ShopStates {}

class GetCatDataSuccessfuly extends ShopStates {}

class GetCatDataError extends ShopStates {}

class GetFavouritesSuccessfuly extends ShopStates {
  final FavouritesModel model;

  GetFavouritesSuccessfuly(this.model);
}

class GetFavouritesDataError extends ShopStates {}

class ChangeFavouritesData extends ShopStates {}

class GetFavouritesItemError extends ShopStates {}

class GetFavouritesItemSuccess extends ShopStates {}

class GetFavouritesItemLoading extends ShopStates {}

class GetUserDataError extends ShopStates {}

class GetUserDataSuccess extends ShopStates {}

class GetUserDataLoading extends ShopStates {}

class NavButtomStates extends ShopStates {}

class TotalPrice extends ShopStates {}
