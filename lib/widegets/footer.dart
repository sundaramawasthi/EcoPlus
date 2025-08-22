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
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 24,
        vertical: isMobile ? 24 : 40,
      ),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                children: const [
                  Icon(Icons.facebook, color: Colors.white),
                  Icon(Icons.alternate_email, color: Colors.white),
                  Icon(Icons.linked_camera, color: Colors.white),
                ],
              ),
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
                  fontWeight: FontWeight.bold,
                ),
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
              ),
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
