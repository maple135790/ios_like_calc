import 'package:bloc/bloc.dart';
part 'calc_event.dart';
part 'calc_state.dart';

class CalcBloc extends Bloc<CalcEvent, CalcState> {
  String current = '';
  String stored = '';

  CalcBloc() : super(CalcInitial()) {
    String sub(String n) {
      String r = (num.parse(stored) - num.parse(n)).toString();
      return r;
    }

    String add(String n) {
      String r = (num.parse(stored) + num.parse(n)).toString();
      return r;
    }

    String multi(String n) {
      String r = (num.parse(stored) * num.parse(n)).toString();
      return r;
    }

    String div(String n) {
      String r =
          n == '0' ? 'Error' : (num.parse(stored) / num.parse(n)).toString();
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
      String result = '0';
      if (stored == 'Error') return emit(CalcResult.clearWith('Error'));
      if (event.op == '-') {
        result = sub(event.num);
      } else if (event.op == '+') {
        result = add(event.num);
      } else if (event.op == '*') {
        result = multi(event.num);
      } else if (event.op == '/') {
        result = div(event.num);
      }
      stored = result.toString();
      return emit(CalcResult.clearWith(result.toString()));
    });
  }
}
