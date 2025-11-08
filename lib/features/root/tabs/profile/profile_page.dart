import 'package:flutter/material.dart';
import 'package:miigaik/features/edini-dekanat/edini_dekanat_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 14,
          children: [
            FilledButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EdiniDekanatPage.spravki()),
              );
            }, child: Text("Заказать справку")),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EdiniDekanatPage.dopuski()),
                );
              },
              child: Text("Заказать допуск"),
            ),
          ],
        ),
      ),
    );
  }
}
