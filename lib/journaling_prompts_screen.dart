import 'dart:async';
import 'package:flutter/material.dart';

class JournalingPromptsScreen extends StatefulWidget {
  const JournalingPromptsScreen({Key? key}) : super(key: key);

  @override
  _JournalingPromptsScreenState createState() =>
      _JournalingPromptsScreenState();
}

class _JournalingPromptsScreenState extends State<JournalingPromptsScreen> {
  late List<String> prompts;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    prompts = [
      "What are three things that make you genuinely happy, and why?",
      "Describe a challenging situation you faced recently. How did you handle it, and what did you learn from the experience?",
      "If you could have a conversation with your future self, what advice would you ask for?",
      "What are your top three strengths, and how do they contribute to your life?",
      "Write about a role model or someone you admire. What qualities do they possess that you find inspiring?",
      "What are your short-term and long-term goals, and what steps can you take to achieve them?",
      "Reflect on a mistake you made. What did you learn, and how can you use this knowledge moving forward?",
      "If you had a superpower, what would it be, and how would you use it to make a positive impact?",
      "What does success mean to you, and how do you measure it in your own life?",
      "Describe a moment when you felt proud of yourself. What did you do, and why was it significant?",
      "List five things you are grateful for today and explain why they are important to you.",
      "If you could travel anywhere in the world, where would you go and what experiences would you seek?",
      "Explore a hobby or activity that you've never tried before. Write about your expectations and feelings.",
      "What are three values that are important to you, and how do they influence your decision-making?",
      "Reflect on a book, movie, or song that has had a profound impact on you. Why did it resonate with you?",
      "If you could change one thing about yourself, what would it be, and why?",
      "Write a letter to your past self, offering advice and encouragement.",
      "Explore a fear you have. What steps can you take to overcome or manage this fear?",
      "Describe a perfect day in your life. What activities would you engage in, and who would you spend it with?",
      "What are three challenges you foresee in your future, and how do you plan to tackle them?",
    ];
    prompts.shuffle();

    timer = Timer.periodic(Duration(hours: 24), (Timer t) {
      fetchNewPrompts();
    });
  }

  void fetchNewPrompts() {
    prompts = prompts + prompts;
    setState(() {
      if (prompts.length >= 4) {
        prompts = prompts.sublist(0, 4);
      } else {
        prompts = prompts;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Material(
        color: const Color.fromRGBO(255, 254, 240, 1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 227, 211, 1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                ),
                child: const Text(
                  "Journaling Prompts for Today",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(231, 246, 255, 1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                ),
                child: const Text(
                  "Write these prompts and the response in your journal",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  JournalCard(
                    color: const Color.fromRGBO(222, 225, 255, 1),
                    number: "1",
                    text: prompts[0],
                  ),
                  JournalCard(
                    color: const Color.fromRGBO(255, 250, 202, 1),
                    number: "2",
                    text: prompts[1],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  JournalCard(
                    color: const Color.fromRGBO(222, 225, 255, 1),
                    number: "3",
                    text: prompts[2],
                  ),
                  JournalCard(
                    color: const Color.fromRGBO(255, 250, 202, 1),
                    number: "4",
                    text: prompts[3],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JournalCard extends StatelessWidget {
  final Color color;
  final String number;
  final String text;

  const JournalCard({
    Key? key,
    required this.color,
    required this.number,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 24,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
