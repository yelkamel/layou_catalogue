import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database/evo.dart';
import 'screen/course/index.dart';
import 'screen/mood/index.dart';
import 'screen/music/index.dart';
import 'screen/reco/index.dart';
import 'subapp/evo_edit/edit_audio.dart';

class UITest extends StatefulWidget {
  @override
  _UITestState createState() => _UITestState();
}

class _UITestState extends State<UITest> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Widget _buildTabs() {
      return Container(
        color: Colors.blueGrey,
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TabBar(
              tabs: <Widget>[
                Text("Mood", style: TextStyle(fontSize: 12)),
                Text("All", style: TextStyle(fontSize: 12)),
                Text("Program", style: TextStyle(fontSize: 12)),
                Text("Music", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      );
    }

    final database = Provider.of<EvoDatabase>(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: _buildTabs(),
        body: const Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: TabBarView(
            children: <Widget>[
              MoodRoot(),
              RecoRoot(),
              CourseRoot(),
              MusicRoot(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => EditAudioScreen.show(context, database),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
