unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BubbleSort();
    procedure binaereSuche(var links, rechts, zuSuchen : Integer);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  zahlen : Array[0..99] of Integer;  //array für zufallszahlen
  istGeordnet : boolean;
  istGefunden : boolean;
  gefunden : Integer;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var i : Integer;
begin
  randomize; //zufallsgenerator initialisieren
  for i:= 1 to 100 do//for-Schleife um jedem element des array einen wert zuzuweisen
  begin
    zahlen[i]:=random(100);
    ListBox1.Items.Add(IntToStr(zahlen[i]));//und auszugeben
  end;
  istGeordnet := false;
end;

procedure TForm1.Button2Click(Sender: TObject);
var i : Integer;
  grenzeLinks, grenzeRechts : integer;
  zuSuchen : Integer;
begin
 if istGeordnet = false then //prüfen, ob array geordnet ist
 begin //wenn nicht array ordnen
   ShowMessage('Die Datenmenge ist noch nicht geordnet. Das werden wir jetzt erledigen:');
   BubbleSort();
   ListBox1.Items.Clear;
   for i := 1 to 100 do
   begin//und geordnetes array ausgeben
   ListBox1.Items.Add(IntToStr(zahlen[i]));
   end;
 end;
 //zu suchenden wert einlesen
 zuSuchen := StrToInt(Edit1.Text);
 grenzeLinks := 1;   //standartwerte für die grenzen
 grenzeRechts := 100;
 binaereSuche(grenzeLinks, grenzeRechts, zuSuchen);//starten der binären suche
 if istGefunden then
 begin
   Label1.Caption:=ListBox1.Items.ValueFromIndex[gefunden-1] + ' an Position ' + IntTOStr(gefunden) + ' erfolgreich gefunden';
 end
 else
 Label1.Caption := 'Element wurde nicht gefunden';

end;


//bubble sort
procedure TForm1.BubbleSort();
var i, j, swap : Integer;
begin
 for j := 1 to 100 do
 begin
 for i := 1 to 99 do
 begin
   if zahlen[i] > zahlen[i+1] then
   begin
     swap := zahlen[i];
     zahlen[i] := zahlen[i+1];
     zahlen[i+1] := swap;
   end;
 end;
 end;
end;

procedure TForm1.binaereSuche(var links, rechts, zuSuchen : Integer);
var pivot : Integer;
begin
  pivot := (links+rechts) div 2;
  if zahlen[pivot] = zuSuchen then
  begin
  gefunden := pivot;
  istGefunden := true;
  end
  else
  if (zahlen[pivot] > zuSuchen) AND (links <= rechts)  then
  begin
    pivot := pivot-1;
    binaereSuche(links, pivot, zuSuchen);
  end
  else if (zahlen[pivot] < zuSuchen) AND (links <= rechts)  then
  begin
    pivot:=pivot+1;
    binaereSuche(pivot, rechts, zuSuchen);
  end
  else istGefunden := false;
end;

end.

