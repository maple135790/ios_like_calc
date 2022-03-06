part of 'calc_bloc.dart';

abstract class CalcState {
  const CalcState();
}

class CalcInitial extends CalcState {}

class CalcResult extends CalcState {
  final String result;
  bool clear = false;

  CalcResult(this.result);
  CalcResult.clearWith(this.result) : clear = true;
}

class Clear extends CalcState {}
