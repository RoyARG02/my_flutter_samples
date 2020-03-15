import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: HelpTable(),
        ),
        Text(
          'These figures MAY NOT apply to individuals less than 20 years of age.',
          style: Theme.of(context).textTheme.body1.copyWith(
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

class HelpTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Table(
      border: TableBorder.all(width: 1.0),
      children: [
        TableRow(
          children: [
            TableCell(child: PaddedText('Less than 15')),
            TableCell(child: PaddedText('Very Severely Underweight'))
          ],
        ),
        TableRow(
          children: [
            TableCell(child: PaddedText('Between 15 and 16')),
            TableCell(child: PaddedText('Severely Underweight'))
          ],
        ),
        TableRow(
          children: [
            TableCell(child: PaddedText('Between 16 and 18.5')),
            TableCell(child: PaddedText('Underweight'))
          ],
        ),
        TableRow(
          children: [
            TableCell(child: PaddedText('Between 18.5 and 25')),
            TableCell(child: PaddedText('Normal weight'))
          ],
        ),
        TableRow(
          children: [
            TableCell(child: PaddedText('Between 25 and 30')),
            TableCell(child: PaddedText('Overweight'))
          ],
        ),
        TableRow(
          children: [
            TableCell(child: PaddedText('Between 30 and 35')),
            TableCell(child: PaddedText('Moderately Obese'))
          ],
        ),
        TableRow(
          children: [
            TableCell(child: PaddedText('Between 35 and 40')),
            TableCell(child: PaddedText('Severely Obese'))
          ],
        ),
        TableRow(
          children: [
            TableCell(child: PaddedText('Greater than 40')),
            TableCell(child: PaddedText('Very Severely Obese'))
          ],
        ),
      ],
    );
  }
}

class PaddedText extends StatelessWidget {
  final String text;
  PaddedText(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        this.text,
      ),
    );
  }
}
