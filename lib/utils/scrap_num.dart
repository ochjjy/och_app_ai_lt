// get lotto number from naver lotto page
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

class scrapNum {
  static final String url = 'https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=%EB%A1%9C%EB%98%90+%EC%B1%94%EB%A6%AC&oquery=%EB%A1%9C%EB%98%90&tqi=hv%2B%2B%2Bsp0JXVssK%2F%2F%2F%2FVssssstZ-446574';

  static Future<List<int>> getNum() async {
    final response = await http.get(Uri.parse(url));
    final document = parse(response.body);
    final elements = document.querySelectorAll('.num_box > .num');

    List<int> numList = [];
    for (var element in elements) {
      numList.add(int.parse(element.text));
    }

    return numList;
  }
}