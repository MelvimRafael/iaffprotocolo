import 'package:flutter/material.dart';
import '../componentes/header.dart';
import '../database_helper.dart';
import '../models.dart';
import 'detalheFazenda.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  List<Fazenda> fazendas = [];

  @override
  void initState() {
    super.initState();
    fetchFazendas();
  }

  void fetchFazendas() async {
    List<Fazenda> fetchedFazendas = await databaseHelper.getALLFazendas();
    setState(() {
      fazendas = fetchedFazendas;
    });
  }

  void deleteFazenda(int fazendaId) async {
    await databaseHelper.deleteFazenda(fazendaId);
    fetchFazendas();
  }

  void confirmDeleteFazenda(BuildContext context, int fazendaId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir fazenda'),
          content: Text('Deseja realmente excluir essa fazenda?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                deleteFazenda(fazendaId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Lista de Fazendas',
                              style: TextStyle(
                                color: Colors.blueGrey[800],
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: fazendas.isEmpty
                                ? Center(
                                    child: Text(
                                      'Nenhuma fazenda cadastrada.',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 5.0,
                                    ),
                                    itemCount: fazendas.length,
                                    itemBuilder: (context, index) {
                                      final fazenda = fazendas[index];

                                      return Dismissible(
                                        key: UniqueKey(),
                                        direction: DismissDirection.horizontal,
                                        background: Container(
                                          color: Colors.red,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                        confirmDismiss: (_) async {
                                          bool confirmDelete = await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Excluir fazenda'),
                                                content: Text(
                                                  'Deseja realmente excluir essa fazenda?',
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Cancelar'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Excluir'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          return confirmDelete;
                                        },
                                        onDismissed: (direction) {
                                          //deleteFazenda(fazenda.id);
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FarmDetailPage(
                                                  fazenda: fazenda,
                                                  farmName: fazenda.nome,
                                                  farmDescription:
                                                      fazenda.descricao,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 60,
                                                  height: 60,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      fazenda.imagem,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        fazenda.nome,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        fazenda.localizacao,
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        'Proprietário: ${fazenda.proprietario}',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Cadastro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendário',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/cadastro');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/calendario');
              break;
          }
        },
      ),
    );
  }
}
