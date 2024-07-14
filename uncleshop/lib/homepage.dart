import 'package:flutter/material.dart';
import 'package:uncleshop/addpage.dart';
import 'package:uncleshop/database.dart';
import 'package:uncleshop/product.dart';
import 'package:uncleshop/updatepage.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Product product = Product();
  List<Product> productList = [];
  DatabaseSQL dbHelper = DatabaseSQL();

  // ตัวแปรเอาไปใช้ใน ListView
  late int updateIndex;
  late String pdName;
  late int pdQuan;
  late double pdPrice;
  late double pdTotal;
  late bool pdStatus;

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
        title: Text(widget.title),
      ),
      body: buildListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPage())).then((value){
                setState(() {
                  _refreshList();
                });
              });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildListView() {
    return Card(
      child: Scrollbar(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) {
            pdName = productList[index].name!;
            pdQuan = productList[index].quantity!;
            pdPrice = productList[index].price!;
            pdTotal = productList[index].total!;
            pdStatus = productList[index].status!;
            return ListTile(
              title: Text(pdName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('จำนวน : $pdQuan'),
                  Text('ราคาต่อหน่วย : $pdPrice'),
                  Text('ยอดรวม : $pdTotal'),
                  Text('สต็อกสินค้า : ${pdStatus ? 'มี' : 'ไม่มี'}'),
                ],
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdatePage(productList[index]))).then((value){
                                    setState(() {
                                      _refreshList();
                                    });
                                  });
                        },
                        icon: const Icon(Icons.edit, color: Colors.blue)),
                    IconButton(
                        onPressed: () {
                          dbHelper.deleteProduct(productList[index].id!).then((value){
                            setState(() {
                              _refreshList();
                            });
                          });
                        },
                        icon: const Icon(Icons.delete, color: Colors.red))
                  ],
                ),
              ),
            );
          },
          itemCount: productList.isEmpty ? 0 : productList.length,
        ),
      ),
    );
  }
}
