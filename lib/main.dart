import 'package:bloc_cubit_learning/cubit/network_loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bloc_cubit_learning/cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(lazy: true, create: (_) => CounterCubit()),
        BlocProvider<NetworkLoadingCubit>(
          lazy: true,
          create: (_) => NetworkLoadingCubit(),
        ),
      ],
      child: MaterialApp(home: Home(), debugShowCheckedModeBanner: false),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Cubit')),
      body: Column(
        children: [
          Center(
            child: BlocBuilder<CounterCubit, int>(
              /// Build Only when the condition is true
              // buildWhen: (context, state){
              //   if(state % 2 == 0) {
              //     return false;
              //   } else {
              //     return true;
              //   }
              // },
              builder: (context, state) {
                return Text(
                  'The value is $state',
                  style: TextStyle(fontSize: 30),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).increment();
                },
                icon: Icon(Icons.add),
                label: Text('Add'),
              ),
              TextButton.icon(
                onPressed: () {
                  BlocProvider.of<CounterCubit>(context).decrement();
                },
                icon: Icon(Icons.remove),
                label: Text('Minus'),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              ElevatedButton(
                child: Text('Loading'),
                onPressed: () {
                  BlocProvider.of<NetworkLoadingCubit>(context).loading();
                },
              ),
              ElevatedButton(
                child: Text('Success'),
                onPressed: () {
                  BlocProvider.of<NetworkLoadingCubit>(context).success();
                },
              ),
              ElevatedButton(
                child: Text('Failed'),
                onPressed: () {
                  BlocProvider.of<NetworkLoadingCubit>(context).fail();
                },
              ),
            ],
          ),

          BlocBuilder<NetworkLoadingCubit, NetworkLoadingState>(
            builder: (context, state) {
              if (state is NetworkSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return Center(child: Text(state.data[index]));
                    },
                  ),
                );
              } else if (state is NetworkLoadingInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is NetworkFailure) {
                return Center(child: Text(state.error));
              }
              return SizedBox(); // default fallback
            },
          ),
        ],
      ),
    );
  }
}
