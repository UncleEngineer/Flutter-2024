import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('แก้ไขรายการสินค้า'),
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