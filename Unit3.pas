unit Unit3;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.Menus;

type
  TForm3 = class(TForm)
    MainMenu1: TMainMenu;
    k1: TMenuItem;
    kYap1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure kYap1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
       uses Unit1,Unit2;

{$R *.dfm}



procedure TForm3.FormCreate(Sender: TObject);

begin
adoquery1.sql.Clear;
adoquery1.Close;
adoquery1.SQL.Add('select * from Personel where P_no = :persno AND Bol_kodu = :Bolum');
adoquery1.Parameters.ParamByName('persno').Value:=('1001');
adoquery1.Parameters.ParamByName('Bolum').Value:=('1');
adoquery1.Open;

      label3.Caption:=adoquery1.FieldByName('P_adi').AsString;
      label4.Caption:=adoquery1.FieldByName('P_soyadi').AsString;
      label7.Caption:=adoquery1.FieldByName('unvan').AsString;
      label8.Caption:=adoquery1.FieldByName('Bol_adi').AsString;
end;

procedure TForm3.kYap1Click(Sender: TObject);
begin
Application.Terminate()
end;

end.
