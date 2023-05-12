# Arquiterura do projeto Events4me


# Regras do projeto em geral

- O projeto conterá lints para uma melhor padronização de código.
- O projeto terá cobertura de testes minima de 70%
- Camadas globais devem ter um lugar especifico na aplicação, por tanto, devem estar na pasta shared.
- Cada feature de app deve ter sua propria pasta.
- MVC: o projeto  seguirá no padrão arquitetural MVC (model, view, controller)
- Sempre que possivel dependa de classes Abstratas e não de classes concretas.



# Designer Pattern

- Repository Pattern: para organização e consumo de dados externos.
- Service Pattern: para isolar trechos de código com outras responsabilidades.
- Dependency Injection: para resolver dependencias das classes.
- Adapter: Converter um objeto em outro.



# Principais packages

- Getx: para gerencia de estado, validação de campos, injeção de dependencia e guardar dados        localmente.
- Dio: Para fazer requests externas e consumo de API.
- Security storage: Para guardar dados sensiveis localmente. 


# Desenvolvedores
- Caio Deiró