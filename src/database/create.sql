create database lacrei;

use lacrei;

CREATE TABLE formacao (
	id INT PRIMARY KEY auto_increment,
	curso VARCHAR(100) NOT NULL,
	escola VARCHAR(100) NOT NULL,
	ano_formatura INT NOT NULL,
	profissional_id INT NOT NULL);

CREATE TABLE profissao (
	id INT PRIMARY KEY auto_increment,
	nome VARCHAR(30) NOT NULL,
	prefixo_conselho VARCHAR(10) NOT NULL);

CREATE TABLE especialidade (
	id INT PRIMARY KEY auto_increment,
	translate_key VARCHAR(50) NOT NULL,
	descricao VARCHAR(100) NOT NULL,
	profissao_id INT NOT NULL);
	
CREATE TABLE servico (
	id INT PRIMARY KEY auto_increment,
	nome VARCHAR(50) NOT NULL,
	duracao INT NOT NULL,
	valor NUMERIC NOT NULL,
	atende_clinica BIT NOT NULL,
	atende_online BIT NOT NULL,
	atende_domicilio BIT NOT NULL,
	profissional_id INT NOT NULL);
		
CREATE TABLE profissional (
	id INT PRIMARY KEY auto_increment,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL,
    senha VARCHAR(200) NOT NULL,
	numero_conselho VARCHAR(30) NOT NULL,
	conselho_ativo BIT NOT NULL,
	lista_espera BIT NOT NULL,
	regiao_atuacao VARCHAR(2) NOT NULL,
	descricao_foto VARCHAR(500) NOT NULL,
	sobre_mim VARCHAR(500) NOT NULL,
	carta_entrada VARCHAR(500) NOT NULL,
	rqe VARCHAR(20),
	alvoL BIT NOT NULL,
	alvoG BIT NOT NULL,
	alvoB BIT NOT NULL,
	alvoT BIT NOT NULL,
	alvoQ BIT NOT NULL,
	alvoI BIT NOT NULL,
	alvoA BIT NOT NULL,
	alvoP BIT NOT NULL,
	alvoN BIT NOT NULL,
	identidade_id INT NOT NULL);
	
CREATE TABLE doenca (
	id INT PRIMARY KEY auto_increment,
	codigo VARCHAR(3) NOT NULL,
	nome VARCHAR(50) NOT NULL);
	
CREATE TABLE identidade (
	id INT PRIMARY KEY auto_increment,
	profissional_id INT NOT NULL,
	pronome_artigo_id INT NOT NULL,
	etnia_id INT NOT NULL,
	ident_genero_id INT NOT NULL,
	sexualidade_id INT NOT NULL,
	pcd_id INT NOT NULL);
	
CREATE TABLE pronome_artigo (
	id INT PRIMARY KEY auto_increment,
	nome VARCHAR(20) NOT NULL);

CREATE TABLE etnia (
	id INT PRIMARY KEY auto_increment,
	nome VARCHAR(20) NOT NULL);

CREATE TABLE ident_genero (
	id INT PRIMARY KEY auto_increment,
	nome VARCHAR(20) NOT NULL);

CREATE TABLE sexualidade (
	id INT PRIMARY KEY auto_increment,
	nome VARCHAR(20) NOT NULL);

CREATE TABLE pcd (
	id INT PRIMARY KEY auto_increment,
	nome VARCHAR(40) NOT NULL);
	
CREATE TABLE consultorio (
	id INT PRIMARY KEY auto_increment,
	atende_clinica BIT NOT NULL,
	atende_online BIT NOT NULL,
	atende_domicilio BIT NOT NULL,
	tel_fixo VARCHAR(20),
	celular VARCHAR(20),
	whatsapp VARCHAR(20),
	acessibilidade1 BIT NOT NULL,
	acessibilidade2 BIT NOT NULL,
	acessibilidade3 BIT NOT NULL,
	acessibilidade4 BIT NOT NULL,
	acessibilidade5 BIT NOT NULL,
	acessibilidade6 BIT NOT NULL,
	acessibilidade7 BIT NOT NULL,
	acessibilidade8 BIT NOT NULL,
	acessibilidade9 BIT NOT NULL,
	acessibilidade10 BIT NOT NULL,
	acessibilidade11 BIT NOT NULL,
	acessibilidade12 BIT NOT NULL,
	profissional_id INT NOT NULL,
	endereco_id INT NOT NULL);

CREATE TABLE endereco (
	id INT PRIMARY KEY auto_increment,
	rua VARCHAR(50) NOT NULL,
	numero INT,
	bairro VARCHAR(50) NOT NULL,
	cidade VARCHAR(50) NOT NULL,
	complemento VARCHAR(50),
	cep VARCHAR(10),
	consultorio_id INT NOT NULL);
	
CREATE TABLE convenio (
	id INT PRIMARY KEY auto_increment,
	nome VARCHAR(50) NOT NULL);

CREATE TABLE horario (
	id INT PRIMARY KEY auto_increment,
	dia_semana INT NOT NULL,
	hora_inicio TIME NOT NULL,
	hora_fim TIME NOT NULL,
	consultorio_id INT NOT NULL);


ALTER TABLE formacao
ADD CONSTRAINT FK_ProfissionalFormacao FOREIGN KEY (profissional_id) REFERENCES profissional(id);

ALTER TABLE especialidade
ADD CONSTRAINT FK_ProfissaoEspecialidade FOREIGN KEY (profissao_id) REFERENCES profissao(id);

ALTER TABLE servico
ADD CONSTRAINT FK_ProfissionalServico FOREIGN KEY (profissional_id) REFERENCES profissional(id);

ALTER TABLE profissional
ADD CONSTRAINT FK_IdentProfissional FOREIGN KEY (identidade_id) REFERENCES identidade(id);

ALTER TABLE identidade
ADD CONSTRAINT FK_ProfissionalIdent FOREIGN KEY (profissional_id) REFERENCES profissional(id),
ADD CONSTRAINT FK_PronomeIdent FOREIGN KEY (pronome_artigo_id) REFERENCES pronome_artigo(id),
ADD CONSTRAINT FK_EtniaIdent FOREIGN KEY (etnia_id) REFERENCES etnia(id),
ADD CONSTRAINT FK_IdentGeneroIdent FOREIGN KEY (ident_genero_id) REFERENCES ident_genero(id),
ADD CONSTRAINT FK_SexualidadeIdent FOREIGN KEY (sexualidade_id) REFERENCES sexualidade(id),
ADD CONSTRAINT FK_PCDIdent FOREIGN KEY (pcd_id) REFERENCES pcd(id);

ALTER TABLE consultorio
ADD CONSTRAINT FK_ProfissionalConsultorio FOREIGN KEY (profissional_id) REFERENCES profissional(id),
ADD CONSTRAINT FK_EnderecoConsultorio FOREIGN KEY (endereco_id) REFERENCES endereco(id);

ALTER TABLE endereco
ADD CONSTRAINT FK_ConsultorioEndereco FOREIGN KEY (consultorio_id) REFERENCES consultorio(id);

ALTER TABLE horario
ADD CONSTRAINT FK_ConsultorioHorario FOREIGN KEY (consultorio_id) REFERENCES consultorio(id);

CREATE TABLE profissional_doenca (
	id INT PRIMARY KEY auto_increment,
  	profissional_id INT NOT NULL,
    doenca_id INT NOT NULL,
    CONSTRAINT FK_Profissional FOREIGN KEY (profissional_id) REFERENCES profissional(id),
	CONSTRAINT FK_Doenca FOREIGN KEY (doenca_id) REFERENCES doenca(id));
	
CREATE TABLE consultorio_convenio (
	id INT PRIMARY KEY auto_increment,
  	consultorio_id INT NOT NULL,
    convenio_id INT NOT NULL,
    CONSTRAINT FK_Consultorio FOREIGN KEY (consultorio_id) REFERENCES consultorio(id),
	CONSTRAINT FK_Convenio FOREIGN KEY (convenio_id) REFERENCES convenio(id));
	

INSERT INTO pronome_artigo (nome) VALUES ('Ele/Dele');
INSERT INTO pronome_artigo (nome) VALUES ('Ela/Dela');
INSERT INTO pronome_artigo (nome) VALUES ('Elu/Delu');
INSERT INTO pronome_artigo (nome) VALUES ('Outro');

INSERT INTO etnia (nome) VALUES ('Indígena');
INSERT INTO etnia (nome) VALUES ('Branca');
INSERT INTO etnia (nome) VALUES ('Parda');
INSERT INTO etnia (nome) VALUES ('Amarela');
INSERT INTO etnia (nome) VALUES ('Preta');
INSERT INTO etnia (nome) VALUES ('Outra');

INSERT INTO ident_genero (nome) VALUES ('Intersexo');
INSERT INTO ident_genero (nome) VALUES ('Homem Trans');
INSERT INTO ident_genero (nome) VALUES ('Não-Binárie');
INSERT INTO ident_genero (nome) VALUES ('Agênera');
INSERT INTO ident_genero (nome) VALUES ('Andrógeno');
INSERT INTO ident_genero (nome) VALUES ('Queer');
INSERT INTO ident_genero (nome) VALUES ('Mulher Trans');
INSERT INTO ident_genero (nome) VALUES ('Mulher Cis');
INSERT INTO ident_genero (nome) VALUES ('Homem Cis');
INSERT INTO ident_genero (nome) VALUES ('Outro');

INSERT INTO sexualidade (nome) VALUES ('Assexual');
INSERT INTO sexualidade (nome) VALUES ('Lésbica');
INSERT INTO sexualidade (nome) VALUES ('Heterossexual');
INSERT INTO sexualidade (nome) VALUES ('Panssexual');
INSERT INTO sexualidade (nome) VALUES ('Bissexual');
INSERT INTO sexualidade (nome) VALUES ('Gay');
INSERT INTO sexualidade (nome) VALUES ('Outra');

INSERT INTO pcd (nome) VALUES ('Deficiência motora');
INSERT INTO pcd (nome) VALUES ('Deficiência cognitivo-intelectual');
INSERT INTO pcd (nome) VALUES ('Deficiência auditiva');
INSERT INTO pcd (nome) VALUES ('Deficiência visual');

INSERT INTO profissao (nome, prefixo_conselho) VALUES ('Enfermagem', 'COREN');
INSERT INTO profissao (nome, prefixo_conselho) VALUES ('Fisioterapia', 'CREFITO');
INSERT INTO profissao (nome, prefixo_conselho) VALUES ('Fonoaudiologia', 'CRFa');
INSERT INTO profissao (nome, prefixo_conselho) VALUES ('Medicina', 'CRM');
INSERT INTO profissao (nome, prefixo_conselho) VALUES ('Nutrição', 'CRN');
INSERT INTO profissao (nome, prefixo_conselho) VALUES ('Odontologia', 'CRO');
INSERT INTO profissao (nome, prefixo_conselho) VALUES ('Psicologia', 'CRP');


INSERT INTO convenio (nome) VALUES ('AGF');
INSERT INTO convenio (nome) VALUES ('IPALE RJ');
INSERT INTO convenio (nome) VALUES ('AMAFRE RJ');
INSERT INTO convenio (nome) VALUES ('name');
INSERT INTO convenio (nome) VALUES ('Unimed');
INSERT INTO convenio (nome) VALUES ('Mediservice');
INSERT INTO convenio (nome) VALUES ('Unimed Intercâmbio');
INSERT INTO convenio (nome) VALUES ('Fioprev');
INSERT INTO convenio (nome) VALUES ('Amil');
INSERT INTO convenio (nome) VALUES ('Vale do rio doce');
INSERT INTO convenio (nome) VALUES ('Ônix');
INSERT INTO convenio (nome) VALUES ('Intermedicina');
INSERT INTO convenio (nome) VALUES ('Camed');
INSERT INTO convenio (nome) VALUES ('Sul América Saúde');
INSERT INTO convenio (nome) VALUES ('Eletronuclear');
INSERT INTO convenio (nome) VALUES ('Memorial Saúde');
INSERT INTO convenio (nome) VALUES ('interodonto');
INSERT INTO convenio (nome) VALUES ('Fiosaúde');
INSERT INTO convenio (nome) VALUES ('Golden Cross');
INSERT INTO convenio (nome) VALUES ('Fiocruz');
INSERT INTO convenio (nome) VALUES ('BACEN');
INSERT INTO convenio (nome) VALUES ('ABET');
INSERT INTO convenio (nome) VALUES ('Appai');
INSERT INTO convenio (nome) VALUES ('Santa Casa Saúde');
INSERT INTO convenio (nome) VALUES ('Sind Saúde');
INSERT INTO convenio (nome) VALUES ('Eletros - Saúde');
INSERT INTO convenio (nome) VALUES ('EMBRATEL');
INSERT INTO convenio (nome) VALUES ('Cassi');
INSERT INTO convenio (nome) VALUES ('Medservice');
INSERT INTO convenio (nome) VALUES ('HAPVIDA');
INSERT INTO convenio (nome) VALUES ('ANASPS');
INSERT INTO convenio (nome) VALUES ('Caixa Seguradora Especializada em Saúde S/ A');
INSERT INTO convenio (nome) VALUES ('Unimed Rio');
INSERT INTO convenio (nome) VALUES ('Allianz');
INSERT INTO convenio (nome) VALUES ('Assim Saúde');
INSERT INTO convenio (nome) VALUES ('Saúde Caixa (Caixa Econômica Federal)');
INSERT INTO convenio (nome) VALUES ('NUCLEP');
INSERT INTO convenio (nome) VALUES ('NotreDame Seguradora');
INSERT INTO convenio (nome) VALUES ('Dix Saúde');
INSERT INTO convenio (nome) VALUES ('CLUB SAÚDE');
INSERT INTO convenio (nome) VALUES ('Vale - PASA');
INSERT INTO convenio (nome) VALUES ('Porto Seguro Saúde');
INSERT INTO convenio (nome) VALUES ('Geap Saúde');
INSERT INTO convenio (nome) VALUES ('Emgepron');
INSERT INTO convenio (nome) VALUES ('Saúde Itaú');
INSERT INTO convenio (nome) VALUES ('Postal Saúde');
INSERT INTO convenio (nome) VALUES ('Serviço Federal de Processamento de Dados(Serpro)');
INSERT INTO convenio (nome) VALUES ('GAMA Saúde');
INSERT INTO convenio (nome) VALUES ('CAC');
INSERT INTO convenio (nome) VALUES ('CEMERU');




