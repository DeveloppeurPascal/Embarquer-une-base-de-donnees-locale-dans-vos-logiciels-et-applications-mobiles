object DataModule2: TDataModule2
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 265
  Width = 384
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = FDConnection1AfterConnect
    BeforeConnect = FDConnection1BeforeConnect
    Left = 176
    Top = 16
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 56
    Top = 16
  end
  object FDScript1: TFDScript
    SQLScripts = <
      item
        Name = 'base'
        SQL.Strings = (
          'CREATE TABLE livresauteurs ('
          '  livre_id INTEGER NOT NULL,'
          '  auteur_id INTEGER NOT NULL,'
          '  CONSTRAINT par_livre_auteur PRIMARY KEY (livre_id,auteur_id),'
          
            '  CONSTRAINT auteurs_livresauteurs FOREIGN KEY (auteur_id) REFER' +
            'ENCES auteurs (id) ON DELETE RESTRICT ON UPDATE RESTRICT,'
          
            '  CONSTRAINT livres_livresauteurs FOREIGN KEY (livre_id) REFEREN' +
            'CES livres (id) ON DELETE RESTRICT ON UPDATE RESTRICT'
          ');'
          ''
          'CREATE TABLE auteurs ('
          '  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          '  nom TEXT NULL,'
          '  prenom TEXT NULL'
          ');'
          ''
          'CREATE TABLE livres ('
          '  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          '  titre TEXT NULL,'
          '  gencod CHAR(13) NULL'
          ');'
          ''
          'CREATE INDEX par_auteur_livre ON livresauteurs'
          '  (auteur_id,livre_id);')
      end
      item
        Name = 'mise '#224' jour 1'
        SQL.Strings = (
          'ALTER TABLE auteurs'
          '  ADD pseudo TEXT NULL;')
      end>
    Connection = FDConnection1
    Params = <>
    Macros = <>
    Left = 64
    Top = 88
  end
  object tabAuteurs: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'auteurs'
    TableName = 'auteurs'
    Left = 48
    Top = 144
  end
  object tabLivresAuteurs: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'livresauteurs'
    TableName = 'livresauteurs'
    Left = 128
    Top = 144
  end
  object tabLivres: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'livres'
    TableName = 'livres'
    Left = 208
    Top = 144
  end
end
