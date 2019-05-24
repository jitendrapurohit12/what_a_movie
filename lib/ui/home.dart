import 'package:flutter/material.dart';
import 'package:what_a_movie/dialogs/generic_dialogs.dart';
import 'package:what_a_movie/dialogs/switch_user.dart';
import 'package:what_a_movie/helper/db_helper/db_calls.dart';
import 'package:what_a_movie/helper/ui_helper.dart';
import 'package:what_a_movie/navigation/navigation.dart';
import 'package:what_a_movie/shared_preferences/get_preferences.dart';
import 'package:what_a_movie/shared_preferences/set_preferences.dart';
import 'package:what_a_movie/ui/favourites/favourites.dart';
import 'package:what_a_movie/ui/movies/movies.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _currentIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  String username = '';

  @override
  void initState() {
    super.initState();

    getUsername();
  }

  final List<Widget> pages = [
    Movies(
        //key: PageStorageKey('Movies'),
        ),
    Favourites(
        //key: PageStorageKey('Favourites'),
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $username'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.swap_horiz), onPressed: () => switchUser()),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => GenericDialogs.logoutDialog(context)),
        ],
      ),
      body: pages[
          _currentIndex] /*IndexedStack(
        index: _currentIndex,
        children: pages,
      )*/
      ,
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => onTabClicked(0),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: UIHelper.columnWithIconAndText(
                      Icons.movie,
                      'Movies',
                      _currentIndex == 0 ? Colors.blueAccent : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => onTabClicked(1),
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: UIHelper.columnWithIconAndText(
                      Icons.favorite,
                      'Favourites',
                      _currentIndex == 1 ? Colors.blueAccent : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onTabClicked(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  void getUsername() async {
    username = await GetPreferences.getUsername();
    setState(() {});
  }

  switchUser() async {
    String username2 = await GetPreferences.getUsername2();
    String username1 = await GetPreferences.getUsername1();
    String username = await GetPreferences.getUsername();
    if (username2 == null) {
      showDialog(context: context, builder: (context) => SwitchUserDialog());
    } else {
      GenericDialogs.progressDialog(context);
      DBCalls.signIn(username == username1 ? username2 : username1)
          .then((user) {
        if (user != null) {
          SetPreferences.setUserName(user.username);
          SetPreferences.setUserId(user.id);
          SetPreferences.setUserLoggedIn(true);
          Navigator.pop(context);
          Navigation.homeAndClearBackStack(context);
        } else {
          Navigator.pop(context);
          GenericDialogs.errorDialog(
              context, 'User might have been deactivated by the ADMIN!');
        }
      }).catchError((error) async {
        Navigator.pop(context);
        GenericDialogs.errorDialog(context, error.toString());
      });
    }
  }
}
