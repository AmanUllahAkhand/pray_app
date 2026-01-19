import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';
import '../controllers/privacy_policy_controller.dart';
import '../widgets/custom_text.dart';


class PrivacyPolicyScreen extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("QALAM App – Privacy Policy"),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title("Introduction"),
            _body(
                "Qalam (“we,” “our,” or “the App”) respects your privacy and is committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your information when you use the Qalam app."),

            _title("Information We Collect"),
            _bullet("Personal Information: Name, email address (if you create an account or subscribe to updates)."),
            _bullet("Location Data: For accurate prayer times and Qibla direction."),
            _bullet("App Usage Data: Features you use, frequency of use, crash reports, and analytics."),

            _title("How We Use Your Information"),
            _bullet("To provide accurate prayer times, Qibla direction, and other app features."),
            _bullet("To improve and maintain the app’s performance and user experience."),
            _bullet("To send optional updates, notifications, or announcements (if you opted-in)."),
            _bullet("To analyze app usage trends and make Qalam more effective and user-friendly."),

            _title("Information Sharing"),
            _body(
                "We do not sell, trade, or rent your personal information to third parties. We may share information with service providers who assist in app maintenance and analytics, but only to improve the app experience."),

            _title("Security"),
            _body(
                "We implement reasonable administrative, technical, and physical safeguards to protect your information. However, no method of transmission over the internet or electronic storage is 100% secure."),

            _title("Your Rights"),
            _body(
                "You have the right to access, update, or delete your personal information by contacting us at support@qalamapp.com."),

            _title("Changes to This Policy"),
            _body(
                "We may update this Privacy Policy from time to time. Any changes will be reflected in the app, and the date of the last revision will be updated."),

            _title("Contact Us"),
            _body("Email: support@qalamapp.com"),
            SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 10),
      child: CustomText(
        text: text,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
    );
  }

  Widget _body(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomText(
        text: text,
        fontSize: 14,
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• "),
          Expanded(child: CustomText(
            text: text,
            fontSize: 14,
          )),
        ],
      ),
    );
  }
}
