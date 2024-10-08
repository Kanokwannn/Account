import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 117, 90, 164),
        title: const Text(
          "ตัวละครในเกม",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          if (provider.transactions.isEmpty) {
            return const Center(
                child: Text('ไม่มีรายการ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    )));
          } else {
            return ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (context, index) {
                var statement = provider.transactions[index];
                return Card(
                  elevation: 8,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: ListTile(
                    title: Text(
                      'Name: ${statement.title}\nLevel : ${statement.amount}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 64, 36, 112),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '   detail ${statement.detail}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          DateFormat('dd MMM yyyy hh:mm:ss')
                              .format(statement.date),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 72, 72, 72),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/564x/c0/3e/80/c03e80ee22dc41747e552ad587df098a.jpg'),
                      //backgroundColor: Color.fromARGB(255, 64, 36, 112),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.deepOrange),
                      onPressed: () {
                        provider.deleteTransaction(statement.keyID);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EditScreen(statement: statement);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
