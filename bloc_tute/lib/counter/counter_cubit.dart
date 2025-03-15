import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  //constructor get initial state
  CounterCubit(super.initialState);
  //increment
  void increment() => emit(state + 1);
  //decrement
  void decrement() => emit(state - 1);
}
