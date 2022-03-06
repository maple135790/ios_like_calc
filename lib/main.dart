import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_like_calc/bloc_observer.dart';

import 'bloc/calc_bloc.dart';
import 'input.dart';
import 'result.dart';

void main() {
  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: SimpleBlocObserver());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CalcBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    String initial = '0';
    String inputed = '';
    return Scaffold(
      appBar: AppBar(title: Text('calc')),
      body: BlocBuilder<CalcBloc, CalcState>(
        builder: (context, state) {
          if (state is CalcResult) {
            String result = '';
            if (!state.clear) result = inputed;
            result += state.result;
            inputed = result;
            return Column(
              children: [
                Result(display: result),
                Input(context, displayNum: result),
              ],
            );
          }
          if (state is Clear) inputed = '';
          return Column(
            children: [
              Result(display: initial),
              Input(context),
            ],
          );
        },
      ),
    );
  }
}
