import 'package:bmi_with_http/utils/http_get.dart';
import 'package:flutter/material.dart';
import './help_dialog.dart';

void main() async {
  await getCategories();
  runApp(MyApp());
}

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
      theme: ThemeData.light().copyWith(
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
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0)))),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Options heights = new Options(['foot', 'cm']);
  final Options weights = new Options(['kg', 'lbs']);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDataAvailable;
  TextEditingController _ageInput = new TextEditingController();
  TextEditingController _heightInput = new TextEditingController();
  TextEditingController _weightInput = new TextEditingController();
  String result;
  String category;
  Color categoryColor;

  @override
  void initState() {
    super.initState();
    isDataAvailable = bmiCategories.isNotEmpty;
    category = '';
    result = isDataAvailable
        ? ''
        : 'Cannot calculate BMI: Missing network connection. Refresh to try again.';
  }

  @override
  void dispose() {
    _ageInput.dispose();
    _heightInput.dispose();
    _weightInput.dispose();
    super.dispose();
  }

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

  Future<void> _refresh() async {
    await getCategories().then((_) {
      setState(() {
        isDataAvailable = bmiCategories.isNotEmpty;
        result = isDataAvailable
            ? ''
            : 'Cannot calculate BMI: Missing network connection. Refresh to try again.';
      });
    });
  }

  void getCategory(double bmi) async {
    for (num i = bmiCategories.length - 1; i > -1; --i) {
      if (bmi > bmiCategories[i].min) {
        category = bmiCategories[i].description;
        categoryColor = Color(
            int.parse(bmiCategories[i].tagColor.substring(4, 10), radix: 16) +
                0xFF000000);
        break;
      }
    }
  }

  double _calculateBMI() {
    print('${widget.heights._curr} ${widget.weights._curr}');
    double kg = double.parse(_weightInput.text);
    double cms = double.parse(_heightInput.text);
    if (widget.heights._curr == 'foot') {
      cms = double.parse((cms * 30.48).toStringAsFixed(2));
    }
    if (widget.weights._curr == 'lbs') {
      kg = double.parse((kg * 0.453).toStringAsFixed(2));
    }
    print('$kg, $cms');
    return (kg * 10000) / (cms * cms);
  }

  void _setResultStrings() {
    setState(() {
      result = _check();
      if (result.isEmpty) {
        double bmi = double.parse(_calculateBMI().toStringAsFixed(2));
        result = 'BMI: ${bmi.toString()}';
        getCategory(bmi);
        category =
            '$category ${(int.parse(_ageInput.text) < 20) ? '(See Info)' : ''}';
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          './assets/images/bmilogo.png',
          height: kToolbarHeight,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: (isDataAvailable) ? () => _showHelp(context) : null,
            tooltip: 'Additional Information',
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 120.0, vertical: 50.0),
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InputField(
                  label: 'Age',
                  inputcontroller: _ageInput,
                ),
                SizedBox(
                  height: 25.0,
                ),
                InputField(
                  label: 'Height',
                  inputcontroller: _heightInput,
                  unit: this.widget.heights,
                ),
                SizedBox(
                  height: 25.0,
                ),
                InputField(
                  label: 'Weight',
                  inputcontroller: _weightInput,
                  unit: this.widget.weights,
                ),
                SizedBox(
                  height: 75.0,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  result,
                  style: Theme.of(context).textTheme.display2.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 36.0,
                      ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  category,
                  style: Theme.of(context).textTheme.display2.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 28.0,
                        color: categoryColor,
                      ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Calculate'),
        onPressed: (isDataAvailable) ? _setResultStrings : null,
        backgroundColor:
            (isDataAvailable) ? Colors.purple[800] : Colors.purple[200],
      ),
    );
  }
}

class InputField extends StatefulWidget {
  final String label;
  final TextEditingController inputcontroller;
  final Options unit;
  InputField({@required this.label, @required this.inputcontroller, this.unit});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
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
          decoration: InputDecoration(labelText: widget.label),
          style: Theme.of(context).textTheme.body1.copyWith(fontSize: 24.0),
          controller: this.widget.inputcontroller,
          keyboardType: TextInputType.number,
          enableInteractiveSelection: false,
        ),
        if (widget.unit != null)
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
