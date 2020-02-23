unit uva;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TFrmva }

  TFrmva = class(TForm)
    Btnmdw: TButton;
    Btnguardar: TButton;
    Btnslc: TButton;
    Btnmup: TButton;
    Btnmlf: TButton;
    Btnmrt: TButton;
    ChckGrp: TCheckGroup;
    ColorDlg: TColorDialog;
    GBcontrol: TGroupBox;
    GrpBinfo: TGroupBox;
    GrpBmove: TGroupBox;
    GrpBcontrol: TGroupBox;
    Grpcolor: TGroupBox;
    Imgless: TImage;
    Lblfilename: TLabel;
    Lblihori: TLabel;
    Lblifile: TLabel;
    Lblvertical: TLabel;
    Lblivert: TLabel;
    Lblhorizontal: TLabel;
    ODlg: TOpenDialog;
    Piedra: TPanel;
    Papel: TPanel;
    Empate: TPanel;
    Tijeras: TPanel;
    Fondo: TPanel;
    Pnllink: TPanel;
    SvDlg: TSaveDialog;
    procedure BtnguardarClick(Sender: TObject);
    procedure BtnmdwClick(Sender: TObject);
    procedure BtnmlfClick(Sender: TObject);
    procedure BtnmrtClick(Sender: TObject);
    procedure BtnmupClick(Sender: TObject);
    procedure btnpiedraClick(Sender: TObject);
    procedure BtnslcClick(Sender: TObject);
    procedure BtnupClick(Sender: TObject);
    procedure ChckGrpClick(Sender: TObject);
    procedure ChckGrpItemClick(Sender: TObject; Index: integer);
    procedure FormCreate(Sender: TObject);
  private
    Archivo : TStringList;
    Arriba, Izquierda : integer;
  public

  end;

var
  Frmva: TFrmva;

implementation

{$R *.lfm}

{ TFrmva }

procedure TFrmva.btnpiedraClick(Sender: TObject);
begin
  if colordlg.Execute then
  begin
    TPanel(Sender).Color:=colordlg.Color;
    TPanel(Sender).Font.Color := clWhite - colordlg.Color;
  end;
  self.BtnupClick(Sender);
end;

procedure TFrmva.BtnmupClick(Sender: TObject);
begin
  ////////////////////////////////
  if Archivo.Count < 32 then
  begin
     exit;
  end;
  ////////////////////////////////
  if Arriba > 0 then
  begin
    Arriba := Arriba -8;
  end;
  self.BtnupClick(Sender);
end;

procedure TFrmva.BtnmdwClick(Sender: TObject);
begin
  ////////////////////////////////
  if Archivo.Count < 32 then
  begin
     exit;
  end;
  ////////////////////////////////
  if Arriba < Archivo.Count-64 then
  begin
     Arriba := Arriba +8;
  end;
  self.BtnupClick(Sender);
end;

procedure TFrmva.BtnguardarClick(Sender: TObject);
begin
  //
  ////////////////////////////////
  if Archivo.Count < 32 then
  begin
     exit;
  end;
  ////////////////////////////////
  if svdlg.Execute then
  begin
     Imgless.Picture.SaveToFile(svdlg.FileName);
  end;
end;

procedure TFrmva.BtnmlfClick(Sender: TObject);
begin
  ////////////////////////////////
  if Archivo.Count < 32 then
  begin
     exit;
  end;
  ////////////////////////////////
  Izquierda := Izquierda + 64;
  self.BtnupClick(Sender);
end;

procedure TFrmva.BtnmrtClick(Sender: TObject);
begin
  ////////////////////////////////
  if Archivo.Count < 32 then
  begin
     exit;
  end;
  ////////////////////////////////
  Izquierda := Izquierda -64;
  self.BtnupClick(Sender);
end;

procedure TFrmva.BtnslcClick(Sender: TObject);
begin
  if ODlg.Execute then
  begin
     Archivo.Clear;
     Archivo.LoadFromFile(ODlg.FileName);
     lblfilename.Caption:=ExtractFileName(ODlg.FileName);
     self.BtnupClick(Sender);
  end;
end;

procedure TFrmva.BtnupClick(Sender: TObject);
var
  w, h: Integer;
  cw,ch: Integer;
  cc, i : integer;
  limb,lima : integer;
  steps : integer;
  fila : unicodestring;
  valid : boolean;
begin
  ////////////////////////////////
  if Archivo.Count < 32 then
  begin
     exit;
  end;
  ////////////////////////////////
  Lblvertical.Caption:=IntTostr(Arriba);
  Lblhorizontal.Caption:=IntTostr(Izquierda);
  Imgless.Canvas.Clear;
  cw := Imgless.Width div 2;
  ch := 0;
  Imgless.Canvas.Brush.Color := fondo.Color;
  Imgless.Canvas.Brush.Style := bsSolid;
  Imgless.Canvas.Rectangle(0,0,Imgless.Width,Imgless.Height);
  limb := Arriba + 64;
  steps := Archivo.Count;
  if (steps-1) < limb then
  begin
     limb := steps-1;
  end;
  for h:= Arriba to limb  do
  begin
     fila := Archivo.Strings[h];
     cc := cw - ((length(fila) div 2) *8) + Izquierda;
     //////////////////////////////////
     for i := 1 to length(fila) do
     begin
       valid := (cc <  Imgless.Width) and (cc >= 0);
       if valid and (ch < Imgless.Height) then
       begin
          case fila[i] of
           // Piedra
           '1': begin
             //
              if ChckGrp.Checked[0] then
              begin
                Imgless.Canvas.Brush.Color := piedra.Color;
                Imgless.Canvas.Brush.Style := bsSolid;
                Imgless.Canvas.Rectangle(cc,ch,cc+8,ch+8);
              end;
           end;
           //Papel
           '2': begin
             //
              if ChckGrp.Checked[1] then
              begin
                Imgless.Canvas.Brush.Color := papel.Color;
                Imgless.Canvas.Brush.Style := bsSolid;
                Imgless.Canvas.Rectangle(cc,ch,cc+8,ch+8);
              end;
           end;
           //Tijera
           '3': begin
             //
              if ChckGrp.Checked[2] then
              begin
                Imgless.Canvas.Brush.Color := tijeras.Color;
                Imgless.Canvas.Brush.Style := bsSolid;
                Imgless.Canvas.Rectangle(cc,ch,cc+8,ch+8);
              end;
           end;
           //Empate
           '0': begin
             //
              if ChckGrp.Checked[3] then
              begin
                Imgless.Canvas.Brush.Color := empate.Color;
                Imgless.Canvas.Brush.Style := bsSolid;
                Imgless.Canvas.Rectangle(cc,ch,cc+8,ch+8);
              end;
           end;
          end;
       end;
       cc := cc + 8;
     end;
     ch := ch + 8;
  end;
end;

procedure TFrmva.ChckGrpClick(Sender: TObject);
begin

end;

procedure TFrmva.ChckGrpItemClick(Sender: TObject; Index: integer);
begin
  self.BtnupClick(Sender);
end;

procedure TFrmva.FormCreate(Sender: TObject);
begin
   Archivo := TStringList.Create;
   Arriba := 0;
   Izquierda := 0;
   Piedra.Font.Color := clWhite - Piedra.Color;
   Papel.Font.Color := clWhite - Papel.Color;
   Tijeras.Font.Color := clWhite - Tijeras.Color;
   Fondo.Font.Color := clWhite - Fondo.Color;
end;

end.

