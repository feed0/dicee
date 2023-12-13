/* DICEE - Roll the dice. The lower bound takes the trash out!
*
* Made by: London App Brewery (Yu, A.)
* Cloned by: Felipe Campelo, on the dec. 12th, 2023
* Special thanks: Ivo at
* https://stackoverflow.com/questions/77653995/flutter-setstate-of-multiple-instances-of-a-stateful-widget-in-a-page/77654061#77654061
*/

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
          /* Here, you are instantiating two Die widgets in the DicePage widget.
            setState is a function that allows the modification of the internal
            state of the DicePage widget. It's passed to the Die widget so that
            it can trigger a state update in the parent (DicePage) when the die
            is pressed.
          */
          Die(DiePosition.Left, setState),
          Die(DiePosition.Right, setState),
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
  final Function(VoidCallback) setParent;

  Die(this.diePosition, this.setParent);

  @override
  State<Die> createState() => _DieState();
}

class _DieState extends State<Die> {
  // Here, the Map is static so there's only a single instance for all the dice
  static Map<DiePosition, int> dieNumbers = {
    DiePosition.Left: 1,
    DiePosition.Right: 1
  };

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
    /* In the setBothDiceState method of the _DieState class, you are calling
      the setParent function and passing a function as an argument. This function
      updates the state of the parent (DicePage) by generating random numbers for
      the left and right dice. This triggers a rebuild of the UI, reflecting the
      new state.

      Since setParent() is a Die's function we reference it by its parent
      class: widget. Then, each die in the row on DicePage call their parent's
      (the actual DicePage) setState function.
    */
    widget.setParent(() {
      dieNumbers[DiePosition.Left] = rd.nextInt(6) + 1; // 1...6
      dieNumbers[DiePosition.Right] = rd.nextInt(6) + 1;
    });
  }
}
