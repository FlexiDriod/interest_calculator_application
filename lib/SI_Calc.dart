// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

class SI_Calc extends StatefulWidget {
  const SI_Calc({super.key});

  @override
  State<StatefulWidget> createState() => _SIcal();
}

class _SIcal extends State<SI_Calc> {
  final _timePeriod = ["Days", "Weeks", "Months", "Quarters", "Years"];
  final _padding = 5.0;
  String? _currentItemSelect;

  var dispOutput = " ";

  final _formKey = GlobalKey<FormState>();

  TextEditingController pController = TextEditingController();
  TextEditingController rController = TextEditingController();
  TextEditingController tController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? txtStyle = Theme.of(context).textTheme.titleMedium;
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(_padding * 2),
        child: ListView(
          children: <Widget>[
            getLogo(),
            Padding(
              padding: EdgeInsets.only(top: _padding, bottom: _padding),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: txtStyle,
                controller: pController,
                validator: (var value) {
                  if (value!.isEmpty) {
                    return 'Whoops! please enter the Principle Amount';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Principal", // Works like PLACEHOLDER
                  hintText: "Enter Principal Amount e.g., 20000",
                  labelStyle: txtStyle, // Like, Alert Box
                  errorStyle: const TextStyle(
                    fontSize: 15.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _padding, bottom: _padding),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: txtStyle,
                controller: rController,
                validator: (var value) {
                  if (value!.isEmpty) {
                    return 'Whoops! please enter the Annual Rate of Interest';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText:
                      "Annual Rate of Interest", // Works like PLACEHOLDER
                  hintText: "In Percent e.g., 10%", // Like, Alert Box
                  labelStyle: txtStyle,
                  errorStyle: const TextStyle(
                    fontSize: 15.0,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _padding, bottom: _padding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.white54,
                      isExpanded: true,
                      validator: (var value) {
                        if (value == null || value.isEmpty) {
                          return "Whoops! please select option..";
                        }
                        return null;
                      },
                      hint: const Text(
                        'Period Unit',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                      ),
                      items: _timePeriod.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentItemSelect,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                      onChanged: (String? newValueSelect) {
                        _onDropdownItemSelect(newValueSelect!);
                      },
                    ),
                  ),
                  Container(
                      width: _padding *
                          5), // space in between Time period and input

                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: txtStyle,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Whoops! it's required..";
                        }
                        return null;
                      },
                      controller: tController,
                      decoration: InputDecoration(
                        labelStyle: txtStyle,
                        errorStyle: const TextStyle(
                          fontSize: 15.0,
                        ),
                        labelText: "Time Period", // Works like PLACEHOLDER
                        hintText: "e.g., 1, 2 or 3, etc.", // Like, Alert Box
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _padding, bottom: _padding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.5),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            letterSpacing: 1.5,
                          ),
                        ), //backgroundColor
                      ),
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _clearAll();
                        });
                      },
                    ),
                  ),
                  Container(
                      width: _padding *
                          3), // space in between Time period and input

                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.5),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.greenAccent),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            letterSpacing: 1.5,
                          ),
                        ), //backgroundColor
                      ),
                      child: const Text(
                        "Calculate",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            dispOutput = _CalInterest();
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_padding * 4),
              child: Padding(
                padding: EdgeInsets.all(_padding),
                child: Text(
                  dispOutput,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLogo() {
    Image img = const Image(
      image: AssetImage('images/compound.png'),
      width: 100.0,
      height: 125.0,
      alignment: Alignment.center,
      fit: BoxFit.fill,
    );
    return Container(
      margin: EdgeInsets.all(_padding * 10),
      child: img,
    );
  }

  void _onDropdownItemSelect(String newValueSelect) {
    setState(() {
      _currentItemSelect = newValueSelect;
    });
  }

  String _CalInterest() {
    double p = double.parse(pController.text);
    double r = double.parse(rController.text);
    int t = int.parse(tController.text);
    double interest = 0;
    switch (_currentItemSelect) {
      case "Years":
        {
          interest = (p * (r / 100) * t);
        }
        break;
      case "Days":
        {
          interest = (p * (r / 100) * t) / 365;
        }
        break;
      case "Months":
        {
          interest = (p * (r / 100) * t) / 12;
        }
        break;
      case "Quarters":
        {
          interest = (p * (r / 100) * t) / 4;
        }
        break;
      case "Weeks":
        {
          interest = (p * (r / 100) * t) / 52;
        }
        break;
      default:
        {
          const Text("Invalid time period select ..");
        }
    }
    var totalPayAmount = p + interest;
    dynamic output =
        "Interest Earned: $interest\nPayable Amount: $totalPayAmount\n";
    return output;
  }

  void _clearAll() {
    _formKey.currentState?.reset();
    pController.text = '';
    rController.text = '';
    tController.text = '';
    dispOutput = '';
    _currentItemSelect = _timePeriod[0];
  }
}
