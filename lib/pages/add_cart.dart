import 'package:flutter/material.dart';
import 'package:navigate_route/models/productitems.dart';
import 'package:navigate_route/pages/home_screen.dart';

class AddCartScreen extends StatefulWidget {
  const AddCartScreen({super.key});

  @override
  State<AddCartScreen> createState() => _AddCartScreenState();
}

class _AddCartScreenState extends State<AddCartScreen> {
  @override
  Widget build(BuildContext context) {
    var itemData = ModalRoute.of(context)?.settings.arguments as List<Products>;

    return Scaffold(
      bottomSheet: itemData.isNotEmpty
          ? Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Items : ${itemData.length}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  HomeScreenState().button(context,
                      func: () => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "Pay Done",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                      height: 45,
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          "PAY NOW",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            )
          : null,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(arguments: itemData),
                  builder: (context) => HomeScreen(),
                ));
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("Carts"),
      ),
      body: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.83,
          child: itemData.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.separated(
                    itemCount: itemData.length,
                    itemBuilder: (context, index) {
                      return productItem(
                          context, itemData[index], itemData, index);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    "NO DATA",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )),
    );
  }

  Widget productItem(
      BuildContext context, Products product, List<Products> items, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        HomeScreenState().rectangleBox(size: 100, color: product.color),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${product.boxColor} Box",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
                "Size ${product.size.toInt().toString()}x${product.size.toInt().toString()}")
          ],
        ),
        Spacer(),
        SizedBox(
          height: 95,
          child: Row(
            spacing: 3,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              HomeScreenState().button(context,
                  func: () => setState(() {
                        product.quantity++;
                      }),
                  width: 25,
                  height: 25,
                  child: Center(
                    child: Icon(Icons.add),
                  )),
              HomeScreenState().button(context,
                  width: 40,
                  height: 25,
                  child: Center(
                    child: Text(product.quantity.toString()),
                  )),
              HomeScreenState().button(context,
                  func: () => setState(() {
                        if (!(product.quantity > 1)) {
                          items.removeAt(index);
                        }
                        product.quantity--;
                      }),
                  width: 25,
                  height: 25,
                  child: Center(
                    child: Icon(Icons.remove),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
