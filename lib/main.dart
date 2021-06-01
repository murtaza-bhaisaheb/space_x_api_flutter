import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:space_x_api_flutter/home.dart';
import 'package:space_x_api_flutter/launch_history.dart';
import 'package:space_x_api_flutter/upcoming_launches.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final HttpLink link = HttpLink(
    uri: 'https://api.spacex.land/graphql/',
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ),
  );

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {

  final ValueNotifier<GraphQLClient> client;

  const MyApp({Key key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,

          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
