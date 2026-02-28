# FX Câmbio

Desafio técnico Flutter para a **Lifetime**. App que consome a API pública PTAX do Banco Central para exibir cotações de moedas estrangeiras em relação ao Real.

## Como executar

Precisa do Flutter SDK >= 3.10.4. O Firebase já está configurado, é só clonar e rodar.

```bash
git clone https://github.com/rickhbr/lifetime_teste.git
cd lifetime_teste
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Login de teste: `teste@teste.com` / `123456`

## Arquitetura

Clean Architecture com separação por feature. Cada feature tem `data/`, `domain/` e `presentation/`:

```
lib/
├── core/                  # Tema, widgets, rotas, rede, erros
├── features/
│   ├── auth/              # Login com Firebase Auth
│   ├── currencies/        # Listagem de moedas
│   └── currency_detail/   # Cotação detalhada
└── injection.dart
```

Os cubits dependem dos use cases (e não das implementações de repositório), o que facilita bastante na hora de testar e trocar implementações.

Estado gerenciado com **Cubit** e **sealed classes** do Dart 3, que dá um pattern matching bem limpo nos widgets.

Navegação com `GoRouter` — tem um refresh stream que escuta o `AuthCubit` e redireciona entre login e home automaticamente.

## API PTAX

Consumo via `Dio` com dois endpoints:

- `/Moedas` — lista de moedas disponíveis
- `/CotacaoMoedaDia` — cotação do dia pra uma moeda específica

Erros de rede e respostas vazias são tratados com exceções customizadas que viram `Failure` no domínio.

Base URL: `https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/`
[Documentação Swagger](https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/swagger-ui3#/)

## UI

- Tema dark com Material 3
- Shimmer loading nos estados de carregamento
- Busca com debounce
- Bandeiras via Unicode (sem lib extra)
- Animações de entrada nas listas e cards
- `SliverAppBar` com gradiente no detalhe
- Cards de compra/venda com verde/vermelho

## Testes

21 testes cobrindo use cases (delegação ao repositório), cubits (emissão de estados pra sucesso, erro e exceções) e um smoke test de widget. Mocks com `mocktail` e testes de bloc com `bloc_test`.

```bash
flutter test
```
