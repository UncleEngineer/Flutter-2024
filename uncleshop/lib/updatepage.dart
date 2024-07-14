import 'package:flutter/material.dart';
import 'package:uncleshop/database.dart';
import 'package:uncleshop/product.dart';

class UpdatePage extends StatefulWidget {
  final Product updateProduct;
  const UpdatePage(this.updateProduct, {super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  Product updateProduct = Product();
  List<Product> productList = [];
  DatabaseSQL dbHelper = DatabaseSQL();
  final _formKey = GlobalKey<FormState>();

  //ตัวแปรที่ไปใช้กับ Form
  late int selectedID;
  late TextEditingController _pdNameCtrl;
  late TextEditingController _pdQuanCtrl;
  late TextEditingController _pdPriceCtrl;
  late double _updateTotal;
  late bool _updateStatus;

  @override
  void initState() {
    super.initState();
    // ดึงค่า ID ที่ต้องการอัพเดต
    selectedID = widget.updateProduct.id!;
    // ดึงค่าจาก ListView หน้า HomePage
    _pdNameCtrl = TextEditingController(text: widget.updateProduct.name);
    _pdQuanCtrl = TextEditingController(text: widget.updateProduct.quantity.toString());
    _pdPriceCtrl = TextEditingController(text: widget.updateProduct.price.toString());
    _updateTotal = widget.updateProduct.total!;
    _updateStatus = widget.updateProduct.status!;
  }

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
        key: _formKey,
          child: Column(
        children: [
          TextFormField(
            controller: _pdNameCtrl,
            decoration: const InputDecoration(
              labelText: 'ชื่อสินค้า',
            ),
            onSaved: (String? value) {
              setState(() {
                updateProduct.name = value!;
              });
            },
            validator: (String? value) => value!.isEmpty ? 'คุณไม่ได้ป้อนชื่อสินค้า':null
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _pdQuanCtrl,
            decoration: const InputDecoration(
              labelText: 'จำนวนสินค้า',
            ),
            keyboardType: TextInputType.number,
            onSaved: (String? value) {
              setState(() {
                updateProduct.quantity = int.parse(value!);
              });
            },
            validator: (String? value) => value!.isEmpty ? 'คุณไม่ได้ป้อนจำนวนสินค้า':null
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _pdPriceCtrl,
            decoration: const InputDecoration(
              labelText: 'ราคาต่อหน่วย',
            ),
            keyboardType: TextInputType.number,
            onSaved: (String? value) {
              setState(() {
                updateProduct.price = double.parse(value!);
              });
            },
            validator: (String? value) => value!.isEmpty ? 'คุณไม่ได้ป้อนราคาสินค้า':null,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('มีอยู่ในสต็อกหรือไม่ ?'),
              Checkbox(value: _updateStatus, onChanged: (value) {
                setState(() {
                  _updateStatus = value!;
                });
              })
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(onPressed: () {
            if (_formKey.currentState!.validate()){
              updateToDatabase(context);
            }
          }, child: const Text('บันทึก'))
        ],
      )),
    );
  }

  updateToDatabase(BuildContext context) async{
    _formKey.currentState!.save();
    _updateTotal = updateProduct.quantity! * updateProduct.price!;
    updateProduct = Product(
      id: selectedID,
      name: updateProduct.name,
      quantity: updateProduct.quantity,
      price: updateProduct.price,
      total: _updateTotal,
      status: _updateStatus
    );
    // เช็คว่าข้อมูลถูกแก้ไขแล้ว
    bool isUpdated = true;
    if(isUpdated){
      Navigator.pop(context, isUpdated);
      await dbHelper.updateProduct(updateProduct);
    }
  }
}
