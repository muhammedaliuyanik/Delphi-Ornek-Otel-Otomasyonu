unit mainform;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Data.DB,
  Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.Mask, Vcl.DBCtrls, Vcl.WinXPickers;

type
  TForm2 = class(TForm)
    MainMenu1: TMainMenu;
    k1: TMenuItem;
    kYap1: TMenuItem;
    ADOConnection1: TADOConnection;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    Image1: TImage;
    Label11: TLabel;
    Label14: TLabel;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBGrid2: TDBGrid;
    Label9: TLabel;
    ADOQuery2: TADOQuery;
    DataSource2: TDataSource;
    ADOConnection2: TADOConnection;
    Label10: TLabel;
    Label12: TLabel;
    giristarihi: TDatePicker;
    cikistarihi: TDatePicker;
    lblgiristarihi: TLabel;
    lblcikistarihi: TLabel;
    Label16: TLabel;
    GroupBox3: TGroupBox;
    Label17: TLabel;
    Button2: TButton;
    GroupBox4: TGroupBox;
    lblmusteriadi: TLabel;
    lblmusterisoyadi: TLabel;
    lblodano: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    lbldurum: TLabel;
    Label24: TLabel;
    lblotelno: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    MusteriAdi: TEdit;
    MusteriSoyadi: TEdit;
    gcodano: TEdit;
    gcotelno: TEdit;
    MusteriNo: TEdit;
    ADOConnection3: TADOConnection;
    DataSource3: TDataSource;
    ADOQuery3: TADOQuery;
    BtnMusteriKayit: TButton;
    CheckBox1: TCheckBox;
    Btnmusterikayitsil: TButton;
    procedure kYap1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BtnMusteriKayitClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure BtnmusterikayitsilClick(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }

  end;

  var Form2: TForm2;

implementation

{$R *.dfm}

uses giris_panel,sorgu;   // diğer formları çağırmak için

   var cins:String;

  // Müşteri kaydet

procedure TForm2.BtnMusteriKayitClick(Sender: TObject);
begin

    adoquery3.Close;
    adoquery3.SQL.Clear;
    adoquery3.SQL.Add('INSERT INTO Rezervasyon(OtelNo, OdaNo, MusteriAdi, MusteriSoyadi, GidisTarih, DonusTarih, Durum)');
    adoquery3.SQL.Add('VALUES ("'+ gcotelno.Text +'", "'+ gcodano.Text +'", "'+ musteriadi.Text +'", "'+ musterisoyadi.Text +'", "'+ datetostr(giristarihi.Date) +'", "'+ datetostr(cikistarihi.Date) +'", 0)');
    adoquery3.ExecSQL;
    DBGrid2.Refresh;

    ShowMessage('Müşteri kaydı yapıldı.');

    Form2.adoquery2.sql.Clear;
    Form2.adoquery2.Close;
    Form2.adoquery2.SQL.Add('select * from Rezervasyon');
    Form2.adoquery2.Open;


end;

//*********************
  //Musteri kayıtsil
procedure TForm2.BtnmusterikayitsilClick(Sender: TObject);
begin

    adoquery3.Close;
    adoquery3.SQL.Clear;
    adoquery3.SQL.Add('UPDATE Rezervasyon SET Durum = "0"');
    adoquery3.SQL.Add('WHERE MusteriAdi = "'+ MusteriAdi.Text +'" And MusteriSoyadi = "'+ MusteriSoyadi.Text +'" And OdaNo = "'+ gcodano.Text +'"');
    adoquery3.ExecSQL;

    ShowMessage('Müşteri çıkışı yapıldı.');

    Form2.adoquery1.sql.Clear;
    Form2.adoquery1.Close;
    Form2.adoquery1.SQL.Add('select * from Oteller');
    Form2.adoquery1.Open;
end;
     // Musteri Bilgileri
procedure TForm2.Button2Click(Sender: TObject);
begin




  if MusteriNo.Text = '' then
    begin
      ShowMessage('Müşteri no alanı boş bırakılamaz !');
    end
  else
       begin
        adoquery3.sql.Clear;
        adoquery3.Close;
        adoquery3.SQL.Add('select * from Rezervasyon where MusteriNo = :MusteriNo2');
        adoquery3.Parameters.ParamByName('MusteriNo2').Value:=trim(MusteriNo.Text);
        adoquery3.Open;

       GroupBox4.Visible := True;
              lblmusteriadi.Caption := (adoquery3.FieldByName('MusteriAdi').AsString);
              lblmusterisoyadi.Caption := (adoquery3.FieldByName('MusteriSoyadi').AsString);
              lblotelno.Caption := (adoquery3.FieldByName('OtelNo').AsString);
              lblodano.Caption := (adoquery3.FieldByName('OdaNo').AsString);

              if (adoquery3.FieldByName('Durum').AsString) = '1' then
              begin
                lbldurum.Caption := 'DOLU';
              end
                else
                lbldurum.Caption := 'BOŞ';

       end;
end;

  //KAYITSIL ! checkbox kodları
procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.State = cbChecked then
  begin
    Btnmusterikayitsil.Visible := True;
    BtnMusteriKayit.Visible := False;
    lblgiristarihi.Visible := False;
    giristarihi.Visible := False;
    cikistarihi.Visible := True;
    lblcikistarihi.Visible := True;
  end
  else if CheckBox1.State = cbUnchecked Then
  begin
    Btnmusterikayitsil.Visible := False;
    BtnMusteriKayit.Visible := True;
    lblgiristarihi.Visible := True;
    giristarihi.Visible := True;
  end;
end;

//**********************

procedure TForm2.FormCreate(Sender: TObject);
begin
    cikistarihi.Visible := False;



 //Personel bilgileri için
adoquery1.sql.Clear;
adoquery1.Close;
adoquery1.SQL.Add('select * from Personel where Kimlik = :Kimlik3');
adoquery1.Parameters.ParamByName('Kimlik3').Value:=trim(Form1.temp);
adoquery1.Open;


     cins:=adoquery1.FieldByName('Unvan').AsString;
     if cins='1' then
     begin
       label2.Caption:='Yönetici';
       end
     else if cins='2' then
     begin
        label2.Caption:='Rezarvasyon Personeli';
     end;

     label7.Caption:=adoquery1.FieldByName('Adi').AsString;
     label8.Caption:=adoquery1.FieldByName('Soyadi').AsString;
end;
 //********************************
procedure TForm2.kYap1Click(Sender: TObject);
begin
Application.Terminate()
end;

end.
