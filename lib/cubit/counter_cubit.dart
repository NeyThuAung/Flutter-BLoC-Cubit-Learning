import 'package:bloc/bloc.dart';

// int is state value that will emit to UI
// 0 is initial state value
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment(){
    emit(state + 1);
  }
  void decrement(){
    emit(state -1);
  }
}
