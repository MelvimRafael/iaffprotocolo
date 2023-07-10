import 'package:flutter/material.dart';
import '../database_helper.dart';
import '../models.dart';

class CadastrosPage extends StatelessWidget {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  CadastrosPage({Key? key}) : super(key: key);

  void showCadastroFormModal(BuildContext context, String category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10.0),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Cadastro - $category',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    if (category == 'Semen') ...[
                      SemenForm(
                        onSave: (semen) async {
                          await databaseHelper.insertSemen(semen);
                          Navigator.of(context).pop();
                          _showSuccessDialog(context);
                        },
                      ),
                    ] else if (category == 'Fazenda') ...[
                      FazendaForm(
                        onSave: (fazenda) async {
                          await databaseHelper.insertFazenda(fazenda);
                          Navigator.of(context).pop();
                          _showSuccessDialog(context);
                        },
                      ),
                    ] else if (category == 'Lote') ...[
                      LoteForm(
                        onSave: (lote) async {
                          await databaseHelper.insertLote(lote);
                          Navigator.of(context).pop();
                          _showSuccessDialog(context);
                        },
                      ),
                    ] else if (category == 'Vacas') ...[
                      VacasForm(
                        onSave: (vacas) async {
                          await databaseHelper.insertVacas(vacas);
                          Navigator.of(context).pop();
                          _showSuccessDialog(context);
                        },
                      ),
                    ] else if (category == 'IAFT Protocolo') ...[
                      IAFTProtocoloForm(
                        onSave: (protocolo) async {
                          await databaseHelper.insertIAFTProtocolo(protocolo);
                          Navigator.of(context).pop();
                          _showSuccessDialog(context);
                        },
                      ),
                    ],
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Salvar'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sucesso!'),
          content: Text('Os dados foram salvos com sucesso.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastros', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        elevation: 0.0, // Remove the shadow
      ),
      body: Container(
        color: Colors.green,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          child: Stack(
            children: [
              Container(
                color: Colors.white,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoryButton(
                      icon: Icons.tab,
                      title: 'Semen',
                      textSize: 20,
                      buttonWidth: 300,
                      buttonHeight: 80,
                      onPressed: () => showCadastroFormModal(context, 'Semen'),
                    ),
                    CategoryButton(
                      icon: Icons.home,
                      title: 'Fazenda',
                      textSize: 20,
                      buttonWidth: 300,
                      buttonHeight: 80,
                      onPressed: () =>
                          showCadastroFormModal(context, 'Fazenda'),
                    ),
                    CategoryButton(
                      icon: Icons.local_activity,
                      title: 'Lote',
                      textSize: 20,
                      buttonWidth: 300,
                      buttonHeight: 80,
                      onPressed: () => showCadastroFormModal(context, 'Lote'),
                    ),
                    CategoryButton(
                      icon: Icons.pets,
                      title: 'Vacas',
                      textSize: 20,
                      buttonWidth: 300,
                      buttonHeight: 80,
                      onPressed: () => showCadastroFormModal(context, 'Vacas'),
                    ),
                    CategoryButton(
                      icon: Icons.analytics,
                      title: 'IAFT Protocolo',
                      textSize: 20,
                      buttonWidth: 300,
                      buttonHeight: 80,
                      onPressed: () =>
                          showCadastroFormModal(context, 'IAFT Protocolo'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
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

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final double textSize;
  final double buttonWidth;
  final double buttonHeight;
  final VoidCallback onPressed;

  const CategoryButton({
    required this.icon,
    required this.title,
    this.textSize = 25,
    this.buttonWidth = 200,
    this.buttonHeight = 80,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        label: Text(
          title,
          style: TextStyle(fontSize: textSize, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[200],
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: Size(buttonWidth, buttonHeight),
        ),
      ),
    );
  }
}

class SemenForm extends StatelessWidget {
  final Function(Semen) onSave;

  const SemenForm({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Nome do Sêmen'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Código do Sêmen'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Descrição'),
        ),
        ElevatedButton(
          onPressed: () {
            Semen semen = Semen(
              nome: '',
              codigo: '',
              descricao: '',
            );
            onSave(semen);
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}

class FazendaForm extends StatelessWidget {
  final Function(Fazenda) onSave;

  const FazendaForm({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Nome da Fazenda'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Localização'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Proprietário'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Imagem'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Descrição'),
        ),
        ElevatedButton(
          onPressed: () {
            Fazenda fazenda = Fazenda(
              nome: '',
              localizacao: '',
              proprietario: '',
              imagem: '',
              descricao: '',
            );
            onSave(fazenda);
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}

class LoteForm extends StatelessWidget {
  final Function(Lote) onSave;

  const LoteForm({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Nome do Lote'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Número do Lote'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Descrição'),
        ),
        ElevatedButton(
          onPressed: () {
            Lote lote = Lote(
              nome: '',
              numero: '',
              descricao: '',
            );
            onSave(lote);
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}

class VacasForm extends StatelessWidget {
  final Function(Vacas) onSave;

  const VacasForm({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Nome da Vaca'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Número da Vaca'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Raça'),
        ),
        ElevatedButton(
          onPressed: () {
            Vacas vacas = Vacas(
              nome: '',
              numero: '',
              raca: '',
              id: 0,
            );
            onSave(vacas);
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}

class IAFTProtocoloForm extends StatelessWidget {
  final Function(IAFTProtocolo) onSave;

  const IAFTProtocoloForm({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Nome do Protocolo'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Descrição'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Data de início'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Medicamentos'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Procedimentos'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Observações'),
        ),
        ElevatedButton(
          onPressed: () {
            IAFTProtocolo protocolo = IAFTProtocolo(
              nome: '',
              descricao: '',
              dataInicio: '',
              medicamentos: '',
              procedimentos: '',
              observacoes: '',
            );
            onSave(protocolo);
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}
