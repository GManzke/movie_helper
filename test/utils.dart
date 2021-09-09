import 'dart:convert';
import 'dart:io';

const _jsonPath = 'test/features/';

Map<String, dynamic> readJsonFile(String path) =>
    json.decode(File(_jsonPath + path).readAsStringSync());
