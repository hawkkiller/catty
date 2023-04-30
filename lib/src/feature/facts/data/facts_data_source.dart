import 'dart:async';

import 'package:dart_openai/openai.dart';
import 'package:stream_transform/stream_transform.dart';

abstract class FactsDataSource {
  Stream<String> getFact();
}

class FactsDataSourceGPT implements FactsDataSource {
  FactsDataSourceGPT();

  @override
  Stream<String> getFact() => OpenAI.instance.chat
      .createStream(
        temperature: 1,
        model: 'gpt-3.5-turbo',
        messages: [
          const OpenAIChatCompletionChoiceMessageModel(
            content: 'Generate a random fact about cats, maximum 200 characters.',
            role: OpenAIChatMessageRole.assistant,
          ),
        ],
      )
      .map<String?>((event) => event.choices.first.delta.content)
      .whereType();
}
