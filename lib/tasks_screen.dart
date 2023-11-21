import 'package:flutter/material.dart';

class Task {
  String description;
  bool isCompleted;

  Task(this.description, this.isCompleted);
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> allTasks = [
    Task(
        "Pick a Flower: Take a walk and pick a flower from a garden or a park. Place it in a vase in your room.",
        false),
    Task(
        "Write a Compliment: Leave a kind and anonymous compliment for someone — a friend, family member, or even a classmate.",
        false),
    Task(
        "Create a Positive Playlist: Make a playlist of songs that uplift your mood and make you happy. Listen to it when you need a boost.",
        false),
    Task(
        "Send a Handwritten Note: Write a thoughtful note or letter to someone you care about and mail it to them.",
        false),
    Task(
        "Random Act of Kindness: Perform a small act of kindness for a stranger, like holding the door open or helping someone carry their groceries.",
        false),
    Task(
        "Draw a Doodle: Spend a few minutes doodling or drawing something that brings you joy.",
        false),
    Task(
        "Take a Silly Selfie: Capture a lighthearted and silly selfie to share with friends or keep as a reminder of joy.",
        false),
    Task(
        "Smile at Strangers: Challenge yourself to smile at three strangers today and observe the positive impact.",
        false),
    Task(
        "Bake a Treat: Try baking cookies or another sweet treat and share them with friends or family.",
        false),
    Task(
        "Positive Sticky Notes: Leave positive sticky notes in unexpected places, like on a bathroom mirror or a friend's locker.",
        false),
    Task(
        "Compliment Yourself: Write down three things you like about yourself and reflect on them.",
        false),
    Task(
        "Outdoor Picnic: Pack a simple picnic and enjoy it in a local park or your backyard.",
        false),
    Task(
        "Create a DIY Project: Engage in a simple do-it-yourself project, whether making a bracelet, decorating a notebook, or creating art.",
        false),
    Task(
        "Dance Break: Take a break to dance to your favourite upbeat song. Let loose and enjoy the moment.",
        false),
    Task(
        "Mindful Breathing: Practice breathing exercises for a few minutes to calm your mind and reduce stress.",
        false),
    Task(
        "Positive Affirmations: Write down three positive affirmations about yourself and repeat them throughout the day.",
        false),
    Task(
        "Photograph a Happy Moment: Capture a moment that brings you joy with your phone or camera.",
        false),
    Task(
        "Visit a Pet Shelter: Spend time with animals at a local pet shelter or volunteer to walk dogs.",
        false),
    Task(
        "Write a Haiku: Express your feelings or a positive thought in a simple haiku poem.",
        false),
    Task(
        "Share a Joke: Share a lighthearted joke with a friend or family member to spread laughter.",
        false)
  ];

  List<Task> currentTasks = [];
  List<Task> completedTasks = [];

  void generateTasksForDay() {
    allTasks.shuffle();
    currentTasks = allTasks.take(5).toList();
  }

  int getCompletedTasksCount() {
    return completedTasks.length;
  }

  @override
  void initState() {
    super.initState();
    generateTasksForDay();
  }

  void handleCheckboxState(int index, bool? value) {
    setState(() {
      if (value != null) {
        currentTasks[index].isCompleted = value;

        if (value) {
          completedTasks.add(currentTasks[index]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Material(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0),
            border: Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 215, 215, 1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Wellness Tasks",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Tasks",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Priority: Making yourself better!",
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: ListView.builder(
                      itemCount: currentTasks.length,
                      itemBuilder: (context, index) {
                        var task = currentTasks[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                task.description,
                                style: TextStyle(
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              leading: Checkbox(
                                value: task.isCompleted,
                                onChanged: (bool? value) {
                                  handleCheckboxState(index, value);
                                },
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
