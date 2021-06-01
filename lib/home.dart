import 'package:flutter/material.dart';
import 'package:space_x_api_flutter/launch_history.dart';
import 'package:space_x_api_flutter/upcoming_launches.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LaunchHistoryPage()));
                },
                child: Text(
                  'Launch History',
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LaunchUpcomingPage()));
                },
                child: Text(
                  'Upcoming Launches',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
