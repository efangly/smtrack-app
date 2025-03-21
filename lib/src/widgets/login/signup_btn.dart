import 'package:flutter/material.dart';
import 'package:temp_noti/src/configs/route.dart' as custom_route;

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Don't have an account? ",
            style: TextStyle(fontSize: 18, color: Colors.white60),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              custom_route.Route.register,
            ),
            style: const ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size.zero),
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              "Sign up",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white60,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
