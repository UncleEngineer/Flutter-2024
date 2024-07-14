import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('เพิ่มรายการสินค้า'),
      ),
      body: buildForm(),
    );
  }

  Widget buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
          child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ชื่อสินค้า',
            ),
            onSaved: (String? value) {},
            validator: (String? value) {},
          ),
          const SizedBox(height: 15),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'จำนวนสินค้า',
            ),
            keyboardType: TextInputType.number,
            onSaved: (String? value) {},
            validator: (String? value) {},
          ),
          const SizedBox(height: 15),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ราคาต่อหน่วย',
            ),
            keyboardType: TextInputType.number,
            onSaved: (String? value) {},
            validator: (String? value) {},
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('มีอยู่ในสต็อกหรือไม่ ?'),
              Checkbox(value: false, onChanged: (value) {})
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(onPressed: () {}, child: const Text('บันทึก'))
        ],
      )),
    );
  }
}
