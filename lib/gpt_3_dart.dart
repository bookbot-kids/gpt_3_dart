library gpt3_dart;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';


class Param {
  String name;
  var value;

  Param(this.name, this.value);

  @override
  String toString() {
    return '{ ${this.name}, ${this.value} }';
  }
}

class OpenAI {
  String apiKey;
  OpenAI({required this.apiKey});

  Uri getUrl(function) {
    String url = 'https://api.openai.com/v1/chat/$function';
    return Uri.parse(url);
  }

  Future<String?> complete(String prompt, int maxTokens,
      {String? engine,
      num? temperature,
      num? topP,
      num? frequencyPenalty,
      num? presencePenalty,
      int? n,
      bool? stream,
      int? logProbs,
      bool? echo}) async {
    String apiKey = this.apiKey;

    List data = [];
    data.add(Param('model', engine));
    data.add(Param('temperature', temperature));
    data.add(Param('top_p', topP));
    data.add(Param('frequency_penalty', frequencyPenalty));
    data.add(Param('presence_penalty', presencePenalty));
    data.add(Param('n', n));
    data.add(Param('stream', stream));
    data.add(Param('logprobs', logProbs));
    data.add(Param('echo', echo));
    Map map2 =
        Map.fromIterable(data, key: (e) => e.name, value: (e) => e.value);
    map2.removeWhere((key, value) => key == null || value == null);
    Map map1 = {"messages": [{"role": "user", "content": prompt}], "max_tokens": maxTokens};
    Map reqData = {...map1, ...map2};
    var response = await http
        .post(
          getUrl("completions"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $apiKey",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: jsonEncode(reqData),
        )
        .timeout(const Duration(seconds: 120));
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> resp = map["choices"];

    return resp[0]["message"]["content"];
  }
}
