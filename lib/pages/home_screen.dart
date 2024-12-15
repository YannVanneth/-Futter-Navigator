import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navigate_route/models/productitems.dart';
import 'package:navigate_route/pages/add_cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var items = <String, dynamic>{"Color": Colors.blue, "Size": 200.0};

  List<Products> cartItems = [];

  int updateCart() {
    var numberOfItems = 0;
    for (var i in cartItems) {
      numberOfItems += i.quantity;
    }

    return numberOfItems;
  }

  @override
  Widget build(BuildContext context) {
    var dataItems =
        ModalRoute.of(context)?.settings.arguments as List<Products>? ?? [];

    if (dataItems.isNotEmpty) {
      cartItems = dataItems;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
        actions: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings: RouteSettings(arguments: cartItems),
                        builder: (context) => AddCartScreen(),
                      )),
                  child: SvgPicture.asset("assets/shopping basket 03.svg"),
                ),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  top: updateCart().toString().length > 1 ? 3 : 0,
                  right: updateCart().toString().length > 1 ? 0 : 4,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Text(
                      updateCart().toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              updateCart().toString().length > 1 ? 12 : 14),
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [heroBox(context), colorAndProSize(), Spacer(), bottomArea()],
      )),
    );
  }

  Widget bottomArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        spacing: 10,
        children: [
          button(
            context,
            func: () => setState(() {
              var item = Products.add(items);

              if (cartItems.isNotEmpty) {
                for (var i = 0; i < cartItems.length; i++) {
                  if (cartItems[i].size == item.size &&
                      cartItems[i].color == item.color) {
                    cartItems[i].quantity++;
                    return;
                  }
                }
                cartItems.add(item);
              } else {
                cartItems.add(item);
              }
            }),
            height: 45,
            width: MediaQuery.sizeOf(context).width * 0.60,
            child: Center(
              child: Text(
                "Add to Cart",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          button(context,
              func: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(arguments: cartItems),
                    builder: (context) => AddCartScreen(),
                  )),
              height: 45,
              width: MediaQuery.sizeOf(context).width * 0.3,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                  child: Text(
                "Buy now",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )))
        ],
      ),
    );
  }

  Widget colorAndProSize() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          color(),
          proSize(),
        ],
      ),
    );
  }

  Widget color({double size = 65}) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color : ${items['Color'] == Colors.green ? "Green" : items['Color'] == Colors.red ? "Red" : "Blue"}",
          style: TextStyle(fontSize: 18),
        ),
        Row(
          spacing: 10,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                items['Color'] = Colors.blue;
              }),
              child: rectangleBox(
                  size: size,
                  color: Colors.blue,
                  colorBorder: items['Color'] == Colors.blue
                      ? Colors.black
                      : Colors.transparent),
            ),
            GestureDetector(
              onTap: () => setState(() {
                items['Color'] = Colors.green;
              }),
              child: rectangleBox(
                  size: size,
                  color: Colors.green,
                  colorBorder: items['Color'] == Colors.green
                      ? Colors.black
                      : Colors.transparent),
            ),
            GestureDetector(
              onTap: () => setState(() {
                items['Color'] = Colors.red;
              }),
              child: rectangleBox(
                  size: size,
                  color: Colors.red,
                  colorBorder: items['Color'] == Colors.red
                      ? Colors.black
                      : Colors.transparent),
            ),
          ],
        )
      ],
    );
  }

  Widget proSize({double size = 40}) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Size : ${items['Size'].toString()}",
          style: TextStyle(fontSize: 18),
        ),
        Row(
          spacing: 10,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                items['Size'] = 200.0;
              }),
              child: rectangleBox(
                  size: size,
                  color: Colors.transparent,
                  colorBorder:
                      items['Size'] == 200 ? Colors.black : Colors.grey,
                  child: Center(
                      child: Text(
                    "200",
                    style: TextStyle(
                        color:
                            items['Size'] == 200 ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold),
                  ))),
            ),
            GestureDetector(
              onTap: () => setState(() {
                items['Size'] = 150.0;
              }),
              child: rectangleBox(
                  size: size,
                  color: Colors.transparent,
                  colorBorder:
                      items['Size'] == 150 ? Colors.black : Colors.grey,
                  child: Center(
                      child: Text(
                    "150",
                    style: TextStyle(
                        color:
                            items['Size'] == 150 ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold),
                  ))),
            ),
            GestureDetector(
              onTap: () => setState(() {
                items['Size'] = 100.0;
              }),
              child: rectangleBox(
                  size: size,
                  color: Colors.transparent,
                  colorBorder:
                      items['Size'] == 100 ? Colors.black : Colors.grey,
                  child: Center(
                      child: Text(
                    "100",
                    style: TextStyle(
                        color:
                            items['Size'] == 100 ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold),
                  ))),
            ),
          ],
        )
      ],
    );
  }

  Widget heroBox(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.4,
      child: Center(
        child: rectangleBox(
            size: items['Size'],
            color: items['Color'] == Colors.blue
                ? Colors.blue
                : items['Color'] == Colors.green
                    ? Colors.green
                    : Colors.red),
      ),
    );
  }

  Widget rectangleBox(
      {double size = 150,
      Color? color = Colors.amberAccent,
      Color colorBorder = Colors.black,
      double borderWidth = 2.0,
      EdgeInsets? padding,
      Decoration? decoration,
      Widget? child}) {
    return Container(
      padding: padding,
      width: size,
      height: size,
      decoration: decoration ??
          BoxDecoration(
            color: color,
            border: Border.all(color: colorBorder, width: borderWidth),
          ),
      child: child,
    );
  }

  Widget button(BuildContext context,
      {double height = 50,
      double? width,
      Decoration? decoration,
      VoidCallback? func,
      Widget? child}) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: width ?? MediaQuery.sizeOf(context).width,
        height: height,
        decoration: decoration ??
            BoxDecoration(
              border: Border.all(),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
        child: child,
      ),
    );
  }
}
