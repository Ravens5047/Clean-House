import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.dmSerifText(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. Service Provision'),
            _buildSectionContent(
              'Clean House Service provides cleaning services for households and other living spaces, upon request from customers.',
            ),
            _buildSectionTitle('2. Booking and Cancellation'),
            _buildSectionContent(
              'Customers can schedule appointments through our website or mobile app. If a cancellation is necessary, customers must provide at least 24 hours\' notice prior to the scheduled service time.',
            ),
            _buildSectionTitle('3. Pricing and Payment'),
            _buildSectionContent(
              'The price of the service is clearly displayed before booking. Payment can be made online or upon completion of the service.',
            ),
            _buildSectionTitle('4. Insurance and Liability'),
            _buildSectionContent(
              'Clean House Service has appropriate insurance and is responsible for damages incurred during the cleaning process, except those caused by customer mishaps or negligence.',
            ),
            _buildSectionTitle('5. Customer Rights and Obligations'),
            _buildSectionContent(
              'Customers are required to provide accurate and complete information about their requirements. They also need to ensure safe access for cleaning personnel at the agreed-upon time.',
            ),
            _buildSectionTitle('6. Service Cancellation Policy'),
            _buildSectionContent(
              'Clean House Service reserves the right to cancel services if customers fail to comply with specified terms and conditions, or if services cannot be completed due to circumstances beyond our control.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: GoogleFonts.dmSerifText(
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        content,
        style: GoogleFonts.kulimPark(
          fontSize: 16.0,
          color: Colors.black87,
        ),
      ),
    );
  }
}
