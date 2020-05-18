import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  double _tipPercentage = 0.0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _billAmountController.addListener(_compute);
  }

  TextEditingController _billAmountController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.lightGreen.shade100,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 0.3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Total per person",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '\$' + _billAmount.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.lightGreen.withOpacity(0.15),
                border: Border.all(width: 0.3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        prefixText: "Bill Amount  ",
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      controller: _billAmountController,
                      onChanged: _compute(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              "Split: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) _personCounter--;
                                _compute();
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen.shade300,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                "-",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _personCounter.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                                _compute();
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.lightGreen.shade300,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                "+",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Tip(%): ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Slider(
                                    value: _tipPercentage,
                                    min: 0,
                                    max: 100,
                                    onChanged: (double value) {
                                      try {
                                        setState(() {
                                          _tipPercentage =
                                              value.roundToDouble();
                                          _compute();
                                        });
                                      } catch (exception) {}
                                    },
                                  ),
                                ),
                                Text(
                                  _tipPercentage.round().toString(),
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _compute() {
    setState(() {
      try {
        double amt = 0.0;
        if (_billAmountController.text != null)
          amt = double.parse(_billAmountController.text);
        if (_personCounter != 0.0)
          _billAmount = double.parse(
              ((amt + (amt * _tipPercentage / 100)) / _personCounter)
                  .toStringAsFixed(2));
        else
          _billAmount = 100;
      } catch (exception) {
        _billAmount = 0.0;
      }
    });
  }
}
