import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMA Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'AMA Shop'),
      debugShowCheckedModeBanner: false,
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
  var price = TextEditingController();
  var quantity = TextEditingController();
  var change = TextEditingController();
  double _total = 0;
  double _change = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          priceTextField(),
          quantityTextField(),
          calculateBotton(),
          showTotalText(),
          changeTextField(),
          changeBotton(),
          showChangeText()
        ],
      ),
    );
  }

  Widget priceTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: price,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'ราคาสินค้าต่อหน่วย'),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget quantityTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: quantity,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'จำนวนสินค้าที่ซื้อ'),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget calculateBotton() {
    return ElevatedButton(
        onPressed: () {
          if (price.text.isNotEmpty && quantity.text.isNotEmpty) {
            setState(() {
              _total = double.parse(price.text) * double.parse(quantity.text);
            });
          }
        },
        child: const Text('คำนวณ'));
  }

  Widget showTotalText() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text('จำนวนเงินทั้งหมด : $_total บาท'),
    );
  }

  Widget changeTextField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: change,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), labelText: 'ลูกค้าให้เงินมา'),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget changeBotton() {
    return ElevatedButton(onPressed: () {
      if(change.text.isNotEmpty && (double.parse(change.text) < _total)){
        setState(() {
          _change = double.parse(change.text) - _total;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('คุณจ่ายเงินไม่ครบจำนวน')));
      }else if(change.text.isNotEmpty && (double.parse(change.text) >= _total)){
        setState(() {
          _change = double.parse(change.text) - _total;
        });
      }
    }, child: const Text('เงินทอน'));
  }

  Widget showChangeText() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text('เงินทอน : $_change บาท'),
    );
  }
}
