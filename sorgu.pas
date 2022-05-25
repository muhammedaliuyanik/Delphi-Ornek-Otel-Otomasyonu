unit sorgu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    MainMenu1: TMainMenu;
    k1: TMenuItem;
    kYap1: TMenuItem;
    Image1: TImage;
    ADOConnectionotel: TADOConnection;
    DataSourceotel: TDataSource;
    ADOQueryotel: TADOQuery;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label3: TLabel;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    OtelAdi: TLabel;
    OdaTuru: TLabel;
    YatakSayisi: TLabel;
    Puan: TLabel;
    Label5: TLabel;
    Fiyat: TLabel;
    OnOdeme: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    Image2: TImage;
    procedure kYap1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}
uses giris_panel,mainform;        // diğer formları çağırmak için

procedure TForm4.Button1Click(Sender: TObject);
begin
//*****************
//Sorgula butonu
    adoqueryotel.sql.Clear;
    adoqueryotel.Close;
    adoqueryotel.SQL.Add('select * from Oteller where OtelAdi = :ctemp5');
    adoqueryotel.Parameters.ParamByName('ctemp5').Value:=(ComboBox1.Text);
    adoqueryotel.Open;

    OtelAdi.Caption:=adoqueryotel.FieldByName('OtelAdi').AsString;
    OdaTuru.Caption:=adoqueryotel.FieldByName('OdaTuru').AsString;
    YatakSayisi.Caption:=adoqueryotel.FieldByName('YatakSayisi').AsString;
    OnOdeme.Caption:=adoqueryotel.FieldByName('OnOdeme').AsString;
    Fiyat.Caption:=adoqueryotel.FieldByName('Fiyat').AsString;
    Puan.Caption:=adoqueryotel.FieldByName('Puan').AsString;
 //****************
end;

procedure TForm4.CheckBox1Click(Sender: TObject);
begin
//******************************
//GroupBox içindeki veriler
if CheckBox1.Checked then
begin
  adoqueryotel.sql.Clear;
  adoqueryotel.Close;
  adoqueryotel.SQL.Add('select OtelAdi from Oteller ');
  adoqueryotel.Open;

  adoqueryotel.First;
  while not adoqueryotel.Eof do
  begin
  ComboBox1.Items.Add(adoqueryotel['OtelAdi']);
    adoqueryotel.Next;
  end;
  GroupBox1.Visible := True;
  Button1.Visible := True;
//**********************************
end;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
    Form4.Refresh;
end;

procedure TForm4.kYap1Click(Sender: TObject);
begin
Application.Terminate()
end;

end.
