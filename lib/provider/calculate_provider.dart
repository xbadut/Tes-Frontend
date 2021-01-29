import 'package:flutter/foundation.dart';
import 'package:test_frontend_nusantech/model/data_calculate.dart';

class CalculateProvider extends ChangeNotifier {
  List<DataCalculate> _dataCalculate;
  double _resultCalculate = 0;
  String _message;

  double get resultCalc => _resultCalculate;
  List<DataCalculate> get dataCalc => _dataCalculate;
  List<String> get operatorCalc => ["+", "-", "x", "/"];
  String get message => _message;

  initCalculate(int countField) {
    _dataCalculate = List<DataCalculate>();
    for (int i = 0; i < countField; i++) {
      _dataCalculate.add(
        DataCalculate(
          number: 0,
          isCheck: false,
        ),
      );
    }
  }

  setDataCheck(int index, bool isCheck) {
    _dataCalculate[index] =
        DataCalculate(isCheck: isCheck, number: _dataCalculate[index].number);
    notifyListeners();
  }

  setDataNum(int index, String s) {
    _dataCalculate[index] = DataCalculate(
        number: double.parse(s), isCheck: _dataCalculate[index].isCheck);
    notifyListeners();
  }

  funcCalculate(int indexOP) {
    _resultCalculate = 0;
    List<double> intList = List<double>();
    _dataCalculate.forEach(
      (e) {
        if (e.isCheck) {
          intList.add(e.number);
        }
      },
    );
    if (intList.length <= 1) {
      _message = "Masukan nomor lebih dari 1 dan centang checkbox";
    } else {
      _message = null;
      switch (indexOP) {
        case 0:
          _resultCalculate = intList.reduce((a, b) => a + b);
          break;
        case 1:
          _resultCalculate = intList.reduce((a, b) => a - b);
          break;
        case 2:
          _resultCalculate = intList.reduce((a, b) => a * b);
          break;
        case 3:
          _resultCalculate = intList.reduce((a, b) => a / b);
          break;
        default:
      }
    }
    notifyListeners();
  }
}
