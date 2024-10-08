import 'package:account/main.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/models/transaction.dart';

class EditScreen extends StatefulWidget {
  Transactions statement;

  EditScreen({super.key, required this.statement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final detailController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.statement.title;
    amountController.text = widget.statement.amount.toString();
    detailController.text = widget.statement.detail;
    nameController.text = widget.statement.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'แบบฟอร์มแก้ไขข้อมูล',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 117, 90, 164),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'ชื่อตัวละคร',
                    labelStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  autofocus: false,
                  controller: titleController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'ชื่อเกม',
                    labelStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  autofocus: false,
                  controller: nameController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'ระดับเลเวล',
                    labelStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  validator: (String? input) {
                    try {
                      double amount = double.parse(input!);
                      if (amount < 0) {
                        return 'กรุณากรอกข้อมูลมากกว่า 0';
                      }
                    } catch (e) {
                      return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'รายละเอียด',
                    labelStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  autofocus: false,
                  controller: detailController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min, // ให้ขนาดของ Row ขึ้นอยู่กับเนื้อหา
                      children: [
                        const Icon(
                          Icons.edit, // เปลี่ยนเป็นไอคอนที่คุณต้องการ
                          color: const Color.fromARGB(
                              255, 117, 90, 164), // เปลี่ยนสีไอคอนตามต้องการ
                        ),
                        const SizedBox(
                            width: 8), // ระยะห่างระหว่างไอคอนและข้อความ
                        const Text(
                          'แก้ไขข้อมูล',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var statement = Transactions(
                          keyID: widget.statement.keyID,
                          title: titleController.text,
                          amount: int.parse(amountController.text),
                          date: DateTime.now(),
                          detail: detailController.text,
                          name: nameController.text,
                        );

                        var provider = Provider.of<TransactionProvider>(context,
                            listen: false);

                        provider.updateTransaction(statement);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return MyHomePage();
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
