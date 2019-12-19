unit Unit2;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Comp.Script, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDataModule2 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDScript1: TFDScript;
    tabAuteurs: TFDTable;
    tabLivresAuteurs: TFDTable;
    tabLivres: TFDTable;
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure FDConnection1AfterConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Déclarations privées }
    function dbname: string;
  public
    { Déclarations publiques }
  end;

var
  DataModule2: TDataModule2;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

uses System.IOUtils;

procedure TDataModule2.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.Connected := true;
end;

function TDataModule2.dbname: string;
var
  chemin: string;
begin
{$IFDEF DEBUG}
  chemin := TPath.Combine(TPath.GetDocumentsPath, 'Webinaire20191219.dat');
{$ELSE}
  chemin := TPath.Combine(TPath.GetHomePath, 'Webinaire20191219.dat');
{$ENDIF}
  if not TDirectory.Exists(chemin) then
    TDirectory.CreateDirectory(chemin);
  result := TPath.Combine(chemin, 'mabase');
end;

procedure TDataModule2.FDConnection1AfterConnect(Sender: TObject);
var
  version: integer;
  fichier: string;
  i: integer;
  majEffectuee: boolean;
begin
  fichier := dbname + '.dbv';
  if tfile.Exists(fichier) then
    version := tfile.ReadAllText(fichier).ToInteger
  else
    version := -1;
  majEffectuee := false;
  for i := version + 1 to FDScript1.SQLScripts.Count - 1 do
  begin
    if not majEffectuee then
      majEffectuee := true;
    FDScript1.ExecuteScript(FDScript1.SQLScripts[i].SQL);
    inc(version);
  end;
  if majEffectuee then
    tfile.writeAllText(fichier, version.ToString);
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TFDTable) then
      (Components[i] as TFDTable).Open;
end;

procedure TDataModule2.FDConnection1BeforeConnect(Sender: TObject);
begin
  FDConnection1.Params.Clear;
  FDConnection1.Params.AddPair('DriverID', 'SQLite');
  FDConnection1.Params.AddPair('Database', dbname + '.db');
end;

end.
