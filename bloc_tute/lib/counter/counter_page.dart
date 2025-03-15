import 'package:bloc_tute/counter/counter_cubit.dart';
import 'package:bloc_tute/counter/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(0),
      child: BlocListener<CounterCubit, int>(
        listener: (context, state) {
          if (state == 10) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text("Counter has reached 10!"),
              ),
            );
          }
        },
        child: CounterView(),
      ),
    );
  }
}
