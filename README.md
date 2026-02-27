# FX Câmbio

Aplicativo Flutter que consome a API pública PTAX do Banco Central do Brasil para exibir cotações de moedas estrangeiras em relação ao Real.

## Como executar

### Pré-requisitos

- Flutter SDK >= 3.10.4

> O projeto já inclui as configurações do Firebase (Authentication com Email/Password). Basta clonar e rodar.

### Passos

```bash
# 1. Clonar o repositório
git clone https://github.com/rickhbr/lifetime_teste.git
cd lifetime_teste

# 2. Instalar dependências
flutter pub get

# 3. Gerar código (modelos JSON + injeção de dependência)
dart run build_runner build --delete-conflicting-outputs

# 4. Executar
flutter run
```

### Credenciais de teste

| Campo | Valor |
|---|---|
| E-mail | `teste@teste.com` |
| Senha | `123456` |

## Decisões técnicas

### Arquitetura

O projeto segue **Clean Architecture** com separação em três camadas por feature:

```
lib/
├── core/                  # Tema, widgets, rotas, rede, constantes, erros, use cases
├── features/
│   ├── auth/              # Login (Firebase Auth)
│   ├── currencies/        # Listagem de moedas
│   └── currency_detail/   # Cotação detalhada
└── injection.dart         # Configuração do service locator
```

Cada feature possui as camadas `data/`, `domain/` e `presentation/`, isolando responsabilidades e facilitando manutenção e testes.

- **Domain**: entidades, contratos de repositório e use cases
- **Data**: models, datasources e implementações de repositório
- **Presentation**: cubits, states, pages e widgets

### SOLID

- **SRP**: cada use case encapsula uma única regra de negócio (`SignInUseCase`, `GetCurrenciesUseCase`, `GetLatestQuoteUseCase`, etc.)
- **OCP/DIP**: cubits dependem de abstrações (use cases e interfaces de repositório), não de implementações concretas
- **ISP**: interfaces de repositório são focadas por feature, sem métodos desnecessários

### Pacotes utilizados

| Pacote | Finalidade |
|---|---|
| `flutter_bloc` | Gerenciamento de estado com Cubit |
| `equatable` | Comparação de estados sem boilerplate |
| `firebase_auth` / `firebase_core` | Autenticação por e-mail/senha |
| `get_it` + `injectable` | Injeção de dependência com geração de código |
| `dio` | Cliente HTTP para consumo da API PTAX |
| `go_router` | Navegação declarativa com redirect baseado em auth |
| `json_annotation` + `json_serializable` | Serialização de modelos JSON |
| `intl` | Formatação de moeda (pt_BR) e datas |
| `shimmer` | Skeleton loading durante carregamento |
| `flutter_animate` | Animações declarativas (fade-in, slide) |
| `url_launcher` | Abertura de links externos |

### Gerenciamento de estado

**Cubit** (do `flutter_bloc`) com **sealed classes** para representar estados de forma exaustiva via pattern matching do Dart 3. Cada feature tem seu Cubit independente com estados explícitos: loading, erro, sucesso e sem dados.

### Navegação

`GoRouter` com redirect reativo: um `GoRouterRefreshStream` escuta o `AuthCubit` e redireciona automaticamente entre `/login` e `/currencies` conforme o estado de autenticação.

### Consumo da API

A API PTAX é consumida via `Dio` com dois endpoints:

- **`/Moedas`** — lista de moedas disponíveis
- **`/CotacaoMoedaDia`** — cotação do dia para uma moeda específica

Erros de rede e respostas sem dados são tratados com tipos de exceção customizados (`ServerException`, `NoDataException`) mapeados para `Failure` no domínio. Um `LoggingInterceptor` registra todas as requisições e respostas no console para debug.

### Tratamento de estados

- **Loading**: shimmer/skeleton loading ao invés de spinner genérico
- **Erro**: widget de erro com mensagem e botão de retry
- **Sem dados**: tela dedicada informando que não há cotação disponível (fins de semana/feriados)
- **Sucesso**: exibição dos dados com animações de entrada

### UI/UX

- Tema dark com Material 3 e paleta de cores customizada
- Campo de busca com debounce de 300ms
- Bandeiras de países via Unicode (sem dependência externa)
- Animações staggered nas listas e cards
- Haptic feedback em interações chave
- `SliverAppBar` com gradiente na tela de detalhe
- Cards de compra/venda com cores semânticas (verde/vermelho)

## API

- **Base URL:** `https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/`
- **Documentação:** [Swagger PTAX](https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/swagger-ui3#/)
