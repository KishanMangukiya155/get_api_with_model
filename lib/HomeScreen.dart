import 'package:flutter/material.dart';
import 'package:get_api_with_model/Model/ProductModel.dart';
import 'package:get_api_with_model/Services/get_product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        elevation: 50,
        title: Center(
          child: Text(
            "Product",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        leading: Icon(Icons.arrow_back),
      ),
      body: FutureBuilder(
        future: ProductService.getProduct(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final products = snapshot.data![index];
                return Container(
                  height: 120,
                  width: 360,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurStyle: BlurStyle.solid,
                            blurRadius: 3,
                            spreadRadius: 0.5)
                      ]),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          image: DecorationImage(
                              image: NetworkImage(products.image),
                              fit: BoxFit.cover),
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "Title:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.clip),
                                    children: [
                                      TextSpan(
                                          text: products.title,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal))
                                    ]),
                              ),
                              SizedBox(height: 5),
                              RichText(
                                text: TextSpan(
                                    text: "Price:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: products.price.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
