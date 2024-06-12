import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/user_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late List<String> dateSplit;
  late String date;

  void _getLocaleDate() {
    dateSplit = _auth.currentUser!.metadata.creationTime.toString().split(' ');
    setState(() {
      date =
          _auth.currentUser!.metadata.creationTime.toString().split(' ').first;
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocaleDate();
    print('${_auth.currentUser!.metadata.creationTime} INSTANCE USER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green.shade200,
                  child: Image.asset('./assets/icons/user_profile.png')),
              SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Text(
                  '${context.watch<UserProvider>().user!['username']}, вместе с Kushay Club с: ${_auth.currentUser!.metadata.creationTime.toString().split(' ').first}',
                  style: TextStyle(fontSize: 19),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Мои покупки',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildPurchaseList(),
              SizedBox(height: 20),
              Text(
                'Мои купоны',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildCouponList(),
              SizedBox(height: 20),
              _buildRateAppSection(),
              SizedBox(height: 20),
              _buildSocialMediaLinks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPurchaseList() {
    List<String> purchases = [];

    if (purchases.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: purchases.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.green.shade100,
            child: ListTile(
              title: Text(purchases[index]),
            ),
          );
        },
      );
    } else {
      return Card(
        color: Colors.white,
        child: ListTile(
          title: Text('Пока нет покупок...', textAlign: TextAlign.center),
        ),
      );
    }
  }

  Widget _buildCouponList() {
    List<String> coupons = [];

    if (coupons.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.green.shade100,
            child: ListTile(
              title: Text(coupons[index]),
            ),
          );
        },
      );
    } else {
      return Card(
        color: Colors.white,
        child: ListTile(
          title: Text('Пока нет купонов...', textAlign: TextAlign.center),
        ),
      );
    }
  }

  Widget _buildRateAppSection() {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.green.shade200,
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Оцените приложение',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  Icons.star_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  // логика оценки приложения
                },
              );
            }),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white)),
            onPressed: () {
              // фывдоадыао
            },
            child: Text('Внести оценку'),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Следите за нами в',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.facebook),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.live_tv_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.tiktok_rounded),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
