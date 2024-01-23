// search view.
// 6 numbers input or num_no input and search button

import 'package:flutter/material.dart';
import '/utils/num_db.dart';

class search_view extends StatefulWidget {
  const search_view({Key? key}) : super(key: key);

  @override
  _search_viewState createState() => _search_viewState();
}

class _search_viewState extends State<search_view> {
  final _formKey = GlobalKey<FormState>();
  final _num1Controller = TextEditingController();
  final _num2Controller = TextEditingController();
  final _num3Controller = TextEditingController();
  final _num4Controller = TextEditingController();
  final _num5Controller = TextEditingController();
  final _num6Controller = TextEditingController();
  final _numNoController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _num1Controller.dispose();
    _num2Controller.dispose();
    _num3Controller.dispose();
    _num4Controller.dispose();
    _num5Controller.dispose();
    _num6Controller.dispose();
    _numNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _num1Controller,
                    decoration: const InputDecoration(
                      hintText: 'num1',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter num1';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _num2Controller,
                    decoration: const InputDecoration(
                      hintText: 'num2',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter num2';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _num3Controller,
                    decoration: const InputDecoration(
                      hintText: 'num3',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter num3';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _num4Controller,
                    decoration: const InputDecoration(
                      hintText: 'num4',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter num4';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _num5Controller,
                    decoration: const InputDecoration(
                      hintText: 'num5',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter num5';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _num6Controller,
                    decoration: const InputDecoration(
                      hintText: 'num6',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter num6';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _numNoController,
                    decoration: const InputDecoration(
                      hintText: '회차번호',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '조회할 회차번호를 입력하세요.';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    // button text
                    child: const Text('Search'),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // if num_no is empty, search by num1 ~ num6
                        if (_numNoController.text.isEmpty) {
                          print('search by num1 ~ num6');
                          print('num1: ${_num1Controller.text}');
                          print('num2: ${_num2Controller.text}');
                          print('num3: ${_num3Controller.text}');
                          print('num4: ${_num4Controller.text}');
                          print('num5: ${_num5Controller.text}');
                          print('num6: ${_num6Controller.text}');
                          // search by num1 ~ num6 from db
                          final db = numDb();
                          final result = db.selectDataByNums(
                              int.parse(_num1Controller.text),
                              int.parse(_num2Controller.text),
                              int.parse(_num3Controller.text),
                              int.parse(_num4Controller.text),
                              int.parse(_num5Controller.text),
                              int.parse(_num6Controller.text));
                          print('result by num: $result');
                        } else {
                          print('search by num_no');
                          print('num_no: ${_numNoController.text}');
                          // search by num_no from db
                          final db = numDb();
                          final result = db.selectDataByRunNo(
                              int.parse(_numNoController.text));
                          print('result bu run_no: $result');

                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
