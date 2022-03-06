import 'package:bloc/bloc.dart';
part 'calc_event.dart';
part 'calc_state.dart';

class CalcBloc extends Bloc<CalcEvent, CalcState> {
  String current = '';
  String stored = '';

  CalcBloc() : super(CalcInitial()) {
    num sub(String n) {
      num r = num.parse(stored) - num.parse(n);
      return r;
    }

    num add(String n) {
      num r = num.parse(stored) + num.parse(n);
      return r;
    }

    on<ClearPressed>((event, emit) {
      current = '';
      stored = '';
      return emit(Clear());
    });
    on<InputNumber>((event, emit) {
      if (event.clear == false) {
        current += event.input;
      } else {
        stored == '' ? stored = current : stored;
        current = event.input;
      }
      if (event.clear == false) return emit(CalcResult(event.input.toString()));
      return emit(CalcResult.clearWith(event.input.toString()));
    });
    on<Calculation>((event, emit) {
      num result = 0;
      if (event.op == '-') {
        result = sub(event.num);
      } else if (event.op == '+') {
        result = add(event.num);
      }
      stored = result.toString();
      return emit(CalcResult.clearWith(result.toString()));
    });
  }
}
