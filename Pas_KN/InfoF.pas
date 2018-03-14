unit InfoF;

interface

uses
  Forms, StdCtrls, ExtCtrls, ComCtrls, Classes, Graphics, Controls;

type
  TInfoForm = class(TForm)
    CodedByLabel        : TLabel;
    CoderImage          : TImage;
    InfoLabel           : TLabel;
    ProducedByLabel     : TLabel;
    ProducerImage       : TImage;
    ProduktnameLabel    : TLabel;
    ProduktversionLabel : TLabel;
    BeendenImage: TImage;

    procedure KeyBeenden(Sender: TObject; var Key: Char);
    procedure MausBeenden(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected - declaration }
  public
    { Public declarations }
  end;

var
  InfoForm : TInfoForm;

implementation

uses
 MainF;

{$R *.DFM}

procedure TInfoForm.KeyBeenden(Sender: TObject; var Key: Char);
begin
  Close;
end;

procedure TInfoForm.MausBeenden(Sender: TObject);
begin
  Close;
end;

end.

 
