unit giris_panel;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, System.ImageList, Vcl.ImgList,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.WinXPickers;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    çıkış: TMenuItem;
    N1: TMenuItem;
    Yardm1: TMenuItem;
    ADOConnectiongiris: TADOConnection;
    ADOQuerygiris: TADOQuery;
    DataSourcegiris: TDataSource;
    Image1: TImage;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image2: TImage;
    Label2: TLabel;
    Label1: TLabel;
    Image3: TImage;
    Button2: TButton;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure çıkışClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Yardm1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);


  private
    { Private declarations }

  public
    { Public declarations }
    var temp:String;      //kullanıcı adı global değişken
    var temp5:String;
  end;

var Form1: TForm1;

implementation

{$R *.dfm}
  uses mainform,sorgu;   // diğer formları çağırmak için

  var temp2:String;   //şifrenin tutulduğu değişken
  var AppDir: string;

procedure TForm1.Button1Click(Sender: TObject);
begin


  temp:=trim(edit1.Text);
  temp2:=trim(edit2.Text);

//**********************************************************************
  //kullanici girişi için veritabanı bağlantısı
adoquerygiris.sql.Clear;
adoquerygiris.Close;
adoquerygiris.SQL.Add('select * from Personel where Kimlik = :Kimlik2 AND Sifre = :Sifre2');
adoquerygiris.Parameters.ParamByName('Kimlik2').Value:=(temp);
adoquerygiris.Parameters.ParamByName('Sifre2').Value:=(temp2);
adoquerygiris.Open;

//***********************************************************************
  //kullanici giriş kontrolü
 if((temp='') AND (temp2='')) Then
 begin
   ShowMessage('Yanlış Kullanıcı Adı veya Şifre!')
 end
 else if (temp=(adoquerygiris.FieldByName('Kimlik').AsString)) AND (temp2=(adoquerygiris.FieldByName('Sifre').AsString)) Then
  begin

  if Form1.Visible = True then Form2.Visible := True;
  Form1.Visible := False;

  adoquerygiris.sql.Clear;
  adoquerygiris.Close;
  adoquerygiris.SQL.Add('select * from Personel where Kimlik = :Kimlik2');
  adoquerygiris.Parameters.ParamByName('Kimlik2').Value:=(temp);
  adoquerygiris.Open;

  ShowMessage('Hosgeldin ' + adoquerygiris.FieldByName('Adi').AsString + ' ' + adoquerygiris.FieldByName('Soyadi').AsString);
  end
else
  begin
  ShowMessage('Yanlış Kullanıcı Adı veya Şifre!')
  end;
 //**************************************************************
    //otel sorgula
    Form2.adoquery1.sql.Clear;
    Form2.adoquery1.Close;
    Form2.adoquery1.SQL.Add('select * from Oteller');
    Form2.adoquery1.Open;

    // rezervasyon sorgula
    Form2.adoquery2.sql.Clear;
    Form2.adoquery2.Close;
    Form2.adoquery2.SQL.Add('select * from Rezervasyon');
    Form2.adoquery2.Open;

end;
//***************************************************
        //Sorgula butonuna basıldığı zaman
procedure TForm1.Button2Click(Sender: TObject);
begin
  if (ComboBox1.Text) <> ('Gitmek istediğiniz otel seçimini yapınız') then
  begin
  Form4.Show;
  Form4.Button1.Visible := False;

  Form4.adoqueryotel.sql.Clear;
  Form4.adoqueryotel.Close;
  Form4.adoqueryotel.SQL.Add('select * from Oteller where OtelAdi = :Kimlik3');
  Form4.adoqueryotel.Parameters.ParamByName('Kimlik3').Value:=trim(ComboBox1.Text);
  Form4.adoqueryotel.Open;

    Form4.OtelAdi.Caption:=Form4.adoqueryotel.FieldByName('OtelAdi').AsString;
    Form4.OdaTuru.Caption:=Form4.adoqueryotel.FieldByName('OdaTuru').AsString;
    Form4.YatakSayisi.Caption:=Form4.adoqueryotel.FieldByName('YatakSayisi').AsString;
    Form4.OnOdeme.Caption:=Form4.adoqueryotel.FieldByName('OnOdeme').AsString;
    Form4.Fiyat.Caption:=Form4.adoqueryotel.FieldByName('Fiyat').AsString;
    Form4.Puan.Caption:=Form4.adoqueryotel.FieldByName('Puan').AsString;
  end
  else
    ShowMessage('Lütfen otel seçimi yapınız.');
end;


//*******************************************************
        //Form oluştuğu zaman
procedure TForm1.FormCreate(Sender: TObject);
begin
    //veritabanı konumu farketmeksizin çalıştırmak için

  //Combobox içine Otel isimleri veritabanından ekleniyor
  adoquerygiris.sql.Clear;
  adoquerygiris.Close;
  adoquerygiris.SQL.Add('select OtelAdi from Oteller ');
  adoquerygiris.Open;

  adoquerygiris.First;
  while not adoquerygiris.Eof do
  begin
    ComboBox1.Items.Add(adoquerygiris['OtelAdi']);
    adoquerygiris.Next;
  end;
end;
//********************************************************
procedure TForm1.N1Click(Sender: TObject);
begin
Application.Terminate()
end;

procedure TForm1.Yardm1Click(Sender: TObject);
begin
ShowMessage('Gidiş dönüş tarihi belirtip ya da tarihiniz belirli değilse Tarihlerim daha kesinleşmedi kutucuğunu seçip Sorgulama yapabilirsiniz.')
end;

procedure TForm1.çıkışClick(Sender: TObject);
begin
Application.Terminate()           //çıkış butonunun çalışması için
end;

end.
