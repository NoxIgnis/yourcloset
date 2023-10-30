import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:your_closet/model/roupas.dart';
import 'package:your_closet/repositories/roupasRepository.dart';

class RoupaDetalhesPage extends StatefulWidget {
  final Roupas roupa;

  RoupaDetalhesPage({Key? key, required this.roupa}) : super(key: key);

  @override
  _RoupaDetalhesPageState createState() => _RoupaDetalhesPageState();
}

class _RoupaDetalhesPageState extends State<RoupaDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  final _nome = TextEditingController();
  roupasRepository roupas = roupasRepository();
  double quantos = 0;

  void editarRoupa(String novoValor) {
    Roupas roupaEditada = Roupas(
      nome: _nome.text,
      preco: int.parse(novoValor),
      icone: widget.roupa.icone,
      id: widget.roupa.id,
    );

    roupas.editaRoupa(roupaEditada);

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Editado com sucesso!')),
    );
  }

  @override
  void initState() {
    super.initState();
    _valor.text = widget.roupa.preco.toString();
    _nome.text = widget.roupa.nome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roupa.nome),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: Image.asset(widget.roupa.icone),
                  ),
                  // Container(width: 10),
                  // Text(
                  //   real.format(widget.roupa.preco),
                  //   style: const TextStyle(
                  //     fontSize: 26,
                  //     letterSpacing: -1,
                  //     color: Color.fromARGB(255, 35, 35, 35),
                  //   ),
                  // ),
                ],
              ),
            ),
           Form(
                key: _form,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10), // Espaçamento vertical entre os campos
                      child: TextFormField(
                        controller: _nome,
                        style: const TextStyle(fontSize: 22),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nome',
                          prefixIcon: Icon(Icons.person_outline, color: Color.fromARGB(255, 114, 0, 163)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe um nome';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10), // Espaçamento vertical entre os campos
                      child: TextFormField(
                        controller: _valor,
                        style: const TextStyle(fontSize: 22),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Valor',
                          prefixIcon: Icon(Icons.monetization_on_outlined, color: Color.fromARGB(255, 114, 0, 163)),
                          suffix: Text(
                            'reais',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Informe um valor';
                          } else if (double.parse(value) < 50) {
                            return 'Compra mínima é R\$ 50';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            quantos = (value.isEmpty) ? 0 : double.parse(value) / widget.roupa.preco;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            (quantos > 0)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        '$quantos ${widget.roupa.preco}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(125, 10, 10, 10),
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.only(right: 58, top: 5),
                    child: const Text(
                      'Digite o valor da peça',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(125, 10, 10, 10),
                      ),
                    ),
                  ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    editarRoupa(_valor.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 114, 0, 163),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Salvar',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
