import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_frontend_nusantech/provider/calculate_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _num1 = TextEditingController();
  var _num2 = TextEditingController();
  var _num3 = TextEditingController();

  List<TextEditingController> _texConntrollre;
  @override
  void initState() {
    super.initState();
    _texConntrollre = List<TextEditingController>();
    _texConntrollre.addAll([_num1, _num2, _num3]);
    Provider.of<CalculateProvider>(context, listen: false)
        .initCalculate(_texConntrollre.length);
  }

  @override
  void dispose() {
    super.dispose();
    _num1.dispose();
    _num2.dispose();
    _num3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Frontend"),
      ),
      body: Container(
        child: Consumer<CalculateProvider>(
          builder: (context, value, _) {
            if (value.dataCalc != null && _texConntrollre != null) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 21,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.dataCalc.length,
                      itemBuilder: (context, index) {
                        return _itemInputNum(index, _texConntrollre[index],
                            value.dataCalc[index].isCheck);
                      },
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - (2 * 12),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.operatorCalc.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.all(4.0),
                            child: RaisedButton(
                              child: Text(value.operatorCalc[index]),
                              onPressed: () {
                                Provider.of<CalculateProvider>(context,
                                        listen: false)
                                    .funcCalculate(index);

                                if (value.message != null) {
                                  Flushbar(
                                    message: value.message,
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Text(
                      "Result: ${value.resultCalc} ",
                      style: TextStyle(fontSize: 23),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _itemInputNum(int index, var controller, bool isCheck) {
    return CheckboxListTile(
      value: isCheck,
      title: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        onChanged: (s) {
          Provider.of<CalculateProvider>(context, listen: false)
              .setDataNum(index, s);
        },
      ),
      onChanged: (c) {
        Provider.of<CalculateProvider>(context, listen: false)
            .setDataCheck(index, c);
      },
    );
  }
}
