import 'package:flutter/material.dart';
import 'package:mdigits/src/components/instructions/general_instructions.dart';

class InstructionsPractice extends StatelessWidget {
  const InstructionsPractice({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralInstructions(
      children: Text(
        'Comenzaremos practicando',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
