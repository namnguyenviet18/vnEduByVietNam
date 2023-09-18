
import 'package:flutter/material.dart';

import 'package:vnedu/const/constant.dart';
import 'package:vnedu/controller/appbar_provider.dart';
import 'package:vnedu/controller/update_user_provider.dart';
import 'package:vnedu/screens/my_profile_screen.dart';
import 'package:vnedu/screens/school_yard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late bool isLogged;

  Future<String> checkIsLogged() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = '';
    if(preferences.getString(Constants.TOKEN) != null) token = preferences.getString(Constants.TOKEN)!;
    print('token: $token');
    if(token.isEmpty) {
      isLogged = false;
    }else {
      isLogged = true;
    }
    return token;
  }

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3)
    );
    _animationController.repeat();
    checkIsLogged().then((token) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        final controller = Provider.of<AppBarNotifier>(context, listen: false);
        controller.getData().then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return SchoolYardScreen(isLogged: isLogged);
          }));
        });
      });
    });

    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset('assets/images/lms_logo.png', fit: BoxFit.cover,),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: LinearProgressIndicator(
                  value: _animationController.value,
                  semanticsLabel: 'Linear progress indicator',
                  color: Colors.amber,

                ),
              )
            ],
          ),
        )
      ),
    );
  }

}