import 'package:bloc_app/Application/home_bloc/home_state.dart';
import 'package:bloc_app/Domain/main_api.dart';
import 'package:bloc_app/Domain/store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    emit(HomeLoadingState());
    fetch();
  }
  Future<void> fetch() async {
    List<Store> products = await getall();
    emit(HomeLoadedState(allproducts: products));
  }
}
