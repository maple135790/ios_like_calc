part of 'calc_bloc.dart';

abstract class CalcEvent {
  const CalcEvent();
}

class ClearPressed extends CalcEvent {
  const ClearPressed();
}

class InputNumber extends CalcEvent {
  final String input;
  bool clear = false;

  InputNumber(this.input);
  InputNumber.clear(this.input) : clear = true;
}

class Calculation extends CalcEvent {
  final String num;
  final String op;

  const Calculation(this.num, this.op);
}
