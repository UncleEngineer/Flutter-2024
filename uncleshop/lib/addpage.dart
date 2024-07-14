import 'package:flutter/material.dart';
import 'package:uncleshop/database.dart';
import 'package:uncleshop/product.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Product product = Product();
  List<Product> productList = [];
  DatabaseSQL dbHelper = DatabaseSQL();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    product.status = false;
    _refreshList();
  }

  _refreshList() async {
    List<Product> lists = await dbHelper.readProducts();
    setState(() {
      productList = lists;
    });
  }

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
        key: _formKey,
          child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ชื่อสินค้า',
            ),
            onSaved: (String? value) {
              setState(() {
                product.name = value!;
              });
            },
            validator: (String? value) => value!.isEmpty ? 'คุณไม่ได้ป้อนชื่อสินค้า':null
          ),
          const SizedBox(height: 15),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'จำนวนสินค้า',
            ),
            keyboardType: TextInputType.number,
            onSaved: (String? value) {
              setState(() {
                product.quantity = int.parse(value!);
              });
            },
            validator: (String? value) => value!.isEmpty ? 'คุณไม่ได้ป้อนจำนวนสินค้า':null
          ),
          const SizedBox(height: 15),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ราคาต่อหน่วย',
            ),
            keyboardType: TextInputType.number,
            onSaved: (String? value) {
              setState(() {
                product.price = double.parse(value!);
              });
            },
            validator: (String? value) => value!.isEmpty ? 'คุณไม่ได้ป้อนราคาสินค้า':null,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('มีอยู่ในสต็อกหรือไม่ ?'),
              Checkbox(value: product.status, onChanged: (value) {
                setState(() {
                  product.status = value!;
                });
              })
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(onPressed: () {
            if(_formKey.currentState!.validate()){
              saveToDatabase();
            }
          }, child: const Text('บันทึก'))
        ],
      )),
    );
  }

  saveToDatabase() async {
    _formKey.currentState!.save();
    product.total = product.quantity! * product.price!;
    product = Product(
      name: product.name,
      quantity: product.quantity,
      price: product.price,
      total: product.total,
      status: product.status
    );
    await dbHelper.createProduct(product);
    _formKey.currentState!.reset();
    setState(() {
      product.status = false;
    });
  }
}
