import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Die(DiePosition.Left),
          Die(DiePosition.Right),
        ],
      ),
    );
  }
}

enum DiePosition {
  Right,
  Left,
}

class Die extends StatefulWidget {
  final DiePosition diePosition;
  Die(this.diePosition);

  @override
  State<Die> createState() => _DieState();
}

class _DieState extends State<Die> {
  Map<DiePosition, int> dieNumbers = {
    DiePosition.Left: 1,
    DiePosition.Right: 1
  }; //

  Random rd = Random();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        child: Image.asset(
          'images/dice${widget.diePosition == DiePosition.Left ? dieNumbers[DiePosition.Left] : dieNumbers[DiePosition.Right]}.png',
        ),
        onPressed: () {
          setBothDiceState(rd);
          print(
              '${widget.diePosition.toString()} pressed! LB: ${dieNumbers[DiePosition.Left]} RB: ${dieNumbers[DiePosition.Right]}');
        },
      ),
    );
  }

  void setBothDiceState(Random rd) {
    setState(() {
      dieNumbers[DiePosition.Left] = rd.nextInt(6) + 1; // 1...6
      dieNumbers[DiePosition.Right] = rd.nextInt(6) + 1;
    }); // 1 - 6
  }
}
