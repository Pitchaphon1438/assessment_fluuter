import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:flutter_application/product_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel> items = [];
  List<ProductModel> dataProductList = [
    ProductModel(
        1,
        "เสื้อยืดพิมพ์ลายกราฟิก",
        "ตัดเย็บจากผ้าฝ้ายผสมที่นุ่มสบาย ทรงพอดีตัว",
        "500 บาท",
        "QQQ",
        "M",
        "assets/images/img-1.PNG"),
    ProductModel(
        2,
        "เสื้อเบลาส์แขนระบาย",
        "สไตล์และเป็นผู้หญิง ตัดเย็บจากผ้าน้ำหนักเบาและระบายอากาศได้ดี",
        "650 บาท",
        "CVC",
        "XL",
        "assets/images/img-2.PNG"),
    ProductModel(
        3,
        "สเวตเตอร์ถักแสนสบาย",
        "เหมาะสำหรับวันที่อากาศหนาวเย็น ตัดเย็บจากผ้าเนื้อนุ่ม",
        "800 บาท",
        "UWU",
        "X",
        "assets/images/img-8.PNG"),
  ];
  // List<ProductModel> filteredProductList = dataProductList.where((product) => product.name.contains("เสื้อ")).toList();
  void filterSearchResults(String query) {
    setState(() {
      items = dataProductList
          .where((item) =>
              item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: "")),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                  Wrap(
                    children: [
                      for (var i = 0; i < items.length; i++)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                          dataProductList: items,
                                          index: i,
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: 80,
                            height: 120,
                            child: Image.asset(
                              items[i].imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
