import 'package:flutter/material.dart';
import './ui/help.dart';

void main() => runApp(MyApp());

class Options {
  List<String> _units;
  String _curr;
  Options(this._units) {
    this._curr = this._units[0];
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI',
      home: MyHomePage(),
      theme: Theme.of(context).copyWith(
        appBarTheme:
            Theme.of(context).appBarTheme.copyWith(color: Colors.purple[300]),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: Theme.of(context)
              .textTheme
              .body1
              .copyWith(color: Colors.purple[300], fontSize: 20.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple[300],
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0.5,
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
            borderSide: BorderSide(
              color: Colors.purple[800],
              width: 3.0,
            ),
          ),
        ),
        floatingActionButtonTheme: Theme.of(context)
            .floatingActionButtonTheme
            .copyWith(
                backgroundColor: Colors.purple[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0)))),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Options heights = new Options(['foot', 'cm']);
  Options weights = new Options(['kg', 'lbs']);
  TextEditingController _ageInput = new TextEditingController();
  TextEditingController _heightInput = new TextEditingController();
  TextEditingController _weightInput = new TextEditingController();
  String show = '';
  String category = '';
  Color categoryColor;

  String _check() {
    if (_ageInput.text.isEmpty) {
      return 'Age Field is Empty';
    } else if (double.parse(_ageInput.text) < 1) {
      return 'Invalid Age';
    } else if (_heightInput.text.isEmpty) {
      return 'Height Field is Empty';
    } else if (double.parse(_heightInput.text) < 1) {
      return 'Invalid Height';
    } else if (_weightInput.text.isEmpty) {
      return 'Weight Field is Empty';
    } else if (double.parse(_weightInput.text) < 1) {
      return 'Invalid Weight';
    } else {
      return '';
    }
  }

  String getCategory(double bmi) {
    if (bmi > 40) {
      categoryColor = Colors.red;
      return 'Very Severly Obese';
    } else if (bmi > 35) {
      categoryColor = Colors.red[400];
      return 'Severly Obese';
    } else if (bmi > 30) {
      categoryColor = Colors.red[300];
      return 'Moderately Obese';
    } else if (bmi > 25) {
      categoryColor = Colors.red[200];
      return 'Overweight';
    } else if (bmi > 18.5) {
      categoryColor = Colors.green;
      return 'Normal weight';
    } else if (bmi > 16) {
      categoryColor = Colors.red[300];
      return 'Underweight';
    } else if (bmi > 15) {
      categoryColor = Colors.red[400];
      return 'Severly Underweight';
    } else {
      categoryColor = Colors.red;
      return 'Very Severly Underweight';
    }
  }

  double _calculateBMI() {
    print('${heights._curr} ${weights._curr}');
    double kg = double.parse(_weightInput.text);
    double cms = double.parse(_heightInput.text);
    if (heights._curr == 'foot') {
      cms = double.parse((cms * 30.48).toStringAsFixed(2));
    }
    if (weights._curr == 'lbs') {
      kg = double.parse((kg * 0.453).toStringAsFixed(2));
    }
    print('$kg, $cms');
    return (kg * 10000) / (cms * cms);
  }

  void _result() {
    setState(() {
      show = _check();
      if (show.isEmpty) {
        double bmi = double.parse(_calculateBMI().toStringAsFixed(2));
        show = 'BMI: ${bmi.toString()}';
        category =
            '${getCategory(bmi)} ${(int.parse(_ageInput.text) < 20) ? '(See Info)' : ''}';
      }
    });
  }

  void _showHelp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('BMI Categories'),
            actions: <Widget>[
              FlatButton(
                color: Colors.purple[800],
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                ),
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
                padding: EdgeInsets.all(12.0),
              )
            ],
            content: Help(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('./assets/images/bmilogo.png'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => _showHelp(context),
            tooltip: 'Additional Information',
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 120.0, vertical: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextField(
                  textAlign: TextAlign.center,
                  controller: _ageInput,
                  decoration: InputDecoration(
                    labelText: 'Age',
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(fontSize: 24.0),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 25.0,
                ),
                RowField('Height', _heightInput, this.heights),
                SizedBox(
                  height: 25.0,
                ),
                RowField('Weight', _weightInput, this.weights),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                show,
                style: Theme.of(context).textTheme.display2.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 36.0,
                    ),
              ),
              Text(
                category,
                style: Theme.of(context).textTheme.display2.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 28.0,
                      color: categoryColor,
                    ),
              )
            ],
          ),
          SizedBox(
            height: 75.0,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Calculate'),
        onPressed: _result,
      ),
    );
  }
}

class RowField extends StatefulWidget {
  final String _label;
  final TextEditingController _input;
  Options unit;
  RowField(this._label, this._input, this.unit);

  @override
  _RowFieldState createState() => _RowFieldState();
}

class _RowFieldState extends State<RowField> {
  void setUnit(String value) {
    setState(() {
      widget.unit._curr = value;
    });
    print(widget.unit._curr);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(labelText: widget._label),
          style: Theme.of(context).textTheme.body1.copyWith(fontSize: 24.0),
          controller: this.widget._input,
          keyboardType: TextInputType.number,
        ),
        DropdownButton<String>(
          value: widget.unit._curr,
          onChanged: (value) => setUnit(value),
          items: widget.unit._units.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          elevation: 2,
        ),
      ],
    );
  }
}
