
import 'package:flutter/material.dart';

import '../madels/credit_card_model.dart';
import 'card_add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<CreditCard>cards=[
    CreditCard(
      cardNumber: '8888 8888 8888 8888',
      expiredDate: '12/12',
      cardType: 'visa',
      cardImage: 'assets/images/ic_card_visa.png',
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  Future _openDetailsPage() async {
    CreditCard result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const AddCardPage();
        },
      ),
    );
    setState(() {
      if(result!=null){
        cards.add(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("Card List",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child:  ListView.builder(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: cards.length,
                itemBuilder: (ctx, i) {
                  return _itemOfCardList(cards[i]);
                },
              ),
            ),

            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue.shade900,
              ),
              child: MaterialButton(
                onPressed: (){
                  _openDetailsPage();
                },
                child: Text("Add Card",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _itemOfCardList(CreditCard creditCard) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 70,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: Image(image: AssetImage(creditCard.cardImage!)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '**** **** **** ${creditCard.cardNumber!.substring(creditCard.cardNumber!.length - 4)}',
                style:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                creditCard.expiredDate!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}