import 'package:flutter/material.dart';

class MyWorkerPay extends StatelessWidget {
  const MyWorkerPay({super.key});

  // Example data: present days for each worker
  final List<int> presentDays = const [22, 20, 18, 25, 21];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workers Payroll Details"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Payroll Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: presentDays.length, // Use the length of your data
                itemBuilder: (context, index) {
                  int salaryPerDay = 1000; // Example salary per day
                  int present = presentDays[index];
                  int totalSalary = present * salaryPerDay;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text("Worker ${index + 1}"),
                      subtitle: Text("Salary: \$$totalSalary"),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        _showWorkerDetails(
                          context,
                          index,
                          present,
                          salaryPerDay,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showWorkerDetails(
  BuildContext context,
  int index,
  int presentDays,
  int salaryPerDay,
) {
  int totalSalary = presentDays * salaryPerDay;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Worker ${index + 1} Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: Worker ${index + 1}'),
            Text('Salary per day: \$$salaryPerDay'),
            Text('Present: $presentDays days'),
            const SizedBox(height: 12),
            const Text(
              'Attendance:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Present: $presentDays days'),
            Text(
              'Absent: ${25 - presentDays} days',
            ), // Example: 25 working days
            Text('Total Salary: \$$totalSalary'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
