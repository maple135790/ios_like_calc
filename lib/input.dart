import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/calc_bloc.dart';

class Input extends StatefulWidget {
  final BuildContext ctx;
  final String displayNum;
  const Input(this.ctx, {Key? key, this.displayNum = ''}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  String op = '';
  String inputedNum = '';
  Queue<String> opQueue = Queue();

  Widget opBtn(
    String operation, {
    Function()? callback,
    bool isEnabled = true,
  }) {
    return ElevatedButton(
      child: Text(operation),
      onPressed: isEnabled
          ? () {
              setState(() {
                op = op == operation ? '' : operation;
              });

              if (widget.ctx.read<CalcBloc>().stored.isNotEmpty &&
                  op.isNotEmpty &&
                  inputedNum.isNotEmpty) {
                widget.ctx
                    .read<CalcBloc>()
                    .add(Calculation(inputedNum, opQueue.first));
                opQueue.removeFirst();
                inputedNum = '';
              }
            }
          : null,
      style: operation != '='
          ? ElevatedButton.styleFrom(
              primary: op == operation ? Colors.red : Colors.blue)
          : ElevatedButton.styleFrom(),
    );
  }

  Widget btn(
    String numString, {
    Function()? callback,
    bool isEnabled = true,
    bool isCallbackOverridable = false,
  }) {
    return ElevatedButton(
      onPressed: isEnabled
          ? isCallbackOverridable
              ? callback
              : () {
                  inputedNum += numString;
                  if (op.isNotEmpty) {
                    widget.ctx
                        .read<CalcBloc>()
                        .add(InputNumber.clear(numString));
                    opQueue.addFirst(op);
                    inputedNum = numString;
                  } else
                    widget.ctx.read<CalcBloc>().add(InputNumber(numString));
                  setState(() {
                    op = '';
                  });
                }
          : null,
      child: Text(numString),
    );
  }

  @override
  Widget build(BuildContext _) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              btn(
                'C',
                isCallbackOverridable: true,
                callback: () {
                  inputedNum = '';
                  op = '';
                  opQueue.clear();
                  widget.ctx.read<CalcBloc>().add(ClearPressed());
                },
              ),
              opBtn('+/-', isEnabled: false),
              opBtn('/'),
              opBtn('*')
            ],
          ),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [btn('7'), btn('8'), btn('9'), opBtn('-')]),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [btn('4'), btn('5'), btn('6'), opBtn('+')]),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [btn('1'), btn('2'), btn('3'), opBtn('=')]),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                btn('0'),
                btn(
                  '.',
                  isCallbackOverridable: true,
                  callback: () {
                    if (widget.displayNum.contains('.')) {
                    } else {
                      widget.displayNum.isEmpty
                          ? widget.ctx.read<CalcBloc>().add(InputNumber('0.'))
                          : widget.ctx.read<CalcBloc>().add(InputNumber('.'));
                    }
                  },
                )
              ]),
        ],
      ),
    );
  }
}
