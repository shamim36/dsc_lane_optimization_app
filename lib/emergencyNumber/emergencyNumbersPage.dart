import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumbersPage extends StatelessWidget {
  final List<Map<String, String>> emergencyNumbers = [
    {"title": "National Emergency Service", "number": "999"},
    {"title": "Police Headquarters", "number": "100"},
    {"title": "Fire Service", "number": "199"},
    {"title": "Ambulance Service", "number": "19971"},
    {"title": "Bangladesh Red Crescent Society", "number": "01747-444555"},
    {"title": "Women's Helpline", "number": "109"},
    {"title": "Child Helpline", "number": "1098"},
    {"title": "Gas Emergency", "number": "16429"},
    {"title": "Electricity Emergency", "number": "19113"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Emergency Numbers",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: emergencyNumbers.length,
            itemBuilder: (context, index) {
              final item = emergencyNumbers[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4.0,
                child: ListTile(
                  title: Text(
                    item["title"]!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    item["number"]!,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () {
                      _makePhoneCall(item["number"]!);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _makePhoneCall(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print("Cannot launch phone call for $number");
    }
  }
}
