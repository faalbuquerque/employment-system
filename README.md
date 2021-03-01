<h1 align="center"> Gitemploy </h1>

<p align="center"> Projeto Final – TreinaDev 05 - Etapa 01</p>

<p align="justify">
  O projeto consiste na criação de uma plataforma Web para que pessoas dos
  departamentos de RH de empresas criem vagas e sejam capazes de gerenciar todo processo
  de forma colaborativa. Além disso, a plataforma funciona como um site de busca de
  oportunidades para os visitantes. Um visitante pode conhecer empresas, ver suas vagas
  disponíveis e aplicar para estas vagas.
</p>
<br>

<h2 align="center"> Sistema em funcionamento: </h2>

<p align="center">
  <a  href="https://gitemploy.herokuapp.com/"  >
    Gitemploy no Heroku
  </a>
<p>
<br>

<h2 align="center"> Tecnologias utilizadas: </h2>
<p align="center">
&#10003; Ruby 
&#10003; Rails 
&#10003; Rspec
&#10003; Capybara
&#10003; Devise
&#10003; BootStrap
&#10003; HTML
&#10003; CSS
</p>

<br>
<h2 align="center"> Executando o projeto: </h2>
<br>

No terminal, clone o projeto:
```
git clone https://github.com/faalbuquerque/employment-system.git
```

Entre na pasta do projeto:
```
cd employment-system
```

Execute os comandos:
```
bundle install && yarn install && rails db:migrate
```

Rode o servidor do Projeto:
```
rails s
```

Visualize o sistema no navegador:
```
127.0.0.1:3000
```
<br>

*Opcional, povoe o banco com dados para teste:*
```
rails db:seed
```

Dados de teste/seeds:
```
Empresa
  Nome: My company

Colaborador
  login:
    Email: collaborador@test.com
    Password: 123456

Vaga
  Titulo: Suporte

Candidato A
  login:
    Email: candidateA@test.com
    Password: 123456

Candidato B
  login:
    Email: candidateB@test.com
    Password: 123456

Candidato C
  login:
    Email: candidateC@test.com
    Password: 123456

Candidatura
  Candidato: Candidato C
  Vaga: 
    Titulo: Suporte

Proposta
  Vaga: Suporte
  Candidato: Candidato C
  Mensagem: Essa é nossa proposta

```


