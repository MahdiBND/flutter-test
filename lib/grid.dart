import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'members.dart';
import 'strings.dart' as strings;

class NameGrid extends StatefulWidget {
  const NameGrid({Key? key}) : super(key: key);

  @override
  _NameGridState createState() => _NameGridState();
}

class _NameGridState extends State<NameGrid> {
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

  Widget _buildItem(int i) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        child: Column(
          children: [
			  const Spacer(),
            Image.network(
              _members[i].avatarUrl,
              width: 130,
              height: 130,
			  fit: BoxFit.scaleDown,
            ),
            Text(_members[i].login, style: _biggerFont),
			const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shahre Online'),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        padding: const EdgeInsets.all(8),
        itemCount: _members.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildItem(position);
        },
      ),
    );
  }
}
