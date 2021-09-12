import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_helper/core/datasource/storage.adapter.dart';
import 'package:movie_helper/features/discovery/data/model/movie.model.dart';

main() {
  late StorageAdapter storageAdapter;

  const testTag = 'test_tag';
  const testData = [
    MovieModel(
        posterPath: '/fYtHxTxlhzD4QWfEbrC1rypysSD.jpg',
        genres: [1, 2],
        voteAverage: 10.0,
        overview: 'Very scary movie',
        title: 'Jane Doe',
        id: 123)
  ];

  group('StorageAdapter', () {
    late Directory directory;

    setUpAll(() async {
      storageAdapter = StorageAdapter();
      directory = await Directory.systemTemp.createTemp();
      WidgetsFlutterBinding.ensureInitialized();
      MethodChannel pathChannel =
          const MethodChannel('plugins.flutter.io/path_provider');
      pathChannel.setMethodCallHandler((_) async {
        return directory.path;
      });
    });

    test('Should store movie list', () async {
      await storageAdapter.store(jsonEncode({'favorites': testData}), testTag);
      expect(directory.existsSync(), true);
    });

    test('Should load movie list', () async {
      final res = await storageAdapter.load(testTag);
      final movieList = List.from(res['favorites'])
          .map((x) => MovieModel.fromJson(x))
          .toList();
      expect(movieList, testData);
    });
  });
}
