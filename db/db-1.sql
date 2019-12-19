CREATE TABLE livresauteurs (
  livre_id INTEGER NOT NULL,
  auteur_id INTEGER NOT NULL,
  CONSTRAINT par_livre_auteur PRIMARY KEY (livre_id,auteur_id),
  CONSTRAINT auteurs_livresauteurs FOREIGN KEY (auteur_id) REFERENCES auteurs (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT livres_livresauteurs FOREIGN KEY (livre_id) REFERENCES livres (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE auteurs (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  nom TEXT NULL,
  prenom TEXT NULL
);

CREATE TABLE livres (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  titre TEXT NULL,
  gencod CHAR(13) NULL
);

CREATE INDEX par_auteur_livre ON livresauteurs
  (auteur_id,livre_id);
