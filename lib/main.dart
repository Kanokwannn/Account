import 'package:flutter/material.dart';
import 'package:account/screens/form_screens.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:intl/intl.dart'; // Import this for date formatting

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'แอพบัญชี'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormScreen();
              }));
            },
          ),
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          if (provider.transactions.isEmpty) {
            return Center(
              child: Text('ไม่มีรายการ'),
            );
          } else {
            return ListView.builder(
              itemCount: provider.transactions.length,
              itemBuilder: (context, index) {
                final transaction = provider.transactions[index];
                final formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(transaction.date); // Corrected this line

                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(transaction.title), // Assuming there's a title property
                    subtitle: Text('${transaction.amount} - $formattedDate'), // Assuming you have an amount property
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text('${transaction.amount}'), // Use transaction here
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        provider.deleteTransaction(index);//delete
                      },
                    ),
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
