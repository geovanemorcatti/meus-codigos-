# Declaração de Escopo - PROJETO


**Gerentes de Projeto:**

Bruno Silveira Cerqueira Lima, brunobhsclima@gmail.com

Gabriel Oliveira Gomide, gogomide.go@gmail.com

Geovane de Freitas Queiroz Morcatti, geovanemorcatti@gmail.com

Marcos Henrique Dias Barbosa, marcos.henrique@sga.pucminas.br

Mateus Samartini de Toledo, mateusamartini@gmail.com

---

**Professores:**

Cleiton Silva Tavares

Pedro Alves de Oliveira

---

_Curso de Engenharia de Software, Unidade Praça da Liberdade_

_Instituto de Informática e Ciências Exatas – Pontifícia Universidade de Minas Gerais (PUC MINAS), Belo Horizonte – MG – Brasil_

---


## Descrição do Escopo

Escopo do Projeto: O projeto engloba além das atividades de desenvolvimento do sistema, as atividades relacionadas a gestão, modelagem arquitetural e levantamento de requisitos. Para isso, inicialmente será definido o escopo do produto e serão levantados e priorizados os requisitos funcionais e não funcionais do projeto, e em seguida, ocorrerá a definição da arquitetura e das tecnologias a serem utilizadas. Posteriormente a isso, iniciará a fase de implementação de acordo com a priorização dos requisitos, em que nessa etapa podem ser percebidas mudanças ou lacunas tanto na arquitetura, quanto nos requisitos, ocorrendo a revisão desses. Em cada ciclo de desenvolvimento visa-se entregar pelo menos uma funcionalidade de valor, que uma vez pronta, deverá passar por uma etapa de testes, a fim de comprovar sua corretude e qualidade. 

Escopo do Produto: A aplicação desenvolvida deverá possuir um sistema de cadastro de usuário específico para o síndico e outro para moradores, em que um síndico pode manter o cadastro de um condomínio e permitir acesso a esse para os outros usuários moradores. Além disso, deve possuir um chat para facilitar a comunicação entre os condôminos,  e espaços específicos destinados a um quadro de avisos e de prestação de contas e despesas mensais  que serão mantidos exclusivamente pelo síndico, porém que poderão ser consultados por qualquer outro morador. Ademais, o sistema terá uma agenda eletrônica para gerenciar a marcação de reuniões e qualquer outro evento da área comum do condomínio.


## Requisitos (do produto e/ou do projeto) |

### Requisitos Funcionais

| **ID** | **Descrição** | **Prioridade** |
| --- | --- | --- |
| RF001 | Os usuários devem ser capazes de mantererm seus respectivos cadastros|Essencial |
| RF002 | O usuário síndico deve ser capaz de cadastrar um condomínio| Essencial |
| RF003|O usuário síndico deve ser capaz de manter o registro das áreas comuns de um condomíno já cadastrado |Essencial |
| RF004 | O usuário síndico deve ser capaz de prover acesso aos moradores ao condomínio| Essencial |
| RF005| Todos os usuários pré-cadastrados devem conseguir fazer login em suas respectivas contas | Essencial |
| RF006| O síndico deve ser capaz de gerir o quadro de avisos do condomínio | Essencial |
| RF007| O sistema deve possuir um chat entre todos os condominos cadastrados em um condomínio | Essencial |
| RF008| O síndico deve se capaz de passar o cargo de síndico para outro usuário morador | Desejável | 
| RF009| Os moradores devem ser capazes de consultarem as páginas de quadro de avisos e prestação de contas | Desejável |
| RF009| O síndico deve ser capaz de manter marcações na agenda eletrônica do condomínio | Opcional |
| RF010| O síndico deve ser capaz de manter o espaço destinado para prestação de contas e despessas mensais | Opcional |
| RF011| O sistema deve notificar para todos os condominos as postagens de novos eventos  | Opcional |

### Requisitos Não-Funcionais

| **ID** | **Descrição** |
| --- | --- |
| RNF1 |O sistema deve possuir um banco de dados para a perssistência dos dados dos usuários e seus condomínios|
| RNF2 |O sistema deve estar disponível para web e Android |
| RNF3 |O sistema deve possuir um middleware para a gestão das mensagens em tempo real |
| RNF4 |O sistema deve armazenar o nome dos usuários em dois campos distintos( nome e sobrenome)|
| RNF5 | O sistema deve ser fácil de se utilizar para diversos tipos e perfis de usuários, fazendo que o usuário consiga se cadastrar e entrar em um condomínio em menos de 10 clicks |

## Limites

Não está previsto que o projeto a ser desenvolvido possua algum tipo de integração com um sistema de pagamento real ou banco, como também não haverá um perfil específico para empresas administradoras de condomínios.

## Restrições

O projeto fica condicionado ao prazo da finalização do semestre letivo, e à falta de orçamento para eventuais custos.

## Premissas

Para efetivar o início do projeto é importante primeiramente que o grupo estude e adquira mais conhecimento sobre arquiteturas distribuídas e desenvolvimento de aplicações mobile.

## Marcos agendados

| Nome do Marco | Entregáveis Previstos |
| --- | --- |
| Sprint02| Documento de arquitetura,TAP,EAP |
| Sprint03| Prototipação|
| Sprint04| Release de implementação de funcionalidade priorizada |
| Sprint05| Release de implementação de funcionalidade priorizada|
| Sprint06| Release de implementação de funcionalidade priorizada, versão final da documentação|
