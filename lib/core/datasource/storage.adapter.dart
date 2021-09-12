import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageAdapter {
  Future<Map<String, dynamic>> load(String tag) async {
    final file = await openFile(tag);
    final content = await file.readAsString();
    return jsonDecode(content);
  }

  Future<void> store(String dataJson, String tag) async {
    final file = await openFile(tag);
    await file.writeAsString(dataJson);
  }

  Future<void> delete(String tag) async {
    final file = await openFile(tag);
    await file.delete();
  }

  Future<File> openFile(String tag) async {
    final storage =
        File('${(await getApplicationDocumentsDirectory()).path}/$tag.json');

    return await storage.exists() ? storage : await storage.create();
  }
}
