import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingsScreen extends StatefulWidget {
  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {

  static const String username_key = 'username';
  static const String userage_key = 'user_age';
  static const String usercountry_key = 'user_country';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();


  final Map<String, String> countryEmojis = {
    'Brasil': '🇧🇷',
    'Estados Unidos': '🇺🇸',
    'Japão': '🇯🇵',
    'França': '🇫🇷',
    'Alemanha': '🇩🇪',
    'Argentina': '🇦🇷',
    'Reino Unido': '🇬🇧',
  
  };

  String? _countryEmoji;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('username') ?? "";
      _ageController.text = prefs.getInt('user_age')?.toString() ?? "";
      _countryController.text = prefs.getString('user_country') ?? "";
      _updateCountryEmoji(); 
    });
  }

  Future<void> _saveUserData() async {
    String username = _nameController.text;
    int age = int.tryParse(_ageController.text) ?? 0;
    String country = _countryController.text;

    final preferences = await SharedPreferences.getInstance();

    await preferences.setInt(userage_key, age);
    await preferences.setString(username_key, username);
    await preferences.setString(usercountry_key, country);
  }

  void _updateCountryEmoji() {
    setState(() {
      _countryEmoji = countryEmojis[_countryController.text];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil do Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Idade'),
            ),
            TextField(
              controller: _countryController,
              decoration: InputDecoration(labelText: 'País Favorito'),
              onChanged: (_) => _updateCountryEmoji(), 
            ),
            SizedBox(height: 10),
            if (_countryEmoji != null)
              Text(
                'Emoji do País: $_countryEmoji',
                style: TextStyle(fontSize: 24),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _saveUserData,
                  child: Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: _loadUserData,
                  child: Text('Carregar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
