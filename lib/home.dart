import 'package:flutter/material.dart';
import 'package:flutter_application/models/product_model.dart';
import 'package:flutter_application/product_page.dart';
import 'package:flutter_application/search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.red),
                child: Container(
                  width: 60,
                  height: 24,
                  margin: const EdgeInsets.all(5),
                  child: const Row(
                    children: [
                      Icon(Icons.abc),
                      Text(
                        "Filter",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              child: const Text(
                "Welcome MJ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      Container(
                        height: 30,
                        margin: const EdgeInsets.only(left: 20),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "What are you looking for?",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width / 0.3,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/images/p-1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: const Text("What's new",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: [
                for (var i = 0; i < dataProductList.length; i++)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage(
                                    dataProductList: dataProductList,
                                    index: i,
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 80,
                      height: 120,
                      child: Image.asset(
                        dataProductList[i].imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    )));
  }

  Widget dispalyProduct() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: dataProductList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: EdgeInsets.all(10),
            width: 60,
            height: 180,
            // width: MediaQuery.of(context).size.width / 2,
            child: Image.asset(
              dataProductList[index].imagePath,
              fit: BoxFit.cover,
            ));
      },
    );
  }
}
