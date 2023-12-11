# Arquiterura do projeto Events4me


# Regras do projeto em geral

- O projeto conterá lints para uma melhor padronização de código.
- O projeto terá cobertura de testes minima de 70%
- Camadas globais devem ter um lugar especifico na aplicação, por tanto, devem estar na pasta shared.
- Cada feature de app deve ter sua propria pasta.
- O projeto  seguirá no padrão Clean Dart.
- Sempre que possivel dependa de classes Abstratas e não de classes concretas.
- Cada parte do app será separada por modulos.



# Designer Pattern

- Repository Pattern: para organização e consumo de dados externos.
- Service Pattern: para isolar trechos de código com outras responsabilidades.
- Dependency Injection: para resolver dependencias das classes.
- Flutter Modular: para organizar os modulos e bindings da aplicação.



# Principais packages

- Cubit: para gerencia de estados na aplicação.
- Dio: Para fazer requests externas e consumo de API.
- Security storage: Para guardar dados sensiveis localmente. 
- SharedPreferencs: para guardar dados não sensiveis localmente.


# Desenvolvedores
- Caio Deiró