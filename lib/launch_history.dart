import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class LaunchHistoryPage extends StatelessWidget {
  final DateFormat _dateFormat = DateFormat("MMMM dd, yyyy");

  final String _query = """
    query launchHistory {
        launchesPast(limit: 10) {
          mission_name
          launch_date_utc
          rocket {
            rocket_name
            rocket_type
          }
          links {
            flickr_images
          }
        }
      }
  """;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Launch History'),
        ),
        body: Query(
          options: QueryOptions(
            documentNode: gql(_query),
          ),
          builder: (
            QueryResult result, {
            VoidCallback refetch,
            FetchMore fetchMore,
          }) {
            if (result.loading) {
              return Container(
                child: Center(
                  child: Text("Loading"),
                ),
              );
            }

            final List launches = result.data["launchesPast"];

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: launches.length,
                    padding: const EdgeInsets.all(24),
                    itemBuilder: (context, index) {
                      final launch = launches[index];

                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              color: Colors.grey.shade300,
                         blurRadius: 30,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(right: 120),
                                    child: Text(
                                      launch['mission_name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "Rocket",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  Text(
                                    "${launch['rocket']['rocket_name']} | ${launch['rocket']['rocket_type']}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "Launch date",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  launch['launch_date_utc'] != null
                                      ? Text(
                                          "${_dateFormat.format(DateTime.parse(launch['launch_date_utc']))}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : Text(
                                          "TO BE DETERMINED",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
