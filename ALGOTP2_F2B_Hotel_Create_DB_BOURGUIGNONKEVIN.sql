create schema HOTEL;


create table T_CHAMBRE (CHB_ID rowid not null,
						CHB_NUMERO int not null,
						CHB_ETAGE char(3) not null,
						CHB_BAIN int not null default 0,
						CHB_DOUCHE int not null default 0,
						CHB_WC int not null default 0,
						CHB_COUCHAGE int not null,
						CHB_POSTE_TEL char(3) not null,
					constraint PK_CHB primary key(CHB_ID));
					
create table T_TARIF (TRF_DATE_DEBUT date not null,
					  TRF_TAUX_TAXES real not null,
					  TRF_PETIT_DEJEUNE real not null,
					constraint PK_TRF primary key(TRF_DATE_DEBUT));
					
create table TJ_TRF_CHB (TRF_DATE_DEBUT date not null,
						 CHB_ID rowid not null,
					constraint PK_TRF_CHB primary key(TRF_DATE_DEBUT,CHB_ID),
					constraint FK_TRF foreign key (TRF_DATE_DEBUT) references T_TARIF(TRF_DATE_DEBUT)
					on delete cascade,
					constraint FK_CHB foreign key (CHB_ID) references T_CHAMBRE(CHB_ID)
					on delete cascade);
					
create table T_TITRE (TIT_CODE char(8) not null,
					  TIT_LIBELLE char(32) not null,
					constraint PK_TIT primary key (TIT_CODE));
					
create table T_CLIENT (CLI_ID rowid not null,
					   TIT_CODE char(8) not null,
					   CLI_NOM char(32) not null,
					   CLI_PRENOM char(25) not null,
					   CLI_ENSEIGNE char(100) not null,
					constraint PK_CLI primary key (CLI_ID),
					constraint FK_TIT foreign key (TIT_CODE) references T_TITRE(TIT_CODE)
					on delete cascade);
					
create table T_PLANNING (PLN_JOUR date not null,
						constraint PK_PLN primary key (PLN_JOUR));
						
create table TJ_CHB_PLN_CLI(CHB_ID rowid not null,
							PLN_JOUR date not null,
							CLI_ID rowid not null,
							CHB_PLN_CLI_NB_PERS int not null,
							CHB_PLN_CLI_RESERVE int not null default 0,
							CHB_PLN_CLI_OCCUPE int not null default 0,
						constraint PK_CHB_PLN_CLI primary key(CHB_ID,PLN_JOUR,CLI_ID)?
						constraint FK_CHB foreign key (CHB_ID) references T_CHAMBRE(CHB_ID)
						on delete cascade,
						constraint FK_PLN foreign key (PLN_JOUR) references T_PLANNING(PLN_JOUR)
						on delete cascade,
						constraint FK_CLI foreign key (CLI_ID) references T_CLIENT(CLI_ID)
						on delete cascade);
			
create table T_ADRESSE (ADR_ID rowid not null,
						CLI_ID rowid not null,
						ADR_LIGNE1 char(32) not null,
						ADR_LIGNE2 char(32) not null,
						ADR_LIGNE3 char(32) not null,
						ADR_LIGNE4 char(32) not null,
						ADR_CP char(5) not null,
						ADR_VILLE char(32) not null,
					constraint PK_ADR primary key (ADR_ID)?
					constraint FK_CLI foreign key (CLI_ID) references T_CLIENT(CLI_ID)
					on delete cascade);
					
