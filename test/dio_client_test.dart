import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snapcrate/utils/dio_client.dart';

void main() async {
  group("dio", () {
    test("basic get test for snapcrate ", () async {
      Response rawData = await Api().dio.get('/api/Auth/');
      print(rawData.data.runtimeType);
      expect(rawData.data, 'Hello');
    });
  });
}
