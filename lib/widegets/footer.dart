import 'package:flutter/material.dart';
import '../core/appTheame.dart';
import '../core/responsive.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppTheme.dark,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isMobile
              ? Column(
            children: [
              const Text(
                "EcoPulse",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.facebook, color: Colors.white),
                  SizedBox(width: 16),
                  Icon(Icons.alternate_email, color: Colors.white),
                  SizedBox(width: 16),
                  Icon(Icons.linked_camera, color: Colors.white),
                ],
              )
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "EcoPulse",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Row(
                children: const [
                  Icon(Icons.facebook, color: Colors.white),
                  SizedBox(width: 16),
                  Icon(Icons.alternate_email, color: Colors.white),
                  SizedBox(width: 16),
                  Icon(Icons.linked_camera, color: Colors.white),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "© 2025 EcoPulse. All rights reserved.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
