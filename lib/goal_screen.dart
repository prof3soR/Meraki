import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meraki/home_screen.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({Key? key}) : super(key: key);

  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  String _currentFeeling = "";
  bool _continueButtonEnabled = false;

  void _handleFeelingSelection(String feeling) {
    setState(() {
      _currentFeeling = feeling;
      _continueButtonEnabled = true;
    });

    if (_continueButtonEnabled) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetGoalScreen(currentFeeling: _currentFeeling),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How are you feeling today?'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: feelings.length,
                itemBuilder: (context, index) {
                  return GoalFeelingCard(
                    text: feelings[index],
                    onSelection: _handleFeelingSelection,
                    image: emojiImages[feelings[index]]!,
                    backgroundColor: bgcolour[index],
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _continueButtonEnabled
                ? () {
                    // Handle the continue button action
                    print(
                        'Continue button pressed with feeling: $_currentFeeling');
                  }
                : null,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class GoalFeelingCard extends StatelessWidget {
  final String text;
  final Function(String) onSelection;
  final String image;
  final Color backgroundColor;

  const GoalFeelingCard({
    Key? key,
    required this.text,
    required this.onSelection,
    required this.image,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => onSelection(text),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 100.0,
              width: 100.0,
            ),
            const SizedBox(height: 4.0),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class SetGoalScreen extends StatefulWidget {
  final String currentFeeling;

  const SetGoalScreen({Key? key, required this.currentFeeling})
      : super(key: key);

  @override
  _SetGoalScreenState createState() => _SetGoalScreenState();
}

class _SetGoalScreenState extends State<SetGoalScreen> {
  String _selectedGoal = "";
  bool _continueButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _continueButtonEnabled = false;
    _selectedGoal = "";
  }

  void _handleGoalSelection(String goal) {
    setState(() {
      _selectedGoal = goal;
      _continueButtonEnabled = true;
    });
  }

  void _saveUserDetails() async {
    if (_continueButtonEnabled) {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);

      await userDoc.set({
        'feeling': widget.currentFeeling,
        'goal': _selectedGoal,
      });

      print('User data saved to Firestore.');

      // Navigate to the next screen or perform any other actions
      if (_continueButtonEnabled) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Your Goal'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return GoalFeelingCard(
                    text: goals[index],
                    onSelection: _handleGoalSelection,
                    image: goalemojiImages[goals[index]]!,
                    backgroundColor: bgcolour[index],
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _continueButtonEnabled
                ? () {
                    print('Continue button pressed with goal: $_selectedGoal');
                    _saveUserDetails();
                  }
                : null,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

const List<String> feelings = [
  'Angry',
  'Sad',
  'Neutral',
  'Happy',
  'Excited',
  'Stressed'
];

const Map<String, String> emojiImages = {
  'Angry': 'assets/angry.png',
  'Sad': 'assets/sad.png',
  'Neutral': 'assets/neutral.png',
  'Happy': 'assets/happy.png',
  'Excited': 'assets/excited.png',
  'Stressed': 'assets/streesed.png',
};

const List<String> goals = [
  'Meditating',
  'Staying Active',
  'Self Growth',
  'Studying',
  'Self Love',
  'Reading',
  'Self Care',
  'Being Social'
];

const Map<String, String> goalemojiImages = {
  'Meditating': 'assets/g1.png',
  'Staying Active': 'assets/g2.png',
  'Self Growth': 'assets/g3.png',
  'Studying': "assets/g4.png",
  'Self Love': 'assets/g5.png',
  'Reading': 'assets/g6.png',
  'Self Care': 'assets/g7.png',
  'Being Social': 'assets/g8.png',
};
const List<Color> bgcolour = [
  Color.fromRGBO(197, 241, 207, 1),
  Color.fromRGBO(222, 225, 255, 1),
  Color.fromRGBO(216, 240, 255, 1),
  Color.fromRGBO(255, 226, 226, 1),
  Color.fromRGBO(229, 186, 239, 1),
  Color.fromRGBO(255, 186, 134, 1),
  Color.fromRGBO(255, 132, 62, 1),
  Color.fromRGBO(255, 226, 226, 1),
];
Widget _buildCircularBanner(String text) {
  return Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.blue, // Customize the color as needed
    ),
    child: Text(
      text,
      style: TextStyle(color: Colors.white),
    ),
  );
}
