import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'discounts_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int points = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Column(children: [
            _currentBonusPts(),
            _mainMenuBar(),
            _discounts(),
          ]),
        ),
        bottomNavigationBar: _bottomNavbar());
  }

  Container _discounts() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Акции',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return _discountItem();
                },
              ),
            ),
          ],
        ));
  }

  Widget _discountItem() {
    return Container(
      height: 300,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            './assets/productsImg/logo.png',
            fit: BoxFit.cover,
            height: 100,
            width: 150,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '20% скидка',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Text('Greek Yougurt'),
                Text(
                  '1 299 Тг',
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey),
                ),
                Text(
                  '999 Тг',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Container _currentBonusPts() {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.green),
      child: Column(
        children: [
          Text(
            'Active points:',
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
          Text(
            '$points B',
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white70)),
            child: Text(
              'Go Shop',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  Padding _mainMenuBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: SizedBox(
        height: 200,
        child: GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [
            _gridItem('Узнать цену', Icons.qr_code),
            _gridItem('Kushay.ru', Icons.logo_dev),
            _gridItem('Мои покупки', Icons.shopping_cart),
            _gridItem('Игры', Icons.gamepad),
            _gridItem('Клубы', Icons.star_border_outlined),
            _gridItem('Купоны', Icons.airplane_ticket_outlined),
            _gridItem('Промокоды', Icons.airplane_ticket_rounded),
            _gridItem('Мои списки', Icons.note_add),
          ],
        ),
      ),
    );
  }

  Column _gridItem(String label, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.green,
        ),
        SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }

  BottomNavigationBar _bottomNavbar() {
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });

      if (index == 0) {
        // Push the Home page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DiscountsPage()),
        );
      }
    }

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_offer),
          label: 'Discounts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: 'Scan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Promotions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }

  AppBar appBar() {
    const name = 'user';
    return AppBar(
      title: Text(
        'Hello, $name!',
        style: TextStyle(
            color: Colors.yellow, fontSize: 21, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.green.shade400,
      actions: [
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(),
                child: SvgPicture.asset('./assets/icons/add-circle-button.svg'),
              ),
              Container(
                margin: EdgeInsets.all(17),
                decoration: BoxDecoration(),
                child: SvgPicture.asset('./assets/icons/bell.svg'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
