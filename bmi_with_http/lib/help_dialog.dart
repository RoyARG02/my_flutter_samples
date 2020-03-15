import 'package:bmi_with_http/data/category.dart';
import 'package:bmi_with_http/utils/http_get.dart';
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
  String determineLabel(Category entry) {
    if (entry.min == 0)
      return 'Less than ${entry.max}';
    else if (entry.max == 99)
      return 'Greater than ${entry.min}';
    else
      return 'Between ${entry.min} and ${entry.max}';
  }

  @override
  Widget build(BuildContext context) {
    return new Table(
      border: TableBorder.all(width: 1.0),
      children: bmiCategories
          .map(
            (entry) => TableRow(
              children: [
                TableCell(child: PaddedText(text: determineLabel(entry))),
                TableCell(
                  child: PaddedText(
                    text: entry.description,
                    color: Color(
                        int.parse(entry.tagColor.substring(4, 10), radix: 16) +
                            0xFF000000),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class PaddedText extends StatelessWidget {
  final String text;
  final Color color;
  PaddedText({@required this.text, this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Text(
        this.text,
        style: TextStyle(color: this.color),
      ),
    );
  }
}
