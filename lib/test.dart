import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'members.dart';
import 'strings.dart' as strings;

class ThisIsTest extends StatefulWidget {
  const ThisIsTest({Key? key}) : super(key: key);

  @override
  _ThisIsTestState createState() => _ThisIsTestState();
}


class _ThisIsTestState extends State<ThisIsTest> {
  final _members = <Member>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Future<void> _loadData() async {
    const dataUrl = 'https://api.github.com/orgs/raywenderlich/members';
    final response = await http.get(Uri.parse(dataUrl));
    setState(() {
      // _members = json.decode(response.body) as List;
      final dataList = json.decode(response.body) as List;
      for (final item in dataList) {
        final login = item['login'] as String? ?? '';
        final url = item['avatar_url'] as String? ?? '';
        final member = Member(login, url);
        _members.add(member);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _onTap(int i) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text('Hello, I am a Banner for $i'),
        leading: const Icon(Icons.info),
        backgroundColor: Colors.blue[800],
        actions: [
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // child: Container(
      //   padding: const EdgeInsets.all(8.0),
      //   decoration: BoxDecoration(
      //     // color: Colors.blue,
      //     borderRadius: BorderRadius.circular(15),
      //     // boxShadow: const [
      //     //   BoxShadow(
      //     //     color: Colors.black54,
      //     //     blurRadius: 6,
      //     //   ),
      //     // ],
      //   ),
      child: ListTile(
        title: Text(_members[i].login, style: _biggerFont),
        subtitle: Text('this is member $i'),
        leading: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          backgroundImage: NetworkImage(_members[i].avatarUrl),
        ),
        tileColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onTap: () => _onTap(i),
      ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appTitle),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: _members.length,
          itemBuilder: (BuildContext context, int position) {
            return _buildRow(position);
          }),
    );
  }
}

// class ProductBox extends StatelessWidget {
//   ProductBox({Key key, this.name, this.description, this.price, this.image})
//       : super(key: key);
//   final String name;
//   final String description;
//   final int price;
//   final String image;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.all(2),
//         height: 120,
//         child: Card(
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//               Image.asset("assets/appimages/" + image),
//               Expanded(
//                   child: Container(
//                       padding: const EdgeInsets.all(5),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Text(this.name,
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.bold)),
//                           Text(description),
//                           Text("Price: " + price.toString()),
//                         ],
//                       )))
//             ])));
//   }
// }
