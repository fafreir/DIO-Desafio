drop database projeto;
create database projeto;
use projeto;

create table cargo(
	idCargo int auto_increment,
    nomeCargo varchar(50) unique,
    constraint pk_cargo primary key(idCargo)
);

create table funcionario(
	idFunc int auto_increment,
    nomeFunc varchar(30),
    sobrenomeFunc varchar(40),
    cpf varchar(11) unique not null,
    salario float,
    sexo enum('H','M','O') ,
    idcargo int,
    primary key pk_funcionario(idFunc, idcargo),
    constraint fk_cargo foreign key (idcargo) references cargo(idcargo)
);

create table localizacao(
	idLoc int auto_increment,
    localizacao varchar(50) unique,
    constraint pk_idLoc primary key (idLoc)
);

create table projeto(
	idProj int auto_increment,
    nomeProj varchar(40) unique,
    descProj varchar(40),
    idLoc int,
    constraint pk_projeto primary key (idProj)
    
);

create table funcproj(
	idProj int,
    idFunc int,
    horas int,
    tipo enum('remoto', 'hidrido', 'presencial'),
    constraint fk_func_funcproj foreign key (idFunc) references funcionario(idFunc),
	constraint fk_proj_funcproj foreign key (idProj) references projeto(idProj)
);

alter table projeto add constraint fk_localizacao foreign key(idProj) references localizacao(idLoc);

insert into cargo(nomeCargo) values
('DBA'),
('Analista de TI'),
('Desenvolvedor de Sistemas'),
('Full Stack');

insert into localizacao(localizacao) values
('São Paulo'),
('Campinas'),
('Brasilia'),
('Bahia'),
('Manaus');

insert into projeto(nomeProj, descProj, idLoc) values
('MB', 'Melhoria Banco de dados',1),
('MD', 'Melhoria no desenovolvimento',3),
('CS', 'Mudança de servidores',1),
('MP', 'Mudança de processos',5),
('MT', 'Mudança de tecnologia',4);

insert into funcionario(nomeFunc, sobrenomeFunc, cpf, salario, sexo, idcargo) values
('Daniel', 'Ventura Santos', '33311122255', 3.502, 'H', 1),
('Osvaldo', 'Silva Pedrian', '33344433777', 3.400, 'O', 1),
('Danielle', 'Blanis Gonçalves', '33344411777', 3.520, 'M', 2),
('Cintia', 'Coelho', '3331113345', 3.400, 'M', 3),
('Evandro', 'Pires da Mota', '12365478912', 4.200, 'O', 4),
('Tuane', 'Oliveira Ventosa', '45633378912', 4.200, 'M', 2);

insert into funcproj(idProj, idFunc, horas, tipo) values
(1, 1, 80, 'remoto'),
(2, 2, 70, 'presencial'),
(3, 1, 60, 'remoto');

# Concatenar o nome completo e qual é o maior salário
select concat(nomeFunc, ' ',sobrenomeFunc) as Nome_Completo, salario as salario 
from funcionario order by salario;

# Quais são os projetos que são remotos
select p.nomeProj, tipo from projeto p inner join funcproj f
on p.idProj = f.idFunc where tipo = 'remoto';

# Quantos projetos são remotos
select count(tipo) as Total_remoto from projeto p inner join funcproj f
on p.idProj = f.idFunc where tipo = 'remoto';

# Quantas pessoas se consideram mulheres
select count(sexo) as Masculino from funcionario where sexo = 'M';

# Quais pessoas começam com a letra 'D'
select nomeFunc from funcionario where nomeFunc like 'D%' ;
