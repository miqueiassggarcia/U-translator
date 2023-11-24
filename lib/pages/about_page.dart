import 'package:flutter/material.dart';
import 'package:utranslator/navigation/navigation.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: const Navigation(),
        appBar: AppBar(
          title: const Text('Sobre'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SizedBox(
                height: 50,
              ),
              Text(
                "Sobre o Aplicativo de Leitura e Tradução de PDF",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Bem-vindo ao nosso aplicativo de Leitura e Tradução de PDF! "
                "Estamos entusiasmados por você ter escolhido nossa plataforma como "
                "uma ferramenta valiosa para seu aprendizado de idiomas.",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100,
              ),
              Text("Nossa Missão",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 20,
              ),
              Text(
                "Nosso objetivo é proporcionar uma maneira eficaz e envolvente de estudar "
                "um novo idioma. Reconhecemos a importância de ler textos autênticos para "
                "aprimorar suas habilidades de idioma, e é por isso que projetamos este aplicativo.",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100,
              ),
              Text("Nossa Equipe",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 20,
              ),
              Text(
                "Somos uma equipe apaixonada por idiomas e educação. "
                "Estamos comprometidos em fornecer a você as ferramentas de "
                "que você precisa para se tornar fluente em um novo idioma.",
                textAlign: TextAlign.center,
              ),
              Text(
                "Obrigado por escolher nosso aplicativo. Esperamos que ele seja "
                "uma parte valiosa do seu processo de aprendizado. Se você tiver alguma dúvida, "
                "comentário ou sugestão, não hesite em entrar em contato conosco.",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
}
