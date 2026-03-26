import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'network_loading_state.dart';

class NetworkLoadingCubit extends Cubit<NetworkLoadingState> {
  NetworkLoadingCubit() : super(NetworkLoadingInitial());

  void loading() {
    emit(NetworkLoadingInitial());
  }

  void success() {
    List<String> list = [];
    for (int i = 0; i <= 10; i++) {
      list.add('Item $i');
    }
    emit(NetworkSuccess(list));
  }

  void fail() {
    emit(NetworkFailure('This is error'));
  }
}
