drop database if exists EscolaDeMusica;
create database if not exists EscolaDeMusica;
use EscolaDeMusica;

set FOREIGN_KEY_CHECKS = 0;

drop table if exists toca;
drop table if exists executa;
drop table if exists Desempenha_funcao;
drop table if exists pertence;
drop table if exists Instrumentos;
drop table if exists Sinfonia;
drop table if exists FuncoesMusico;
drop table if exists TelefoneMusico;
drop table if exists Musico;
drop table if exists EnderecoMusico;
drop table if exists Orquestra;
drop table if exists EnderecoOrquestra;
drop table if exists Cidade;
drop table if exists Pais;

set FOREIGN_KEY_CHECKS = 1;

create table Pais (
    idPais int auto_increment primary key,
    nome varchar(45) not null,
    sigla char(2) not null
);

create table Cidade (
    idCidade int auto_increment primary key,
    nome varchar(45) not null,
    UF varchar(5) not null,
    idPais int,
    foreign key (idPais) references Pais(idPais)
);

create table EnderecoOrquestra (
    idEnderecoOrquestra int auto_increment primary key,
    idCidade int,
    cep varchar(9) not null,
    logradouro varchar(80) not null,
    UF varchar(5) not null,
    bairro varchar(45) not null,
    numero int not null,
    complemento varchar(45),
    foreign key (idCidade) references Cidade(idCidade)
);

create table Orquestra (
    idOrquestra int auto_increment primary key,
    nome varchar(80) not null,
    dataCriacao DATE not null,
    idEndereco int,
    idPais int,
    email varchar(80) not null,
    foreign key (idEndereco) references EnderecoOrquestra(idEnderecoOrquestra),
    foreign key (idPais) references Pais(idPais)
);

create table EnderecoMusico (
    idEnderecoM int auto_increment primary key,
    idCidadeM int,
    cep varchar(9) not null,
    logradouro varchar(80) not null,
    UF varchar(5) not null,
    bairro varchar(45) not null,
    numero int not null,
    complemento varchar(45),
    foreign key (idCidadeM) references Cidade(idCidade)
);

create table Musico (
    idMusico int auto_increment primary key,
    nome varchar(80) not null,
    CPF varchar(14) not null unique,
    email varchar(80) not null unique,
    dataNasc date not null,
    nacionalidade varchar(45) not null,
    idEnderecoM int,
    idPais int,
    foreign key (idEnderecoM) references EnderecoMusico(idEnderecoM),
    foreign key (idPais) references Pais(idPais)
);

create table TelefoneMusico (
    idTelefone int auto_increment primary key,
    idMusico int not null,
    telefone1 varchar(15) not null,
    telefone2 varchar(15),
    telefone3 varchar(15),
    tipo ENUM('Celular', 'Residencial', 'Comercial', 'Recado') not null,
    foreign key (idMusico) references Musico(idMusico) on delete cascade
);

create table FuncoesMusico (
    idFuncao int auto_increment primary key,
    descricao varchar(100) not null
);

create table Sinfonia (
    idSinfonia int auto_increment primary key,
    nome varchar(80) not null,
    dataCriacao date not null,
    compositor varchar(80) not null
);

create table Instrumentos (
    idInstrumento int auto_increment primary key,
    nome varchar(45) not null,
    tipo varchar(45) not null
);

create table pertence (
    idMusico int,
    idOrquestra int,
    dataIngresso date,
    salario decimal(10,2),
    primary key (idMusico, idOrquestra),
    foreign key (idMusico) references Musico(idMusico),
    foreign key (idOrquestra) references Orquestra(idOrquestra)
);

create table Desempenha_funcao (
    idMusico int,
    idFuncao int not null,
    dataInicioFuncao date not null,
    dataFimFuncao date,
    nomeFuncao varchar(100),
    primary key (idMusico, idFuncao),
    foreign key (idMusico) references Musico(idMusico),
    foreign key (idFuncao) references FuncoesMusico(idFuncao)
);

create table executa (
    idOrquestra int,
    idSinfonia int,
    dataExecucao date,
    primary key (idOrquestra, idSinfonia, dataExecucao),
    foreign key (idOrquestra) references Orquestra(idOrquestra),
    foreign key (idSinfonia) references Sinfonia(idSinfonia)
);

create table toca (
    idMusico int,
    idInstrumento int,
    dataInicio date,
    dataFim date,
    principal boolean not null,
    foreign key (idMusico) references Musico(idMusico),
    foreign key (idInstrumento) references Instrumentos(idInstrumento)
);

create index idx_musico_cpf on Musico(CPF);
create index idx_musico_email on Musico(email);
create index idx_telefone_musico on TelefoneMusico(idMusico);
create index idx_orquestra_endereco on Orquestra(idEndereco);
create index idx_musico_nome on Musico(nome);
create index idx_sinfonia_compositor on Sinfonia(compositor);
create index idx_orquestra_nome on Orquestra(nome);
create index idx_instrumento_classe on Instrumentos(tipo);

insert into Pais (nome, sigla) values
    ('Brasil', 'BR'),
    ('Estados Unidos', 'US'),
    ('Alemanha', 'DE'),
    ('Áustria', 'AT'),
    ('França', 'FR'),
    ('Japão', 'JP'),
    ('Itália', 'IT'),
    ('Canadá', 'CA'),
    ('Austrália', 'AU'),
    ('Rússia', 'RU'),
    ('China', 'CN'),
    ('Grécia', 'GR'),
    ('Reino Unido', 'GB'),
    ('México', 'MX'),
    ('Espanha', 'ES'),
    ('Índia', 'IN');
    
insert into Cidade (nome, UF, idPais) values
    ('São Paulo', 'SP', 1), ('Rio de Janeiro', 'RJ', 1), ('Belo Horizonte', 'MG', 1),
    ('Recife', 'PE', 1), ('Salvador', 'BA', 1), ('Brasília', 'DF', 1),
    ('Nova York', 'NY', 2), ('Los Angeles', 'CA', 2),
    ('Berlim', 'BE', 3), ('Munique', 'BY', 3),
    ('Viena', 'VI', 4), ('Salzburgo', 'SZ', 4),
    ('Paris', 'IDF', 5), ('Lyon', 'ARA', 5),
    ('Tóquio', 'TO', 6), ('Osaka', 'OS', 6),
    ('Roma', 'RM', 7), ('Milão', 'MI', 7),
    ('Montreal', 'QC', 8), ('Toronto', 'ON', 8),
    ('Sydney', 'NSW', 9), ('Melbourne', 'VIC', 9),
    ('Moscou', 'MOW', 10), ('São Petersburgo', 'SPE', 10),
    ('Pequim', 'BJ', 11), ('Xangai', 'SH', 11),
    ('Atenas', 'AT', 12), ('Salônica', '54', 12),
    ('Londres', 'LND', 13), ('Manchester', 'MAN', 13),
    ('Cidade do México', 'CMX', 14), ('Guadalajara', 'JAL', 14),
    ('Madri', 'MD', 15), ('Barcelona', 'CT', 15),
    ('Nova Delhi', 'DL', 16), ('Mumbai', 'MH', 16);
    
insert into FuncoesMusico (descricao) values
    ('Maestro'), ('Spalla (Primeiro Violino)'), ('Violino'), ('Viola'), ('Violoncelo'),
    ('Contrabaixo'), ('Flauta'), ('Oboé'), ('Clarinete'), ('Fagote'), ('Trompa'),
    ('Trompete'), ('Trombone'), ('Tuba'), ('Harpa'), ('Piano'), ('Cravo'), ('Percussão'),
    ('Timpanista'), ('Regente Assistente'), ('Concertino'), ('Violino Solo'), ('Viola Solo'),
    ('Violoncelo Solo'), ('Contrabaixo Solo'), ('Coro (Quando aplicável)'), ('Preparador de Coro'),
    ('Arranjador'), ('Luthier da Orquestra'), ('Copista');
    
insert into Instrumentos (nome, tipo) values
    ('Violino', 'Corda'), ('Viola', 'Corda'), ('Violoncelo', 'Corda'), ('Contrabaixo', 'Corda'),
    ('Harpa', 'Corda'), ('Flauta Transversal', 'Madeira'), ('Flauta Doce', 'Madeira'),
    ('Flautim', 'Madeira'), ('Oboé', 'Madeira'), ('Corne Inglês', 'Madeira'), ('Fagote', 'Madeira'),
    ('Contrafagote', 'Madeira'), ('Clarinete', 'Madeira'), ('Clarinete Baixo', 'Madeira'),
    ('Clarinete Contralto', 'Madeira'), ('Trompa', 'Metal'), ('Trompete', 'Metal'),
    ('Trombone', 'Metal'), ('Trombone Baixo', 'Metal'), ('Tuba', 'Metal'), ('Corneta', 'Metal'),
    ('Tímpanos', 'Percussão'), ('Xilofone', 'Percussão'), ('Marimba', 'Percussão'),
    ('Vibrafone', 'Percussão'), ('Glockenspiel', 'Percussão'), ('Celesta', 'Percussão'),
    ('Bombo', 'Percussão'), ('Caixa Clara', 'Percussão'), ('Prato', 'Percussão'),
    ('Triângulo', 'Percussão'), ('Pandeireta', 'Percussão'), ('Piano', 'Teclado'),
    ('Cravo', 'Teclado'), ('Órgão', 'Teclado'), ('Bandolim', 'Corda'), ('Violão', 'Corda'),
    ('Theremin', 'Eletrônico'), ('Gaita de Foles', 'Sopro'), ('Violino Barroco', 'Corda Histórica'),
    ('Viola da Gamba', 'Corda Histórica'), ('Clavicórdio', 'Teclado Histórico');
    
insert into Sinfonia (nome, dataCriacao, compositor) values
    ('Sinfonia No. 5 em Dó Menor, Op. 67', '1808-12-22', 'Ludwig van Beethoven'),
    ('Sinfonia No. 9 em Ré Menor, Op. 125', '1824-05-07', 'Ludwig van Beethoven'),
    ('Sinfonia No. 40 em Sol Menor, K. 550', '1788-07-25', 'Wolfgang Amadeus Mozart'),
    ('Sinfonia No. 41 em Dó Maior, K. 551 "Júpiter"', '1788-08-10', 'Wolfgang Amadeus Mozart'),
    ('Sinfonia No. 3 em Mi Bemol Maior, Op. 55 "Eroica"', '1805-04-07', 'Ludwig van Beethoven'),
    ('Sinfonia No. 6 em Fá Maior, Op. 68 "Pastoral"', '1808-12-22', 'Ludwig van Beethoven'),
    ('Sinfonia No. 94 em Sol Maior "Surpresa"', '1791-03-23', 'Joseph Haydn'),
    ('Sinfonia No. 104 em Ré Maior "Londres"', '1795-04-13', 'Joseph Haydn'),
    ('Sinfonia No. 9 em Mi Menor, Op. 95 "Do Novo Mundo"', '1893-12-16', 'Antonín Dvořák'),
    ('Sinfonia No. 5 em Si Bemol Maior, D. 485', '1816-10-03', 'Franz Schubert'),
    ('Sinfonia No. 4 em Mi Menor, Op. 98', '1885-01-17', 'Johannes Brahms'),
    ('Sinfonia Fantástica, Op. 14', '1830-12-05', 'Hector Berlioz'),
    ('Sinfonia No. 1 em Dó Menor, Op. 68', '1876-11-04', 'Johannes Brahms'),
    ('Sinfonia No. 2 em Ré Maior, Op. 36', '1802-04-05', 'Ludwig van Beethoven'),
    ('Sinfonia No. 7 em Lá Maior, Op. 92', '1813-12-08', 'Ludwig van Beethoven'),
    ('Sinfonia No. 8 em Si Menor, D. 759 "Inacabada"', '1822-10-30', 'Franz Schubert'),
    ('Sinfonia No. 1 em Ré Maior "Titã"', '1889-11-20', 'Gustav Mahler'),
    ('Sinfonia No. 5 em Dó Sustenido Menor', '1902-10-18', 'Gustav Mahler'),
    ('Sinfonia No. 6 em Si Menor, Op. 74 "Patética"', '1893-10-28', 'Pyotr Ilyich Tchaikovsky'),
    ('Sinfonia No. 4 em Fá Menor, Op. 36', '1878-02-10', 'Pyotr Ilyich Tchaikovsky');
    
insert into EnderecoOrquestra (idCidade, cep, logradouro, UF, bairro, numero, complemento) values
    (7, '10019', 'Broadway', 'NY', 'Manhattan', 132, 'Lincoln Center'),   
    (4, '50030-230', 'Rua da Concórdia', 'PE', 'Boa Vista', 81, null),        
    (9, '10117', 'Herbert-von-Karajan-Str.', 'BE', 'Mitte', 1, null),        
    (11, '1010', 'Musikvereinsplatz', 'VI', 'Innere Stadt', 1, null),         
    (3, '30130-010', 'Praça da Liberdade', 'MG', 'Centro', 514, null),         
    (13, '75012', 'Avenue Jean Jaurès', 'IDF', 'Bercy', 221, null),            
    (15, '100-0005', 'Marunouchi', 'TO', 'Chiyoda', 1, 'Tokyo Opera City'),   
    (17, '00184', 'Via Torino', 'RM', 'Esquilino', 32, null),                  
    (6, '70070-350', 'SPO EQ 703/903', 'DF', 'Asa Norte', 0, 'Bloco D'),      
    (19, 'H3A 1E3', 'Saint-Urbain', 'QC', 'Ville-Marie', 1600, null),       
    (21, '2000', 'Bennelong Point', 'NSW', 'Circular Quay', 0, 'Sydney Opera House'),
    (5, '40170-060', 'Rua Forte São Pedro', 'BA', 'Campo Grande', 60, null),  
    (23, '125009', 'Triumfalnaya Sq.', 'MOW', 'Tverskoy', 4, 'Tchaikovsky Hall'), 
    (25, '100031', 'Xichang\'an Jie', 'BJ', 'Xicheng', 1, null),           
    (1, '01310-000', 'Praça das Artes', 'SP', 'Bela Vista', 1, null);
    
insert into Orquestra (nome, dataCriacao, idEndereco, idPais, email) values
    ('New York Philharmonic', '1842-12-07', 1, 2, 'info@nyphil.org'),
    ('Orquestra Sinfônica do Recife', '1940-09-22', 2, 1, 'contato@osr.com.br'),
    ('Berliner Philharmoniker', '1882-05-01', 3, 3, 'info@berliner-philharmoniker.de'),
    ('Wiener Philharmoniker', '1842-03-28', 4, 4, 'office@wienerphilharmoniker.at'),
    ('Orquestra Filarmônica de Minas Gerais', '1964-11-08', 5, 1, 'contato@ofmg.com.br'),
    ('Orchestre de Paris', '1967-02-20', 6, 5, 'contact@orchestredeparis.com'),
    ('Tokyo Symphony Orchestra', '1946-12-01', 7, 6, 'info@tokyosymphony.jp'),
    ('Orchestra dell\'Accademia Nazionale di Santa Cecilia', '1908-02-11', 8, 7, 'info@santacecilia.it'),
    ('Orquestra Sinfônica do Teatro Nacional', '1979-07-16', 9, 1, 'contato@ostn.com.br'),
    ('Orchestre Symphonique de Montréal', '1934-01-14', 10, 8, 'info@osm.ca'),
    ('Sydney Symphony Orchestra', '1932-01-25', 11, 9, 'tickets@sydneysymphony.com'),
    ('Orquestra Sinfônica da Bahia', '1982-05-05', 12, 1, 'contato@osba.org.br'),
    ('Russian National Orchestra', '1990-11-16', 13, 10, 'info@rno.ru'),
    ('China Philharmonic Orchestra', '2000-05-25', 14, 11, 'info@cpo.org.cn'),
    ('Orquestra Sinfônica Municipal de São Paulo', '1953-08-18', 15, 1, 'contato@osmc.com.br');
    
insert into EnderecoMusico (idCidadeM, cep, logradouro, UF, bairro, numero, complemento) values
    (4, '50740-000', 'Rua do Futuro', 'PE', 'Várzea', 123, 'Apto 101'),       
    (1, '01414-001', 'Av. Paulista', 'SP', 'Bela Vista', 1000, null),         
    (9, '10707', 'Kurfürstendamm', 'BE', 'Charlottenburg', 200, null),        
    (13, '75008', 'Rue de Lisbonne', 'IDF', 'Europe', 15, '3º andar'),       
    (15, '100-0006', 'Marunouchi', 'TO', 'Chiyoda', 2, 'Apto 305'),           
    (17, '00187', 'Via del Tritone', 'RM', 'Trevi', 41, null),                
    (7, '10023', 'West 67th Street', 'NY', 'Manhattan', 10, 'Apt 2B'),        
    (19, 'H3B 2Y5', 'Rue Sainte-Catherine', 'QC', 'Ville-Marie', 1200, null), 
    (21, '2000', 'Macquarie Street', 'NSW', 'Sydney CBD', 1, null),           
    (23, '125047', 'Leningradsky Prospekt', 'MOW', 'Aeroport', 30, 'Bloco 2'),
    (25, '100005', 'Dongcheng District', 'BJ', 'Dongdan', 5, null),           
    (2, '22050-002', 'Av. Atlântica', 'RJ', 'Copacabana', 1702, 'Apto 801'),  
    (5, '40015-160', 'Rua Chile', 'BA', 'Comércio', 15, null),                
    (3, '30160-011', 'Av. Afonso Pena', 'MG', 'Centro', 1537, null),        
    (6, '70040-020', 'SHS Quadra 2', 'DF', 'Asa Sul', 10, 'Bloco C'),        
    (15, '100-0005', 'Marunouchi', 'TO', 'Chiyoda', 1, 'Apto 402'),          
    (17, '00198', 'Via Veneto', 'RM', 'Ludovisi', 125, null),               
    (9, '10178', 'Alexanderplatz', 'BE', 'Mitte', 1, 'Torre Leste'),          
    (11, '1040', 'Praterstraße', 'VI', 'Leopoldstadt', 17, null),            
    (13, '75009', 'Boulevard Haussmann', 'IDF', 'Opéra', 40, null);
    
insert into Musico (nome, CPF, email, dataNasc, nacionalidade, idEnderecoM, idPais) values
    ('João Carlos Silva', '123.456.789-01', 'joao.silva@email.com', '1985-03-15', 'Brasileiro', 1, 1),
    ('Maria Eduarda Lima', '987.654.321-09', 'maria.lima@email.com', '1990-07-22', 'Brasileira', 2, 1),
    ('Ludwig Schmidt', '111.222.333-44', 'ludwig.schmidt@email.de', '1978-11-30', 'Alemão', 3, 3),
    ('Sophie Dubois', '555.666.777-88', 'sophie.dubois@email.fr', '1982-05-14', 'Francesa', 4, 5),
    ('Yuki Tanaka', '999.888.777-66', 'yuki.tanaka@email.jp', '1993-09-05', 'Japonesa', 5, 6),
    ('Antonio Rossi', '222.333.444-55', 'antonio.rossi@email.it', '1988-12-10', 'Italiano', 6, 7),
    ('Emily Johnson', '444.555.666-77', 'emily.johnson@email.com', '1980-04-18', 'Americana', 7, 2),
    ('Carlos Mendez', '777.888.999-00', 'carlos.mendez@email.mx', '1975-08-25', 'Mexicano', 8, 14),
    ('Anna Petrova', '333.222.111-00', 'anna.petrova@email.ru', '1987-01-20', 'Russa', 9, 10),
    ('Wei Zhang', '666.777.888-99', 'wei.zhang@email.cn', '1991-06-12', 'Chinesa', 10, 11),
    ('Elena Papadopoulos', '000.111.222-33', 'elena.papa@email.gr', '1984-10-08', 'Grega', 11, 12),
    ('Daniel Müller', '888.999.000-11', 'daniel.mueller@email.at', '1979-02-28', 'Austríaco', 12, 4),
    ('Olivia Brown', '121.212.121-21', 'olivia.brown@email.uk', '1986-07-17', 'Britânica', 13, 13),
    ('Pedro Henrique Costa', '343.434.343-43', 'pedro.costa@email.com', '1995-11-03', 'Brasileiro', 14, 1),
    ('Isabella García', '565.656.565-65', 'isabella.garcia@email.es', '1983-09-24', 'Espanhola', 15, 15),
    ('Lucas Oliveira', '787.878.787-87', 'lucas.oliveira@email.com', '1992-04-07', 'Brasileiro', 16, 1),
    ('Aya Nakamura', '909.090.909-09', 'aya.nakamura@email.jp', '1989-08-19', 'Japonesa', 17, 6),
    ('Giovanni Bianchi', '123.987.456-32', 'giovanni.bianchi@email.it', '1976-03-11', 'Italiano', 18, 7),
    ('Clara Schumann', '456.789.012-34', 'clara.schumann@email.de', '1981-12-05', 'Alemã', 19, 3),
    ('Raj Patel', '678.901.234-56', 'raj.patel@email.in', '1994-05-30', 'Indiano', 20, 16);
    
insert into TelefoneMusico (idMusico, telefone1, telefone2, tipo) values
    (1, '+5581999999999', '+5581888888888', 'Celular'),
    (2, '+5511999999999', null, 'Celular'),
    (3, '+493099999999', '+493088888888', 'Residencial'),
    (4, '+33123456789', '+33698765432', 'Celular'),
    (5, '+819012345678', null, 'Celular'),
    (6, '+393331234567', '+393332345678', 'Celular'),
    (7, '+12025551234', '+12025551235', 'Celular'),
    (8, '+525512345678', null, 'Celular'),
    (9, '+74951234567', '+74957654321', 'Residencial'),
    (10, '+861012345678', null, 'Celular'),
    (11, '+302101234567', '+302109876543', 'Residencial'),
    (12, '+4312345678', '+436991234567', 'Celular'),
    (13, '+442071234567', '+447911234567', 'Celular'),
    (14, '+5531999999999', '+5531888888888', 'Celular'),
    (15, '+34612345678', null, 'Celular'),
    (16, '+5521999999999', '+5521888888888', 'Celular'),
    (17, '+819078945612', null, 'Celular'),
    (18, '+393451234567', '+393452345678', 'Celular'),
    (19, '+4915223456789', '+4915734567890', 'Celular'),
    (20, '+911112345678', null, 'Celular');
    
insert into pertence (idMusico, idOrquestra, dataIngresso) values
    (1, 2, '2015-03-10'),  
    (2, 5, '2018-07-15'),   
    (3, 3, '2010-09-12'),   
    (4, 6, '2016-05-18'),   
    (5, 7, '2021-04-30'), 
    (6, 8, '2014-08-22'),   
    (7, 1, '2017-01-10'),  
    (8, 10, '2019-11-05'),  
    (9, 13, '2013-10-15'),  
    (10, 14, '2019-03-08'), 
    (11, 4, '2020-06-20'),  
    (12, 4, '2008-11-03'),  
    (13, 11, '2015-02-14'), 
    (14, 12, '2019-11-22'), 
    (15, 9, '2020-02-05'), 
    (16, 7, '2022-07-01'),  
    (17, 8, '2012-04-17'),
    (18, 3, '2020-09-14'),  
    (19, 4, '2005-06-20'),  
    (20, 15, '2021-12-10');
    
insert into Desempenha_funcao (idMusico, idFuncao, nomeFuncao, dataInicioFuncao, dataFimFuncao) values
    (19, 1, 'Maestro', '2005-06-20', null),         
    (12, 1, 'Maestro', '2008-11-03', null),          
    (18, 20, 'Regente Assistente', '2020-09-14', null), 
    (1, 3, 'Violino', '2015-03-10', null),          
    (1, 21, 'Concertino', '2018-01-15', null),       
    (2, 4, 'Viola', '2018-07-15', null),            
    (3, 5, 'Violoncelo', '2010-09-12', null),      
    (6, 2, 'Spalla', '2014-08-22', null),            
    (14, 3, 'Violino', '2019-11-22', null),          
    (16, 6, 'Contrabaixo', '2020-02-05', null),      
    (4, 7, 'Flauta', '2016-05-18', null),            
    (5, 8, 'Oboé', '2021-04-30', null),            
    (7, 9, 'Clarinete', '2017-01-10', null),        
    (9, 10, 'Fagote', '2013-10-15', null),           
    (17, 7, 'Flauta', '2012-04-17', null),          
    (8, 11, 'Trompa', '2019-11-05', null),          
    (10, 12, 'Trompete', '2019-03-08', null),        
    (13, 13, 'Trombone', '2015-02-14', null),       
    (15, 14, 'Tuba', '2020-02-05', null),          
    (11, 18, 'Percussão', '2020-06-20', null),     
    (11, 19, 'Timpanista', '2021-01-10', null),      
    (3, 24, 'Violoncelo Solo', '2015-04-05', null),  
    (6, 22, 'Violino Solo', '2016-08-22', null),    
    (7, 28, 'Arranjador', '2019-07-10', null),       
    (14, 27, 'Preparador de Coro', '2020-11-01', null),
    (16, 29, 'Copista', '2021-03-15', null);
    
insert into executa (idOrquestra, idSinfonia, dataExecucao) values
    (3, 1, '2023-05-12'),  
    (3, 2, '2019-11-09'),  
    (4, 2, '2022-12-17'),   
    (6, 12, '2021-06-22'), 
    (8, 4, '2020-09-30'), 
    (2, 9, '2023-04-15'),  
    (5, 1, '2022-03-08'), 
    (5, 6, '2021-08-21'), 
    (12, 20, '2023-07-11'), 
    (15, 1, '2023-10-05'),  
    (1, 7, '2023-02-14'),  
    (10, 9, '2022-11-03'),
    (7, 5, '2023-09-18'), 
    (14, 14, '2023-12-24'), 
    (3, 3, '2020-01-27'),  
    (4, 1, '2022-05-07'),   
    (11, 2, '2023-12-31'), 
    (3, 19, '2018-06-15'), 
    (13, 6, '2021-10-11'), 
    (9, 9, '2023-08-22');  
    
insert into toca (idMusico, idInstrumento, dataInicio, dataFim, principal) values
    (1, 1, '2000-05-10', null, true),    
    (2, 2, '2005-08-15', null, true),   
    (3, 3, '1998-03-22', null, true),   
    (6, 1, '2002-09-12', null, true),  
    (14, 1, '2010-11-05', null, true),
    (16, 4, '2008-04-18', null, true),  
    (4, 8, '2007-07-30', null, true),    
    (5, 10, '2012-02-14', null, true),   
    (7, 12, '2009-06-20', null, true),   
    (9, 14, '2006-09-03', null, true),  
    (17, 8, '2015-03-25', null, true), 
    (8, 17, '2011-01-08', null, true), 
    (10, 18, '2013-04-17', null, true), 
    (13, 19, '2007-12-01', null, true), 
    (15, 20, '2010-10-10', null, true),  
    (11, 25, '2014-05-22', null, false), 
    (11, 27, '2016-08-11', null, true),  
    (20, 28, '2018-09-03', null, true),  
    (12, 3, '1995-02-14', null, true),  
    (19, 1, '1990-11-09', null, true),  
    (3, 5, '2010-04-05', null, false),   
    (7, 30, '2015-01-12', null, false),  
    (18, 1, '1998-07-19', null, true),   
    (18, 33, '2005-03-28', null, false);

select m.nome as Musico, i.nome as Instrumento, t.dataInicio
from Musico m
join toca t on m.idMusico = t.idMusico
join Instrumentos i on t.idInstrumento = i.idInstrumento
where t.principal = true
order by m.nome;

select o.nome as Orquestra, COUNT(p.idMusico) as Total_Musicos
from Orquestra o
left join pertence p on o.idOrquestra = p.idOrquestra
group by o.idOrquestra
order by Total_Musicos desc;

select s.nome as Sinfonia, s.compositor, COUNT(e.idSinfonia) as Execucoes
from Sinfonia s
join executa e on s.idSinfonia = e.idSinfonia
group by s.idSinfonia
order by Execucoes desc;

select m.nome as Musico, COUNT(t.idInstrumento) as Instrumentos
from Musico m
join toca t on m.idMusico = t.idMusico
group by m.idMusico
having COUNT(t.idInstrumento) > 1
order by Instrumentos desc;

select m.nome as Musico, f.descricao as Funcao, df.dataInicioFuncao
from Musico m
join Desempenha_funcao df on m.idMusico = df.idMusico
join FuncoesMusico f on df.idFuncao = f.idFuncao
where df.dataFimFuncao is null
order by m.nome;

select p.nome as Pais, COUNT(m.idMusico) as Total_Musicos
from Pais p
left join Musico m on p.idPais = m.idPais
group by p.idPais
order by Total_Musicos desc;

select i.nome as Instrumento, i.tipo, COUNT(t.idMusico) as Total_Musicos
from Instrumentos i
left join toca t on i.idInstrumento = t.idInstrumento
group by i.idInstrumento
order by Total_Musicos desc;

select o.nome as Orquestra, s.nome as Sinfonia, e.dataExecucao
from Orquestra o
join executa e on o.idOrquestra = e.idOrquestra
join Sinfonia s on e.idSinfonia = s.idSinfonia
order by o.nome, e.dataExecucao desc;

select m.nome as Maestro, o.nome as Orquestra
from Musico m
join Desempenha_funcao df on m.idMusico = df.idMusico
join FuncoesMusico f on df.idFuncao = f.idFuncao
join pertence p on m.idMusico = p.idMusico
join Orquestra o on p.idOrquestra = o.idOrquestra
where f.descricao = 'Maestro' and df.dataFimFuncao is null;

select m.nome as Musico, tm.telefone1, tm.tipo
from Musico m
join TelefoneMusico tm on m.idMusico = tm.idMusico
order by m.nome;

select s.nome as Sinfonia, s.compositor
from Sinfonia s
left join executa e on s.idSinfonia = e.idSinfonia
where e.idSinfonia is null;

select i.tipo as Familia, COUNT(distinct i.idInstrumento) as Instrumentos, 
       COUNT(distinct t.idMusico) as Musicos
from Instrumentos i
left join toca t on i.idInstrumento = t.idInstrumento
group by i.tipo
order by Instrumentos desc;

select o.nome as Orquestra, f.descricao as Funcao, COUNT(m.idMusico) as Total_Musicos
from Orquestra o
join pertence p on o.idOrquestra = p.idOrquestra
join Musico m on p.idMusico = m.idMusico
join Desempenha_funcao df on m.idMusico = df.idMusico
join FuncoesMusico f on df.idFuncao = f.idFuncao
where df.dataFimFuncao is null
group by o.idOrquestra, f.idFuncao
order by o.nome, Total_Musicos desc;

select m.nome as Musico, p_m.nome as Pais_Musico, 
       o.nome as Orquestra, p_o.nome as Pais_Orquestra
from Musico m
join pertence pe on m.idMusico = pe.idMusico
join Orquestra o on pe.idOrquestra = o.idOrquestra
join Pais p_m on m.idPais = p_m.idPais
join Pais p_o on o.idPais = p_o.idPais
where m.idPais != o.idPais
order by o.nome, m.nome;

select m.nome as Musico, f.descricao as Funcao, 
       df.dataInicioFuncao as Inicio, 
       IFNULL(df.dataFimFuncao, 'Atual') as Fim
from Musico m
join Desempenha_funcao df on m.idMusico = df.idMusico
join FuncoesMusico f on df.idFuncao = f.idFuncao
order by m.nome, df.dataInicioFuncao;

select p.nome as Pais, o.nome as Orquestra, 
       o.dataCriacao, 
       year(CURDATE()) - year(o.dataCriacao) as Anos_Atividade
from Orquestra o
join Pais p on o.idPais = p.idPais
order by p.nome, Anos_Atividade desc;

select m.nome as Musico, i.nome as Instrumento, i.tipo
from Musico m
join toca t on m.idMusico = t.idMusico
join Instrumentos i on t.idInstrumento = i.idInstrumento
where i.tipo in ('Eletrônico', 'Corda Histórica', 'Teclado Histórico')
order by i.tipo, m.nome;

select 
    case 
        when year(s.dataCriacao) < 1750 then 'Barroco'
        when year(s.dataCriacao) between 1750 and 1820 then 'Clássico'
        when year(s.dataCriacao) between 1821 and 1900 then 'Romântico'
        else 'Moderno'
    end as Periodo,
    COUNT(s.idSinfonia) as Total_Sinfonias,
    GROUP_CONCAT(distinct s.compositor separator ', ') as Compositores
from Sinfonia s
group by 
    case 
        when year(s.dataCriacao) < 1750 then 'Barroco'
        when year(s.dataCriacao) between 1750 and 1820 then 'Clássico'
        when year(s.dataCriacao) between 1821 and 1900 then 'Romântico'
        else 'Moderno'
    end
order by MIN(s.dataCriacao);

select o.nome as Orquestra, 
       (select m.nome from Musico m 
        join pertence p on m.idMusico = p.idMusico 
        where p.idOrquestra = o.idOrquestra 
        order by m.dataNasc desc limit 1) as Mais_Jovem,
       (select m.nome from Musico m 
        join pertence p on m.idMusico = p.idMusico 
        WHERE p.idOrquestra = o.idOrquestra 
        ORDER BY m.dataNasc asc limit 1) as Mais_Velho
from Orquestra o;

select 
    m.nome as Musico,
    p.nome as Pais,
    timestampdiff(year, m.dataNasc, CURDATE()) as Idade,
    (select GROUP_CONCAT(distinct i.nome separator ', ') 
     from toca t 
     join Instrumentos i on t.idInstrumento = i.idInstrumento
     where t.idMusico = m.idMusico and t.principal = true) as Instrumentos_Principais,
    (select GROUP_CONCAT(distinct f.descricao separator ', ') 
     from Desempenha_funcao df 
     join FuncoesMusico f on df.idFuncao = f.idFuncao
     where df.idMusico = m.idMusico and df.dataFimFuncao is null) as Funcoes_Atuais,
    (select o.nome from pertence p 
     join Orquestra o on p.idOrquestra = o.idOrquestra
     where p.idMusico = m.idMusico limit 1) as Orquestra_Principal
from Musico m
join Pais p on m.idPais = p.idPais
order by m.nome;

create or replace view vw_musicos_completos as
select 
    m.idMusico,
    m.nome,
    m.CPF,
    m.email,
    m.dataNasc,
    m.nacionalidade,
    p.nome as pais_origem,
    CONCAT(e.logradouro, ', ', e.numero, ' - ', e.bairro, ', ', c.nome, '-', e.UF) as endereco_completo,
    (select GROUP_CONCAT(distinct i.nome separator ', ') 
     from toca t join Instrumentos i on t.idInstrumento = i.idInstrumento 
     where t.idMusico = m.idMusico and t.principal = true) as instrumentos_principais
from Musico m
join Pais p on m.idPais = p.idPais
join EnderecoMusico e on m.idEnderecoM = e.idEnderecoM
join Cidade c on e.idCidadeM = c.idCidade;

create or replace view vw_orquestras_estatisticas as
select 
    o.idOrquestra,
    o.nome,
    o.dataCriacao,
    p.nome AS pais,
    (select COUNT(*) from pertence where idOrquestra = o.idOrquestra) as total_musicos,
    (select COUNT(*) from executa where idOrquestra = o.idOrquestra) as total_sinfonias_executadas,
    (select MAX(dataExecucao) from executa where idOrquestra = o.idOrquestra) as ultima_execucao
from Orquestra o
join Pais p on o.idPais = p.idPais;

create or replace view vw_sinfonias_popularidade as
select 
    s.idSinfonia,
    s.nome,
    s.compositor,
    s.dataCriacao,
    COUNT(e.idOrquestra) as vezes_executada,
    (select GROUP_CONCAT(distinct o.nome separator ', ') 
     from executa ex join Orquestra o on ex.idOrquestra = o.idOrquestra 
     where ex.idSinfonia = s.idSinfonia) as orquestras_executantes
from Sinfonia s
left join executa e on s.idSinfonia = e.idSinfonia
group by s.idSinfonia;

create or replace view vw_instrumentos_populares as
select 
    i.idInstrumento,
    i.nome,
    i.tipo,
    COUNT(t.idMusico) as total_musicos,
    (select GROUP_CONCAT(distinct m.nome separator ', ') 
     from toca tc join Musico m on tc.idMusico = m.idMusico 
     where tc.idInstrumento = i.idInstrumento and tc.principal = true limit 5) as musicos_destaque
from Instrumentos i
left join toca t on i.idInstrumento = t.idInstrumento
group by i.idInstrumento
order by total_musicos desc;

create or replace view vw_funcoes_orquestra as
select 
    f.idFuncao,
    f.descricao,
    COUNT(df.idMusico) AS total_ocupantes,
    (select GROUP_CONCAT(distinct m.nome separator ', ') 
     from Desempenha_funcao df2 
     join Musico m on df2.idMusico = m.idMusico 
     where df2.idFuncao = f.idFuncao and df2.dataFimFuncao is null limit 5) as ocupantes_atuais
from FuncoesMusico f
left join Desempenha_funcao df on f.idFuncao = df.idFuncao and df.dataFimFuncao is null
group by f.idFuncao;

create or replace view vw_musicos_por_pais as
select 
    p.nome as pais,
    p.sigla,
    COUNT(m.idMusico) as total_musicos,
    (select GROUP_CONCAT(distinct m2.nome separator ', ') 
     from Musico m2 where m2.idPais = p.idPais limit 5) as musicos_exemplo
from Pais p
left join Musico m on p.idPais = m.idPais
group by p.idPais
order by total_musicos desc;

create or replace view vw_musicos_orquestras as
select 
    m.nome as musico,
    o.nome as orquestra,
    p.dataIngresso,
    timestampdiff(year, p.dataIngresso, CURDATE()) as anos_na_orquestra,
    (select GROUP_CONCAT(f.descricao separator ', ') 
     from Desempenha_funcao df 
     join FuncoesMusico f on df.idFuncao = f.idFuncao 
     where df.idMusico = m.idMusico and df.dataFimFuncao is null) as funcoes_atuais
from Musico m
join pertence p on m.idMusico = p.idMusico
join Orquestra o on p.idOrquestra = o.idOrquestra
order by o.nome, m.nome;

create or replace view vw_historico_execucoes as
select 
    o.nome as orquestra,
    s.nome as sinfonia,
    s.compositor,
    e.dataExecucao,
    year(e.dataExecucao) as ano_execucao,
    (select COUNT(*) 
     from executa e2 
     where e2.idSinfonia = s.idSinfonia and e2.idOrquestra = o.idOrquestra) as vezes_executada_por_esta_orquestra
from executa e
join Orquestra o on e.idOrquestra = o.idOrquestra
join Sinfonia s on e.idSinfonia = s.idSinfonia
order by e.dataExecucao desc;

create or replace view vw_instrumentos_por_musico as
select 
    m.nome as musico,
    GROUP_CONCAT(distinct i.nome separator ', ') as instrumentos,
    COUNT(distinct t.idInstrumento) as total_instrumentos,
    (select i2.nome 
     from toca t2 
     join Instrumentos i2 on t2.idInstrumento = i2.idInstrumento 
     WHERE t2.idMusico = m.idMusico and t2.principal = true limit 1) as instrumento_principal
from Musico m
join toca t on m.idMusico = t.idMusico
join Instrumentos i on t.idInstrumento = i.idInstrumento
group by m.idMusico;

create or replace view vw_maestros_orquestras as
select 
    m.nome as maestro,
    o.nome as orquestra,
    p.dataIngresso as data_inicio_na_orquestra,
    df.dataInicioFuncao as data_inicio_como_maestro,
    timestampdiff(year, df.dataInicioFuncao, CURDATE()) as anos_como_maestro
from Musico m
join Desempenha_funcao df on m.idMusico = df.idMusico
join FuncoesMusico f on df.idFuncao = f.idFuncao
join pertence p on m.idMusico = p.idMusico
join Orquestra o on p.idOrquestra = o.idOrquestra
where f.descricao = 'Maestro' and df.dataFimFuncao is null
order by anos_como_maestro desc;

create or replace view vw_sinfonias_por_periodo AS
select 
    case 
        when year(s.dataCriacao) < 1750 then 'Barroco'
        when year(s.dataCriacao) between 1750 and 1820 then 'Clássico'
        when year(s.dataCriacao) between 1821 and 1900 then 'Romântico'
        else 'Moderno'
    end as periodo,
    COUNT(s.idSinfonia) as total_sinfonias,
    GROUP_CONCAT(distinct s.compositor separator ', ') as compositores,
    MIN(year(s.dataCriacao)) as ano_mais_antigo,
    MAX(year(s.dataCriacao)) as ano_mais_recente
from Sinfonia s
group by periodo
order by ano_mais_antigo;

create or replace view vw_contatos_musicos as
select 
    m.nome as musico,
    m.email,
    tm.telefone1 as telefone_principal,
    tm.tipo as tipo_telefone,
    o.nome as orquestra_principal,
    (select telefone2 from TelefoneMusico where idMusico = m.idMusico limit 1) as telefone_secundario
from Musico m
join TelefoneMusico tm on m.idMusico = tm.idMusico
left join pertence p on m.idMusico = p.idMusico
left join Orquestra o on p.idOrquestra = o.idOrquestra
group by m.idMusico;

DELIMITER //

drop procedure if exists sp_adicionar_musico_orquestra //
create procedure sp_adicionar_musico_orquestra(
    in p_nome varchar(80),
    in p_cpf varchar(14),
    in p_email varchar(80),
    in p_data_nasc date,
    in p_nacionalidade varchar(45),
    in p_id_pais int,
    in p_id_endereco int,
    in p_id_orquestra int,
    in p_data_ingresso date,
    in p_id_instrumento int,
    in p_data_inicio_instrumento date,
    in p_principal boolean
)
begin
    declare v_id_musico int;
    declare v_id_funcao int default 3;
    
    if not exists (select 1 from FuncoesMusico where idFuncao = v_id_funcao) then
        select idFuncao into v_id_funcao from FuncoesMusico limit 1;
    end if;
    

    insert into Musico (nome, CPF, email, dataNasc, nacionalidade, idPais, idEnderecoM)
    values (p_nome, p_cpf, p_email, p_data_nasc, p_nacionalidade, p_id_pais, p_id_endereco);
    
    set v_id_musico = LAST_INSERT_ID();
    
    insert into pertence (idMusico, idOrquestra, dataIngresso)
    values (v_id_musico, p_id_orquestra, p_data_ingresso);
    
    insert into toca (idMusico, idInstrumento, dataInicio, principal)
    values (v_id_musico, p_id_instrumento, p_data_inicio_instrumento, p_principal);
    
    insert into Desempenha_funcao (idMusico, idFuncao, dataInicioFuncao)
    values (v_id_musico, v_id_funcao, p_data_ingresso);
    
    select CONCAT('Músico ', p_nome, ' adicionado com sucesso! ID: ', v_id_musico) as resultado;
end //

drop procedure if exists sp_reajuste_salarial_orquestra //
create procedure sp_reajuste_salarial_orquestra(
	in p_id_orquestra int,
    in p_percentual decimal(5,2),
    in p_data_reajuste date
)
begin
	update pertence 
	set salario = IFNULL(salario, 0) * (1 + (p_percentual / 100))
	where idOrquestra = p_id_orquestra;

	select 
		o.nome as orquestra,
		COUNT(p.idMusico) as musicos_afetados,
		MIN(p.salario) as menor_novo_salario,
		MAX(p.salario) as maior_novo_salario,
		avg(p.salario) as media_salarial
	from pertence p
	join Orquestra o on p.idOrquestra = o.idOrquestra
	where p.idOrquestra = p_id_orquestra
	group by o.nome;
end //

drop procedure if exists sp_promover_musico //
create procedure sp_promover_musico(
    in p_id_musico int,
    in p_nova_funcao varchar(100),
    in p_data_promocao date
)
begin
    declare v_id_nova_funcao int;
    
    select idFuncao into v_id_nova_funcao 
    from FuncoesMusico 
    where descricao = p_nova_funcao limit 1;
    
    update Desempenha_funcao 
    set dataFimFuncao = p_data_promocao 
    where idMusico = p_id_musico and dataFimFuncao is null;
    
    insert into Desempenha_funcao (idMusico, idFuncao, dataInicioFuncao)
    values (p_id_musico, v_id_nova_funcao, p_data_promocao);
    
    select CONCAT('Promoção realizada com sucesso!') as resultado;
end //

drop procedure if exists sp_registrar_execucao //
create procedure sp_registrar_execucao(
    in p_id_orquestra int,
    in p_id_sinfonia int,
    in p_data_execucao date,
    in p_local varchar(100),
    in p_publico_estimado int
)
begin
    insert into executa (idOrquestra, idSinfonia, dataExecucao, localExecucao, publicoEstimado)
    values (p_id_orquestra, p_id_sinfonia, p_data_execucao, p_local, p_publico_estimado);
    
    select 
        o.nome as orquestra,
        s.nome as sinfonia,
        s.compositor,
        p_data_execucao as data_execucao,
        p_local as local
    from Orquestra o, Sinfonia s
    where o.idOrquestra = p_id_orquestra and s.idSinfonia = p_id_sinfonia;
end //

drop procedure if exists sp_relatorio_anual_orquestra //
create procedure sp_relatorio_anual_orquestra(
    in p_id_orquestra int,
    in p_ano int
)
begin
    select 
        o.nome as orquestra,
        p_ano as ano,
        COUNT(distinct e.idSinfonia) as sinfonias_executadas,
        COUNT(e.idSinfonia) as total_execucoes,
        (select COUNT(*) from pertence 
         where idOrquestra = p_id_orquestra 
         and year(dataIngresso) = p_ano) as novos_musicos
    from Orquestra o
    left join executa e on o.idOrquestra = e.idOrquestra and year(e.dataExecucao) = p_ano
    where o.idOrquestra = p_id_orquestra
    group by o.nome;
end //

drop procedure if exists sp_transferir_musico //
create procedure sp_transferir_musico(
    in p_id_musico int,
    in p_id_nova_orquestra int,
    in p_data_transferencia date,
    in p_novo_salario decimal(10,2)
)
begin
    declare v_id_orquestra_antiga int;
    
    select idOrquestra into v_id_orquestra_antiga 
    from pertence 
    where idMusico = p_id_musico and dataSaida is null;
    
    update pertence 
    set dataSaida = p_data_transferencia
    where idMusico = p_id_musico and dataSaida is null;
    
    insert into pertence (idMusico, idOrquestra, dataIngresso, salario)
    values (p_id_musico, p_id_nova_orquestra, p_data_transferencia, p_novo_salario);
    
    select CONCAT('Transferência realizada com sucesso!') as resultado;
end //


DELIMITER ;

call sp_adicionar_musico_orquestra(
    'Marcelo Costa',
    '999.888.777-77',              
    'marcelo.teste@email123.com', 
    '1991-08-22',
    'Brasileiro',
    1,  
    2,   
    2,   
    '2024-06-01',
    1,   
    '2010-02-15',
    true
);

update pertence set salario = 5000 where idOrquestra = 2;
call sp_reajuste_salarial_orquestra(2, 10.00, '2025-06-21');

call sp_promover_musico(
    1,                    
    'Spalla (Primeiro Violino)',  
    '2024-06-01'          
);

alter table executa 
add column localExecucao varchar(100),
add column publicoEstimado int;

call sp_registrar_execucao(
    2,                
    1,                
    '2025-07-15',
    'Teatro Santa Isabel',
    1200
);

call sp_relatorio_anual_orquestra(2, 2023);

alter table pertence add column dataSaida date;

call sp_transferir_musico(
    1,
    5,
    '2025-06-20',
    6200.00
);

DELIMITER //

create function fn_total_musicos_por_orquestra(p_id_orquestra int)
returns int
deterministic
begin
  declare total int;
  select COUNT(*) into total
  from pertence
  where idOrquestra = p_id_orquestra;
  return total;
end //

DELIMITER ;

DELIMITER //

create function fn_idade_musico(p_id_musico int)
returns int
deterministic
begin
  declare idade int;
  select timestampdiff(year, dataNasc, CURDATE()) into idade
  from Musico
  where idMusico = p_id_musico;
  return idade;
end //

DELIMITER ;


DELIMITER //

create function fn_maestro_orquestra(p_id_orquestra int)
returns varchar(80)
deterministic
begin
  declare nome_maestro varchar(80);

  select m.nome into nome_maestro
  from Musico m
  join Desempenha_funcao df on m.idMusico = df.idMusico
  join FuncoesMusico f on df.idFuncao = f.idFuncao
  join pertence p on m.idMusico = p.idMusico
  where f.descricao = 'Maestro'
    and df.dataFimFuncao is null
    and p.idOrquestra = p_id_orquestra
  limit 1;

  return nome_maestro;
end //

DELIMITER ;


DELIMITER //

create function fn_total_execucoes_sinfonia(p_id_sinfonia int)
returns int
deterministic
begin
  declare total int;
  select COUNT(*) into total
  from executa
  where idSinfonia = p_id_sinfonia;
  return total;
end //

DELIMITER ;


DELIMITER //

create function fn_instrumentos_principais_musico(p_id_musico int)
returns text
deterministic
begin
  declare instrumentos text;

  select GROUP_CONCAT(i.nome separator ', ') into instrumentos
  from toca t
  join Instrumentos i on t.idInstrumento = i.idInstrumento
  where t.idMusico = p_id_musico and t.principal = true;

  return IFNULL(instrumentos, 'Nenhum instrumento principal');
end //

DELIMITER ;


DELIMITER //

create function fn_anos_na_orquestra(p_id_musico int, p_id_orquestra int)
returns int
deterministic
begin
  declare anos int;

  select timestampdiff(year, dataIngresso, IFNULL(dataSaida, CURDATE()))
  into anos
  from pertence
  where idMusico = p_id_musico and idOrquestra = p_id_orquestra
  order by dataIngresso desc
  limit 1;

  return anos;
end //

DELIMITER ;


select fn_total_musicos_por_orquestra(1) as total_musicos_orquestra_1;

select fn_idade_musico(1) as idade_musico_1;

select fn_maestro_orquestra(1) as maestro_orquestra_1;

select fn_total_execucoes_sinfonia(1) as total_execucoes_sinfonia_1;

select fn_instrumentos_principais_musico(1) as instrumentos_principais_musico_1;

select fn_anos_na_orquestra(1, 1) as anos_na_orquestra_1_1;

DELIMITER //
create trigger trg_limita_funcoes_ativas
before insert on Desempenha_funcao
for each row
begin
  if exists (
    select 1 from Desempenha_funcao
    where idMusico = new.idMusico and dataFimFuncao is null
  ) then
    signal sqlstate '45000'
    set message_text = 'O músico já possui uma função ativa.';
  end if;
end;
//
DELIMITER ;

DELIMITER //
create trigger trg_unico_instrumento_principal
before insert on toca
for each row
begin
  if new.principal = true and exists (
    select 1 from toca
    where idMusico = new.idMusico and idInstrumento = new.idInstrumento and principal = true
  ) then
    signal sqlstate '45000'
    set message_text = 'O músico já toca esse instrumento como principal.';
  end if;
end;
//
DELIMITER ;

DELIMITER //
create trigger trg_valida_datas_toca
before insert on toca
for each row
begin
  if new.dataFim is not null and new.dataFim < new.dataInicio then
    signal sqlstate '45000'
    set message_text = 'A data de fim não pode ser anterior à data de início.';
  end if;
end;
//
DELIMITER ;

DELIMITER //
create trigger trg_funcao_padrao_musico
after insert on Musico
for each row 
begin
  insert into Desempenha_funcao (idMusico, idFuncao, dataInicioFuncao)
  values (new.idMusico, 3, CURDATE());
end;
//
DELIMITER ;

DELIMITER //
create trigger trg_salario_positivo
before insert on pertence
for each row
begin
  if new.salario is not null and new.salario < 0 then
    signal sqlstate '45000'
    set message_text = 'O salário não pode ser negativo.';
  end if;
end;
//
DELIMITER ;

create table if not exists LogExecucoes (
  idLog int auto_increment primary key,
  idOrquestra int,
  idSinfonia int,
  dataExecucao date,
  dataRegistro timestamp default current_timestamp
);

DELIMITER //
create trigger trg_log_execucao
after insert on executa
for each row 
begin
  insert into LogExecucoes (idOrquestra, idSinfonia, dataExecucao)
  values (new.idOrquestra, new.idSinfonia, new.dataExecucao);
end;
//
DELIMITER ;

insert into Desempenha_funcao (idMusico, idFuncao, dataInicioFuncao)
values (1, 4, CURDATE());
-- Esperado: erro dizendo que o músico já possui uma função ativa

insert into toca (idMusico, idInstrumento, dataInicio, principal)
values (1, 1, CURDATE(), true);
-- Esperado: erro dizendo que o músico já toca esse instrumento como principal

insert into toca (idMusico, idInstrumento, dataInicio, dataFim, principal)
values (2, 2, '2024-01-01', '2023-01-01', false);
-- Esperado: erro dizendo que a data de fim não pode ser anterior à de início

insert into Musico (nome, CPF, email, dataNasc, nacionalidade, idEnderecoM, idPais)
values ('Teste Função', '111.111.111-11', 'teste@funcao.com', '1990-01-01', 'Brasileiro', 1, 1);

-- Verificar se a função com idFuncao = 3 foi atribuída:
select * from Desempenha_funcao where idMusico = LAST_INSERT_ID();

insert into pertence (idMusico, idOrquestra, dataIngresso, salario)
values (2, 2, CURDATE(), -1000.00);
-- Esperado: erro dizendo que o salário não pode ser negativo

insert into executa (idOrquestra, idSinfonia, dataExecucao)
values (2, 1, CURDATE());

-- Verificar se foi logado:
select * from LogExecucoes order by idLog desc limit 1;
