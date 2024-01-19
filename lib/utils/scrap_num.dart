// get lotto number from naver lotto page
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import 'num_db.dart';

class scrapNum {
  static final String url = 'https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EB%A1%9C%EB%98%90+%EC%B1%94%EB%A6%AC&oquery=%EB%A1%9C%EB%98%90&tqi=hv%2B%2B%2Bsp0JXVssK%2F%2F%2F%2FVssssstZ-446574';

  Future<List<int>> getNum() async {
    final response = await http.get(Uri.parse(url));
    final document = parse(response.body);
    final elements = document.querySelectorAll('.num_box > .num');

    List<int> numList = [];
    for (var element in elements) {
      numList.add(int.parse(element.text));
    }

    return numList;
  }

  // read init data from csv file
  Future<List<int>> getInitData() async {
    var url = 'https://raw.githubusercontent.com/ochjjy/lottodata/main/num_data.csv';
    var httpHeaders = {
      'Content-Type': 'text/plain; charset=utf-8',
      'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
      'User-Agent': 'Mozilla/5.0 (Linux; Android 10; SM-G965N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Mobile Safari/537.36'
    };
    final response = await http.get(Uri.parse(url), headers: httpHeaders);
    print('response: ${response.body}');
    final document = response.body.toString().split('\n');

    print('document: ${document}');

    // db init
    final db = numDb();
    await db.createTable();


    List<int> numList = [];
    for (var element in document) {
      print('====> element: $element');
      // insert data to db
      if (element != '') {
        // remove '\n'
        element = element.replaceAll('\n', '');

        // replace '.' to '-'
        element = element.replaceAll('.', '-');

        // split data by ','
        List<String> raw_data = element.split(',');
        print('raw_data: $raw_data');
        // pass column name
        if (raw_data[0] == 'index') {
          continue;
        }
        // debug date string
        print('date: ${raw_data[1]}');

        // insert data to db
        await db.insertData({
          'run_no': raw_data[0],
          'date': '"${raw_data[1]}"',
          'n1': raw_data[2],
          'n2': raw_data[3],
          'n3': raw_data[4],
          'n4': raw_data[5],
          'n5': raw_data[6],
          'n6': raw_data[7],
          'nb': raw_data[8],
        });
      }
    }

    return numList;
  }
}
