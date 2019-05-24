import 'package:flutter/material.dart';
import 'package:what_a_movie/bloc/app_bloc.dart';
import 'package:what_a_movie/bloc/bloc_provider.dart';
import 'package:what_a_movie/ui/sign_in/sign_in.dart';
import 'package:what_a_movie/ui/home.dart';

void main() {

  runApp(BlocProvider(
    bloc: AppBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  AppBloc _appBloc;

  @override
  void initState() {
    super.initState();
    _appBloc = BlocProvider.of<AppBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.cyan
      ),
      debugShowCheckedModeBanner: false,
      title: 'What A Movie',
      home: StreamBuilder(
          stream: _appBloc.stream,
          builder: (context, snapshot) {
            return snapshot.hasData ? Home() : SignIn();
          }),
    );
  }
}
