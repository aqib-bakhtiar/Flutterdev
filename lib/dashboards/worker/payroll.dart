import 'package:flutter/material.dart';

class MyPayroll extends StatelessWidget {
  const MyPayroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payroll"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.blue,
                  size: 40,
                ),
                title: const Text(
                  'Total Earnings',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  '\$2,500.00',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Recent Payments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.attach_money, color: Colors.green),
                    title: Text('April 2025'),
                    trailing: Text('\$800.00'),
                  ),
                  ListTile(
                    leading: Icon(Icons.attach_money, color: Colors.green),
                    title: Text('March 2025'),
                    trailing: Text('\$850.00'),
                  ),
                  ListTile(
                    leading: Icon(Icons.attach_money, color: Colors.green),
                    title: Text('February 2025'),
                    trailing: Text('\$850.00'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
