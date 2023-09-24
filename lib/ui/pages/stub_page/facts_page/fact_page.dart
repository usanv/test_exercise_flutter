import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:test_exersice/ui/pages/stub_page/facts_page/components.dart';
import 'package:test_exersice/ui/pages/stub_page/facts_page/fact_cards.dart';

class FactPage extends StatefulWidget {
  const FactPage({super.key});

  @override
  State<FactPage> createState() => _FactPageState();
}

class _FactPageState extends State<FactPage> {
  List<Fact> factList = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadFacts();
  }

  Future<void> loadFacts() async {
    final jsonText = await DefaultAssetBundle.of(context)
        .loadString('assets/json/fact.json');
    setState(() {
      isLoading = false; 
    });

    factList = parseFacts(jsonText);

    // for (final fact in factList) {
    //   print(fact.title);
    //   print(fact.fact);
    // }
  }

  List<Fact> parseFacts(String jsonText) {
    final jsonData = json.decode(jsonText);
    final factList = List<Fact>.from(
        jsonData['facts'].map((x) => Fact(x['title'], x['fact'])));
    return factList;
  }

  @override
  Widget build(BuildContext context) {
    return factList.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Swiper(
              itemBuilder: (context, index) {
                final randomIndex = Random().nextInt(factList.length);
                final randomFact = factList[randomIndex];
                if (factList.isEmpty) {
                  return Cards(title: randomFact.title, fact: randomFact.fact);
                } else {
                  return Cards(title: randomFact.title, fact: randomFact.fact);
                }
              },
              // autoplay: true,
              itemCount: factList.length,
              scrollDirection: Axis.vertical,
              // pagination: const SwiperPagination(alignment: Alignment.centerRight),
              control: const SwiperControl(
                  padding: EdgeInsets.only(top: 50, bottom: 30),
                  color: Colors.white),
            ),
          );
  }
}



// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     super.initState();
//     loadFacts();
//   }

//   Future<void> loadFacts() async {
//     // Загружаем JSON-файл
//     final jsonText = await DefaultAssetBundle.of(context).loadString('assets/json/fact.json');

//     // Парсим JSON и создаем список фактов
//     final factList = parseFacts(jsonText);

//     // Выводим факты
//     for (final fact in factList) {
//       print(fact.title);
//       print(fact.fact);
//       print('------');
//     }
//   }

//   List<Fact> parseFacts(String jsonText) {
//     final jsonData = json.decode(jsonText);
//     final factList = List<Fact>.from(jsonData['facts'].map((x) => Fact(x['title'], x['fact'])));
//     return factList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter JSON Example'),
//       ),
//       body: Center(
//         child: Text('Check the console for JSON data.'),
//       ),
//     );
//   }
// }