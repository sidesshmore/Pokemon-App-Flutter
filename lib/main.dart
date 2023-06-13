import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:poke_app/poke_data.dart';
import 'package:poke_app/pokemon_card.dart';

void main() {
  runApp(MaterialApp(
    title: 'Pokemon App',
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url = Uri.parse(
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json"); // Convert URL string to Uri object

  PokeHub? pokeHub; // Make pokeHub nullable

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    setState(() {}); // Update the state after fetching data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Poke App',
          style: GoogleFonts.lato(
              fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: Colors.orange[300],
      ),
      body: pokeHub?.pokemon != null // Add a null check
          ? GridView.count(
              crossAxisCount: 2,
              children: pokeHub!.pokemon!
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PokeCard(
                                        pokemon: poke,
                                      )),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(poke.img ??
                                          ''), // Use the null-aware operator and provide a default value
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  poke.name ?? '',
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
