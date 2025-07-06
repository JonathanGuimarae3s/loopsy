🎞️ Loopsy — Buscador de GIFs

Aplicativo Flutter simples para buscar e visualizar GIFs em tempo real, utilizando a API do Tenor como fonte.

---

✨ Funcionalidades

- Busca de GIFs por palavra-chave
- Scroll infinito com carregamento por demanda
- Tela de visualização individual do GIF
- Animação de carregamento personalizada
- Interface leve e responsiva

---

📱 Tecnologias Utilizadas

- Flutter
- Dart
- `http` para chamadas à API Tenor
- `transparent_image` para efeito de loading nas imagens
- `flutter_spinkit` para indicador de progresso

---

📂 Organização do Projeto

```
/lib
│
├── main.dart                 # Ponto de entrada da aplicação
├── home.dart                 # Tela principal com campo de busca e grid de GIFs
├── gif_page.dart             # Tela de visualização de GIF selecionado
├── gif.dart                  # Modelo para dados de um GIF
├── circulo_progresso.dart    # Widget de loading customizado
│
├── tenor_api.dart            # Abstração da API Tenor
└── tenor_impl.dart           # Implementação da chamada HTTP e parsing de resultados
```

---

🚀 Como Executar

Clone o repositório:

```bash
git clone https://github.com/seu-usuario/loopsy.git
cd loopsy
```

Instale as dependências:

```bash
flutter pub get
```

Execute o app:

```bash
flutter run
```

> Certifique-se de ter o Flutter configurado corretamente e um dispositivo/emulador disponível.

---

🔧 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.6
  transparent_image: ^2.0.0
  flutter_spinkit: ^5.2.0
```

---

📡 Fonte de Dados

Os GIFs são obtidos da [API Tenor](https://tenor.com/gifapi/documentation), que fornece uma ampla variedade de imagens animadas com base em palavras-chave.

---

📌 Sobre

App desenvolvido em Flutter por Jonathan com foco em performance, organização e boa experiência de uso.
