# GPT-3 Dart

A simple Dart package to use with OpenAI's GPT-3 API.

## Installation

```yaml
dependencies:
  flutter:
    sdk: flutter
  gpt_3_dart:
```

## Usage

```dart
import 'package:gpt_3_dart/gpt_3_dart.dart';

void main() async {
  OpenAI openAI = new OpenAI(apiKey: "API_KEY_HERE");

  // generate summary of a Wikipedia article
  String summary_prompt = "Summarize this for a toddler:\n\n"
  String wikipedia_article = "WIKIPEDIA_ARTICLE_HERE"
  String summary = await openAI.complete(summary_prompt + wikipedia_article, 200, engine: "text-davinci-001", temperature: 0.7, topP: 1.0, frequencyPenalty: 0, presencePenalty: 0);
  print(summary);

  // generate questions from summary
  String question_generation_prompt = "Generate questions given this paragraph:\n\n"
  String questions = await openAI.complete(questions_generation_prompt + summary, 200, engine: "text-davinci-001", temperature: 0.7, topP: 1.0, frequencyPenalty: 0, presencePenalty: 0);
  print(questions)
}
```

## Example App

|     Text Completion     |    Semantic Search    |
| :---------------------: | :-------------------: |
| ![](doc/completion.jpg) | ![](doc/semantic.jpg) |
