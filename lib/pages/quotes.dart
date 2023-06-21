import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quotes_app/widgets/quote_widget.dart';
import 'package:http/http.dart' as http;

class Quotes extends StatefulWidget {
  Quotes({
    super.key,
  });

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  var apiURL = "https://type.fit/api/quotes";

  Future<List<dynamic>> getPost() async {
    final response = await http.get(Uri.parse('$apiURL'));
    return postFormJson(response.body);
  }

  List<dynamic> postFormJson(String str) {
    final jsonData = json.decode(str);
    jsonData.shuffle();
    // var list = <QuoteModel>[];
    // list.addAll(jsonData.map((c) => QuoteModel.fromJson(c)).toList);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
          future: getPost(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                var error = snapshot.error;
                return ErrorWidget(error!);
              }
              return PageView.builder(
                scrollDirection: axisDirectionToAxis(AxisDirection.down),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var model = snapshot.data?[index];
                  return QuoteWidget(
                    quote: model["text"].toString(),
                    author: model["author"].toString(),
                  );
                },
              );
            } else
              return CircularProgressIndicator();
          }),
    );
  }
}
