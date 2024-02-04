// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CI_Calc extends StatefulWidget {
  const CI_Calc({super.key});

  @override
  State<StatefulWidget> createState() => _CI_Calc();
}

class _CI_Calc extends State<CI_Calc> {

  final _compoundFreq = [
    "Daily",
    "Weekly",
    "Monthly",
    "Quarterly",
    "Annually",
    "Semi-Annually",
  ];
  final _padding = 5.0;

  String? _compoundFreqSelect;


  var dispOutput = " ";

  final _formKey = GlobalKey<FormState>();

  final TextEditingController p1control = TextEditingController();
  final TextEditingController r1control = TextEditingController();
  final TextEditingController t1control = TextEditingController();

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
                controller: p1control,
                validator: (var value) {
                  if (value == null || value.isEmpty) {
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
                controller: r1control,
                validator: (var value) {
                  if (value == null || value.isEmpty) {
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
                        'Compound Frequency',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                      ),
                      items: _compoundFreq.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _compoundFreqSelect,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                      onChanged: (String? newValue) {
                        _onCompoundItemSelect(newValue!);
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
                      validator: (var value) {
                        if (value == null || value.isEmpty) {
                          return "Whoops! it's required..";
                        }
                        return null;
                      },
                      controller: t1control,
                      decoration: InputDecoration(
                        labelStyle: txtStyle,
                        errorStyle: const TextStyle(
                          fontSize: 15.0,
                        ),
                        labelText: "Period", // Works like PLACEHOLDER
                        hintText:
                            "e.g., 1, 2, 3 and so on....", // Like, Alert Box
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
                            color: Colors.black,
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
              padding: EdgeInsets.all(_padding*4),
              child: Padding(
                padding: EdgeInsets.all(_padding),
                child: Expanded(
                  child: Text(
                    dispOutput,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
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

  void _onCompoundItemSelect(String s) {
    setState(() {
      _compoundFreqSelect = s;
    });
  }

  String _CalInterest() {
    double p = double.parse(p1control.text);   //principle
    double r = double.parse(r1control.text);  //rate
    int t = int.parse(t1control.text);  //years
    double ci;
    double A;
    switch (_compoundFreqSelect) {
      case 'Annually':
        A = p;
        for (int i=0; i<t; i++){
          A *= (1 + r/100);
        }
        ci = A - p;
        break;
      case 'Semi-Annually':
        A = p;
        double semiAnuallyRate = r/2;
        for (int i=0; i<t*2; i++){
          A *= (1 + semiAnuallyRate/100);
        }
        ci = A - p;
        break;
      case 'Quarterly':
        A = p;
        double quaterlyRate = r/4;
        for (int i=0; i<t*4; i++){
          A *= (1 + quaterlyRate/100);
        }
        ci = A - p;
        break;
      case 'Monthly':
        A = p;
        double monthlyRate = r/12;
        for (int i=0; i<t*12; i++){
          A *= (1 + monthlyRate/100);
        }
        ci = A - p;
        break;
      case 'Weekly':
        A = p;
        double weeklyRate = r/52;
        for (int i=0; i<t*52; i++){
          A *= (1 + weeklyRate/100);
        }
        ci = A - p;
        break;
      case 'Daily':
        A = p;
        double dailyRate = r/365;
        for (int i=0; i<t*365; i++){
          A *= (1 + dailyRate/100);
        }
        ci = A - p;
        break;
      default:
        throw Exception('Invalid compounding frequency');
    }

    String output = "Interest Earned: ${ci.toStringAsFixed(2)}\nPayable Amount: ${A.toStringAsFixed(2)}";
    return output;
  }

  void _clearAll() {
    _formKey.currentState?.reset();
    p1control.text = '';
    r1control.text = '';
    t1control.text = '';
    dispOutput = '';
    _compoundFreqSelect = _compoundFreq[0];
  }

}
