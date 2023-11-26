import 'package:flutter/material.dart';
import 'package:idea_validator/components/answer.dart';

import './components/question.dart';

main() => runApp(const QuizApp());

class _QuizApp extends State<QuizApp> {
  var _selectedQuestion = 0;

  var _totalScore = 0;

  final _questions = const [
    {
      'question': 'Para quem você pretende comercializar seu aplicativo?',
      'answers': [
        {'answer': 'Pessoas físicas', 'score': 5},
        {'answer': 'Empresas', 'score': 10},
        {'answer': 'Instituições do governo', 'score': 1}
      ]
    },
    {
      'question': 'Qual o nicho de empresas que você imagina atender com seu aplicativo?',
      'answers': [
        {'answer': 'Freelancers / MEI', 'score': 5},
        {'answer': 'Pequenas e médias empresas', 'score': 10},
        {'answer': 'Grandes empresas multinacionais', 'score': 5},
      ]
    },
    {
      'question': 'Será fácil comprovar ao potencial usuário algum dos benefícios abaixo? Se mais de um, escolha o que está mais acima na lista.',
      'answers': [

        {'answer': 'Aumento de faturamento', 'score': 10},
        {'answer': 'Redução de custos', 'score': 8},
        {'answer': 'Automação e ganho de tempo', 'score': 8},
        {'answer': 'Nenhuma das propostas acima', 'score': 0},
      ]
    },
    {
      'question': 'Quantos usuários são necessários para que seu aplicativo comece a funcionar bem?',
      'answers': [
        {'answer': 'Tanto faz', 'score': 10},
        {'answer': 'Precisa de muitos usuários', 'score': 1},
      ]
    },
    {
      'question': 'Ao realizar o estudo de concorrentes, quais concorrentes você encontrou?',
      'answers': [
        {'answer': 'Nenhum concorrente', 'score': 5},
        {'answer': 'Somente concorrentes em inglês', 'score': 10},
        {'answer': 'Concorrentes ruins e medianos no Brasil', 'score': 8},
        {'answer': 'Concorrentes fortes no Brasil', 'score': 1},
      ]
    },
    {
      'question': 'Você tem (ou consegue) acesso à pessoas que já sofram com a dor que seu aplicativo se propõe a resolver, e que estejam dispostas a testar sua solução?',
      'answers': [
        {'answer': 'Não', 'score': 1},
        {'answer': 'Não, mas consigo', 'score': 5},
        {'answer': 'Sim', 'score': 10},
      ]
    },
    {
      'question': 'Dentre todas as possibilidades de monetização, você acredita que conseguirá cobrar assinatura de seus usuários?',
      'answers': [
        {'answer': 'Não', 'score': 1},
        {'answer': 'Sim', 'score': 10},
      ]
    }
  ];

  bool get hasQuestionSelected => _selectedQuestion < _questions.length;

  double get averageScore => _totalScore / _questions.length;

  Map<String, Object> resultMessage() {
    Map<String, Object> result;

    if (averageScore == 10) {
      result = {'text': 'Sua ideia é promissora e pode dar certo!', 'color': Colors.green};
    } else if (averageScore >= 6) {
      result = {'text': 'Sua ideia é boa, mas pode melhorar...', 'color': Colors.orange};
    } else {
      result = {'text': 'Sua ideia não vai pra frente!', 'color': Colors.red};
    }

    return result;
  }

  void answerQuestion(int score) {
    if (hasQuestionSelected) {
      setState(() {
        _totalScore += score;
        _selectedQuestion++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var answers = hasQuestionSelected
        ? _questions[_selectedQuestion]['answers'] as List<Map<String, Object>>
        : [];

    var resultMessage = this.resultMessage()['text'].toString();
    var resultColor = this.resultMessage()['color'] as Color;

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Validador de ideias'),
              backgroundColor: Colors.deepPurpleAccent,
              centerTitle: true,
              titleTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            body: hasQuestionSelected
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Question(_questions[_selectedQuestion]['question'].toString()),
                    ...answers.map((answer) => Answer(answer['answer'].toString(), onPressed: () => answerQuestion(answer['score'] as int))
                    ).toList()
                  ],
                )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          resultMessage,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: resultColor,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Text("Pontuação: ${averageScore.toInt()}/10",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: resultColor
                            )
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedQuestion = 0;
                              _totalScore = 0;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                            fixedSize: MaterialStateProperty.all(const Size(320, 30)),
                          ),
                          child: const Text('Reiniciar', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  )
        )
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizApp();
  }
}
