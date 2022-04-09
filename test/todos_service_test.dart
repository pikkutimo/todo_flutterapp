import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_flutterapp/models/todos_model.dart';
import 'package:todo_flutterapp/services/todos_service.dart';
import 'todos_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('TodosService', () {
    const token = "MockitoMockin";
    test(
        '#1 fetchTodos - Return a list of Todos if the http call completes succesfully',
        () async {
      final client = MockClient();
      final todosService = TodosService();

      when(client.get(
        Uri.parse('https://rocky-harbor-47876.herokuapp.com/api/todos'),
        headers: {
          HttpHeaders.authorizationHeader: 'bearer $token',
        },
      )).thenAnswer((_) async => http.Response(
          '[{"content": "This is a test", "important": false, "done": false, "id": "1234"}, {"content": "This is a second test", "important": false, "done": false, "id": "1234"}]',
          200));

      final list = await todosService.fetchTodos(token, client);

      expect(list[0].content, equals("This is a test"));
    });
  });
}
