import 'package:flutter/material.dart';
import 'package:uncleshop/addpage.dart';
import 'package:uncleshop/updatepage.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: buildListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPage()));
        }, tooltip: 'Add', child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildListView() {
    return Card(
      child: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: const Text('Product 1'),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('จำนวน : '),
                  Text('ราคาต่อหน่วย : '),
                  Text('ยอดรวม : '),
                  Text('สต็อกสินค้า : '),
                ],
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdatePage()));
                    }, icon: const Icon(Icons.edit, color: Colors.blue)),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.delete, color: Colors.red))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
