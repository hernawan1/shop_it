import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_it/common/constant.dart';
import 'package:shop_it/src/splash/splash_page.dart';

class Disconnected extends StatefulWidget {
  const Disconnected({Key? key}) : super(key: key);

  @override
  State<Disconnected> createState() => _DisconnectedState();
}

class _DisconnectedState extends State<Disconnected> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset("assets/disconnect.json"),
           const SizedBox(
              height: marginVertical,
            ),
            Text(
              "Yaah, Koneksimu terputus :(",
              style: textStyle.copyWith(
                color: primary,
                fontWeight: semiBold,
                fontSize: h3,
              ),
            ),
           const SizedBox(
              height: marginVertical,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (_) => const SplashScreen()),
                    (route) => false);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: marginHorizontal * 2,
                  vertical: marginVertical / 1.5,
                ),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(
                    marginVertical / 2,
                  ),
                ),
                child: Text(
                  "Coba Lagi",
                  style: textStyle.copyWith(
                    color: white,
                    fontWeight: semiBold,
                    fontSize: h3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
