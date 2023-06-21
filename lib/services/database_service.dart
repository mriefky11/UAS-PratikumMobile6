import 'package:hive/hive.dart';

import '../models/quote.dart';

class DatabaseService {
  static const boxName = "quotes";

  Future<void> addQuote(Quote quote) async {
    final box = await Hive.openBox(boxName);
    box.add(quote);
  }

  Future<List<Quote>> getQuote(Quote quote) async {
    final box = await Hive.openBox(boxName);
    return box.get(quote.key).toList().cast<Quote>();
  }

  Future<void> editQuote(int key, Quote quote) async {
    final box = await Hive.openBox(boxName);
    box.put(key, quote);
  }

  Future<void> deleteQuote(Quote quote) async {
    final box = await Hive.openBox(boxName);
    box.delete(quote.key);
  }
}
