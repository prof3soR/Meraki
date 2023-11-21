import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EQ Journey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EQScreen(),
    );
  }
}

class EQScreen extends StatefulWidget {
  @override
  _EQScreenState createState() => _EQScreenState();
}

class _EQScreenState extends State<EQScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the height of the status bar

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('EQ').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              print('Error fetching EQ data: ${snapshot.error}');
              return Text('Error: ${snapshot.error}');
            } else {
              List<String> eqTitles = snapshot.data!.docs
                  .map((doc) => doc['Title']?.toString() ?? '')
                  .toList();
              return EQJourneyCarousel(eqTitles);
            }
          },
        ),
      ),
    );
  }
}

class EQJourneyCarousel extends StatelessWidget {
  final List<String> titles;

  const EQJourneyCarousel(this.titles, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionWithTitleAndCarousel(
          'EQ Journey',
          CarouselSlider(
            items: titles.map((title) => EQJourneyCard(title)).toList(),
            options: CarouselOptions(
              aspectRatio: 2,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
            ),
          ),
        ),
      ],
    );
  }
}

class EQJourneyCard extends StatelessWidget {
  final String title;

  EQJourneyCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4, // Add elevation for shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Add border radius
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [
              Colors.lightBlue,
              Color.fromARGB(255, 215, 153, 247),
              Color.fromARGB(255, 235, 227, 239),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(163, 0, 0, 0),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonsScreen(title),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LessonsScreen extends StatelessWidget {
  final String topic;

  const LessonsScreen(this.topic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 50), // Added margin at the top
          // Larger Title Card
          Card(
            margin: const EdgeInsets.all(16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              height: 120, // Set the desired height
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    Colors.lightBlue,
                    Color.fromARGB(255, 215, 153, 247),
                    Color.fromARGB(255, 235, 227, 239),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    topic,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Three Outlined Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () {
                  // Handle Lessons button press
                },
                child: const Text("Lessons"),
              ),
              OutlinedButton(
                onPressed: () {
                  // Handle Review button press
                },
                child: const Text("Review"),
              ),
              OutlinedButton(
                onPressed: () {
                  // Handle About button press
                },
                child: const Text("About"),
              ),
            ],
          ),
          // Main Container with Border Radius
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8), // Added margin
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: Colors.black.withOpacity(0.2)), // Added border
              gradient: const LinearGradient(
                colors: [
                  Colors.lightBlue,
                  Color.fromARGB(255, 215, 153, 247),
                  Color.fromARGB(255, 235, 227, 239),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection(topic).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print('Error fetching lessons: ${snapshot.error}');
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('Lessons will be added soon!'));
                    } else {
                      List<Widget> lessonWidgets =
                          snapshot.data!.docs.map((lessonDoc) {
                        Map<String, dynamic> lessonData =
                            lessonDoc.data() as Map<String, dynamic>;
                        return ListTile(
                          title: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  8), // Adjust the border radius as needed
                              border: Border.all(
                                  color: Colors.black.withOpacity(
                                      0.5)), // Adjust the color and opacity as needed
                            ),
                            child: Text(
                              lessonData['Title']?.toString() ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailedLessonScreen(lessonData),
                              ),
                            );
                          },
                        );
                      }).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: lessonWidgets,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailedLessonScreen extends StatelessWidget {
  final Map<String, dynamic> lessonData;

  const DetailedLessonScreen(this.lessonData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 24), // Ample top margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container with Network Image
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue,
                    Color.fromARGB(255, 215, 153, 247),
                    Color.fromARGB(255, 235, 227, 239),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Image.network(
                lessonData['Image']?.toString() ??
                    '', // Replace 'image' with the correct field name
                height: 200, // Set the desired height
                fit: BoxFit.fill,
              ),
            ),
            // Container with Lesson Content and Outline
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black.withOpacity(0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Lesson Title
                  Text(
                    lessonData['Title']?.toString() ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Lesson Content
                  Text(
                    lessonData['Content']?.toString() ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionWithTitleAndCarousel extends StatelessWidget {
  final String title;
  final Widget carousel;

  const SectionWithTitleAndCarousel(this.title, this.carousel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle(title),
        carousel,
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}
