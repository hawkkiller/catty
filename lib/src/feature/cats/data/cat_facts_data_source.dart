import 'dart:async';

import 'package:dart_openai/dart_openai.dart';
import 'package:stream_transform/stream_transform.dart';

/// {@template facts_data_source}
/// [CatFactsDataSource] is an entry point to the facts data layer.
/// {@endtemplate}
abstract class CatFactsDataSource {
  /// Returns a streamed response of a random fact about cats
  Stream<String> getFact();
}

/// {@template facts_data_source_gpt}
/// [CatFactsDataSourceGPT] generates responses using ChatGPT.
/// {@endtemplate}
class CatFactsDataSourceGPT implements CatFactsDataSource {
  /// {@macro facts_data_source_gpt}
  CatFactsDataSourceGPT();

  @override
  Stream<String> getFact() => OpenAI.instance.chat
      .createStream(
        temperature: 1,
        model: 'gpt-3.5-turbo',
        messages: [
          const OpenAIChatCompletionChoiceMessageModel(
            content:
                'Generate a random fact about cats, maximum 200 characters.',
            role: OpenAIChatMessageRole.assistant,
          ),
        ],
      )
      .map<String?>((event) => event.choices.first.delta.content)
      .whereType();
}
