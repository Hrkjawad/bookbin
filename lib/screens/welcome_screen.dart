import 'package:BookBin/utilitis/assets_paths.dart';
import 'package:BookBin/screens/widgets/screen_background.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 143,
              ),
              Image.asset(ImagesPath.welcomeLogo),
              const SizedBox(
                height: 39,
              ),
              const Text(
                "Welcome to\nBookBin",
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 39,
              ),
              const Text(
                "We will help you to buy textbooks at\ncheaper rate and earn money by selling\nused text books at reasonable price.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF595959),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 36,
              ),
              SizedBox(
                height: 60,
                width: 378,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF626262),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFFA158AD),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
