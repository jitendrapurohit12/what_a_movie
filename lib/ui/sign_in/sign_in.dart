import 'package:flutter/material.dart';
import 'package:what_a_movie/animation/width_controller_animation.dart';
import 'package:what_a_movie/constants/constants.dart';
import 'package:what_a_movie/dialogs/generic_dialogs.dart';
import 'package:what_a_movie/helper/db_helper/db_calls.dart';
import 'package:what_a_movie/helper/method_helper.dart';
import 'package:what_a_movie/helper/ui_helper.dart';
import 'package:what_a_movie/listener/bool_listener.dart';
import 'package:what_a_movie/navigation/navigation.dart';
import 'package:what_a_movie/shared_preferences/set_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>
    with TickerProviderStateMixin
    implements BoolListener {
  AnimationController _loginButtonController;
  Animation<double> _buttonAnimation;
  TextEditingController _nameController;

  String _buttonText = 'Sign In';

  Widget get getButtonNestedWidget => _buttonText == null
      ? UIHelper.circularProgress()
      : WidthAnimationBuilder(
          _buttonAnimation,
          UIHelper.logInButton(
              UIHelper.buttonText(_buttonText, Colors.white), Colors.black));

  @override
  void initState() {
    super.initState();

    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    final CurvedAnimation buttonCurve =
        CurvedAnimation(parent: _loginButtonController, curve: Curves.ease);
    _buttonAnimation = Tween(begin: 250.0, end: 50.0).animate(buttonCurve);

    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              UIHelper.getTextField(
                  context, Labels.USERNAME, _nameController, null, 20),
              SizedBox(height: 36.0),
              GestureDetector(
                onTap: () async {
                  if (await MethodHelper.isInternetAvailable(context)) {
                    await _runAnimation();
                    DBCalls.signIn(_nameController.text.trim()).then((user) {
                      if (user != null) {
                        SetPreferences.setUserName(user.username);
                        SetPreferences.setUserId(user.id);
                        SetPreferences.setUserLoggedIn(true);
                        SetPreferences.setUsername1(user.username);
                        Navigation.homeAndClearBackStack(context);
                      }else{
                        _loginFailed(null);
                        GenericDialogs.createNewUserDialog(
                            context, Errors.USERNAME_DOES_NOT_EXISTS, this);
                      }
                    }).catchError((error) async {
                      if (await MethodHelper.isInternetAvailable(context)) {
                        GenericDialogs.errorDialog(context, error.toString());
                        _loginFailed(error.toString());
                      }
                    });
                  }
                },
                child: getButtonNestedWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _runAnimation() async {
    setState(() {
      _buttonText = '';
    });
    await _loginButtonController.forward();

    if (_loginButtonController.status == AnimationStatus.completed) {
      setState(() {
        _buttonText = null;
      });
    }
  }

  _loginFailed(String error) async {
    setState(() {
      _buttonText = '';
    });
    await _loginButtonController.reverse();
    setState(() {
      _buttonText = 'Sign In';
    });
  }

  @override
  void result(bool result, {Object data}) async {
    if (!result)
      Navigator.pop(context);
    else {
      Navigator.pop(context);
      if (await MethodHelper.isInternetAvailable(context)) {
        await _runAnimation();
        DBCalls.register(_nameController.text.trim()).then((user) {
          if (user != null) {
            SetPreferences.setUserName(user.username);
            SetPreferences.setUserId(user.id);
            SetPreferences.setUserLoggedIn(true);
            SetPreferences.setUsername1(user.username);
            Navigation.homeAndClearBackStack(context);
          } else {
            _loginFailed('');
            GenericDialogs.errorDialog(context, Errors.INVALID_USERNAME);
          }
        }).catchError((error) {
          _loginFailed(error.toString());
          GenericDialogs.errorDialog(context, error.toString());
        });
      }
    }
  }
}
