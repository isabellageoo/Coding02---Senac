create database if not exists EscolaDeMusica;
use EscolaDeMusica;

create table EnderecoOrquestra (
	idEnderecoOrquestra int auto_increment primary key,
    idCidade int,
    cep varchar(9) not null,
    logradouro varchar(80) not null,
    UF char(2) not null,
    bairro varchar(45) not null,
    numero int not null,
    complemento varchar(45) null,
    foreign key (idCidade) references Cidade(idCidade) 
);

create table Orquestra (
	idOrquestra int auto_increment primary key,
    nome varchar(80) not null,
    dataCriacao date not null,
    idEndereco int,
    email varchar(80) not null,
    foreign key (idEndereco) references EnderecoOrquestra(idEnderecoOrquestra)
);

create table EnderecoMusico (
	idEnderecoM int auto_increment primary key,
    idCidadeM int,
    cep varchar(9) not null,
    logradouro varchar(80) not null,
    UF char(2) not null,
    bairro varchar(45) not null,
    numero int not null,
    complemento varchar(45) null,
    foreign key (idCidadeM) references Cidade(idCidade)
);

create table Musico (
	idMusico int auto_increment primary key,
    nome varchar(80) not null,
    CPF varchar(14) not null unique, 
    email varchar(80) not null,
    dataNasc date not null,
    nacionalidade varchar(45) not null,
    idEnderecoM int,
    constraint chk_cpf_format check (cpf regexp '^[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}$'),
    foreign key (idEnderecoM) references EnderecoMusico(idEnderecoM)
    );
    
create table TelefoneMusico (
	idTelefone int auto_increment primary key,
	idMusico int not null,
	telefone1 varchar(15) not null,
	telefone2 varchar(15) null,
	telefone3 varchar(15) null,
	tipo enum('Celular', 'Residencial', 'Comercial', 'Recado') not null,
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
	nomeInstrumento varchar(45) not null,
	classe varchar(45) not null
	);
    
create table pertence (
	idMusico int,
	idOrquestra int,
	dataIngresso date,
	primary key (idMusico, idOrquestra),
	foreign key (idMusico) references Musico(idMusico),
	foreign key (idOrquestra) references Orquestra(idOrquestra)
    );
    
create table Desempenha_funcao (
	idMusico int,
	idFuncao int not null,
	nomeFuncao varchar(45) not null,
	dataInicioFuncao date not null,
	dataFimFuncao date not null,
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
	dataFim date null,
	primary key (idMusico, idInstrumento, dataInicio),
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
create index idx_instrumento_classe on Instrumentos(classe);
    
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
    
alter table Musico drop column `1`;
alter table Musico add constraint uk_musico_email unique (email);

alter table Instrumentos change nomeInstrumento nome varchar(45) not null,
						  change classe tipo varchar(45) not null;

alter table Desempenha_funcao modify dataFimFuncao date null;

create table Pais (
	idPais int auto_increment primary key,
    nome varchar(45) not null,
    sigla char(2) not null
);

alter table Orquestra add column idPais int,
    add foreign key (idPais) references Pais(idPais);
    
alter table Musico add column idPais int,
    add foreign key (idPais) references Pais(idPais);

create table Cidade (
    idCidade int auto_increment primary key,
    nome varchar(45) not null,
    idPais int not null,
    foreign key (idPais) references Pais(idPais)
);

alter table Musico add constraint chk_email_format 
    check (email regexp '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$');
    
alter table Musico add constraint chk_data_nasc 
    check (dataNasc between '1900-01-01' and curdate());
    
create table if not exists Cidade (
    idCidade int auto_increment primary key,
    nome varchar(45) not null,
    UF char(2) not null,
    idPais int,
    foreign key (idPais) references Pais(idPais)
);