unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Math, jpeg, Buttons;

const  // Constante HelpText : le texte d'aide du programme ^^
  HelpText='Ce programme vous permettra d''approximer Pi graçe à une méthode statistique dite de "rapport d''aire".'
  + chr(13)
  + 'Cette technique consiste à établir un rapport entre l''aire d''un carré, l''aire d''un cercle (ou un quadrant de cercle) et la distribution aléatoire de points dans le carré et le quadrant superposés.'
  + chr(13)
  + 'En effet, la formule de l''aire du cercle étant RPi² (ici R vaudra toujours pour plus de convénience) - ou celle du quadrant Pi/4, et celle du carré C² (soit 1), on obtient un rapport Pi/1 ou Pi/4/1.'
  + 'Si l''on considère que les points aléatoires répartis sur le cercle et le carré reflètent l''aire du carré et du cercle, on peut obtenir un rapport : Points dans le cercle/Points totaux = Pi/4, donc Points dans le cercle/Points totaux *4 = Pi.'
  + 'On peut donc approximer Pi statistiquement. Notez que si l''on définissait un Offset (un nombre de points totaux) égal à plus l''infini, statistiquement' + ', chaque aire serait totalement remplie de points, et par conséquent, on obtiendrait la valeur exacte de Pi.'
  + chr(13)
  + chr(13)
  + 'Définissez un nombre de points (noté Offset) pour approximer Pi - un nombre compris entre 1000 et 50000 sera adapté, car moins de 1000 points donnent une approximation imprécise' + ' de Pi, et plus de 50000 points rendent le calcul trop long. Gardez cependant en mémoire qu''il est possible d''obtenir la valeur exacte de Pi à partir de 500 points.'
  + 'Choisissez si vous désirez travailler sur un cercle ou un quadrant, puis choisissez si vous voulez voir des gros points ou ' + 'des petits points (les petits points sont plus rapidement dessinés que les gros points), et enfin choisissez si vous voulez voir les points apparaître l''un après l''autre (attention : cela ralentit le processus considérablement).'
  + 'Cliquez sur Calculer Pi (notez que vous pouvez cliquer sur Quitter à tout moment et interrompre' + ' le calcul). Une fois Pi calculé, le résultat s''affiche en vert si il est très proche de Pi, sinon il reste en blanc. Il peut être nécessaire de réessayer deux ou trois fois pour obtenir une valeur de Pi précise.'
  + 'La boîte d''informations située à l''extrême bas du panneau de contrôle vous informe à tout moment sur l''opération en cours.';

type
  TMainForm = class(TForm)
    DrawPanel: TPanel;
    Img: TImage;
    ControlPanel: TPanel;
    TitleLabel: TLabel;
    HeaderLabel: TLabel;
    StatBox: TGroupBox;
    OffsetLbl: TLabel;
    OffsetValue: TSpinEdit;
    RealtimeCheck: TCheckBox;
    ResultBox: TGroupBox;
    Res_NbLbl: TLabel;
    Res_TickLbl: TLabel;
    Res_PiLbl: TLabel;
    ResEdit: TEdit;
    GoBtn: TButton;
    QuitBtn: TButton;
    OperBox: TGroupBox;
    OperLbl: TLabel;
    ExactPi: TLabel;
    Panel1: TPanel;
    Image1: TImage;
    UseCircle: TRadioButton;
    UseArc: TRadioButton;
    BigPointsBox: TCheckBox;
    HelpBtn: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure QuitBtnClick(Sender: TObject);
    procedure GoBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure CleanImg;
    procedure DrawArc;
    procedure DrawCircle;
    function DrawPt(X, Y: Integer): Boolean; // Dessine le point, et renvoie True si dans le quadrant ou le cercle
    procedure DrawPoints;
    function ProcessPi: Single;
  end;

var
  MainForm: TMainForm;
  EndApp: Boolean; // Si il veut quitter l'application
  NbPoints, NbIn: Integer;  // Nombre de points totaux puis le nombre de points dans le quadrant
  Realtime, BigPoints: Boolean;  // Si le dessin se fait en temps réel

implementation

{$R *.dfm}

function DistanceOf(A, B: TPoint): Single; // Distance entre deux points
Var
 MX, MY: Integer;
begin
 MX := (A.X - B.X);
 MY := (A.Y - B.Y);
 Result := Sqrt(MX*MX + MY*MY);
 // Sqr() est moins rapide qu'une pure multiplication
 // On stocke MX et MY en mémoire car on les utilise 2 fois
end;

function InRange(Radius: Integer; Center, APoint: TPoint): Boolean; // Si un point APoint est dans un cercle de rayon Radius et de centre Center
begin
 Result := (DistanceOf(APoint, Center) <= Radius);
 // Si la distance du point au centre du cercle est inférieure au rayon ...
 // ... alors il est dans le cercle (j'espère du moins ...)
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 EndApp := False;
 Randseed := GetTickCount;
 DoubleBuffered := True;
 ControlPanel.DoubleBuffered := True;
 ResultBox.DoubleBuffered := True;
 StatBox.DoubleBuffered := True;
 DrawPanel.DoubleBuffered := True;
 ExactPi.Caption := 'Pi exact : ' + FloatToStr(Pi);
end;

procedure TMainForm.QuitBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.GoBtnClick(Sender: TObject);
Var
 S, E: Integer;
 Res: Double;
begin
 if (RealTimeCheck.Checked) and (OffsetValue.Value > 2500) then
  if MessageDlg('Le dessin en temps réel risque d''être long avec plus de 2500 points. Continuer ?', mtWarning, [mbYes, mbNo], 0) = mrNo then Exit;


 S := GetTickCount;
 NbIn := 0;
 NbPoints := OffsetValue.Value;
 RealTime := RealTimeCheck.Checked;
 BigPoints := BigPointsBox.Checked;
 OperLbl.Caption := 'Effaçage du dessin précédent';
 Application.ProcessMessages;
 CleanImg;
 case UseArc.Checked of
 False:
  begin
   OperLbl.Caption := 'Dessin du cercle';
   Application.ProcessMessages;
   DrawCircle;
  end;
 True:
  begin
   OperLbl.Caption := 'Dessin du quadrant de cercle';
   Application.ProcessMessages;
   DrawArc;
  end;
 end;
 OperLbl.Caption := 'Dessin des points';
 Application.ProcessMessages;
 DrawPoints;
 OperLbl.Caption := 'Calcul approximatif de Pi';
 Application.ProcessMessages;
 Res := ProcessPi;
 E := GetTickCount;
 Res_NbLbl.Caption := 'Avec ' + IntToStr(NbPoints) + ' points ...';
 Res_TickLbl.Caption := '... en ' + IntToStr(E - S) + ' millisecondes !';
 OperLbl.Caption := 'Fin du calcul - Prêt !';
 ResEdit.Text := FloatToStr(Res);

 if Abs(Pi - Res) < 0.01 then ResEdit.Color := clGreen else ResEdit.Color := clWhite;

end;

procedure TMainForm.CleanImg;
begin
 BitBlt(Img.Canvas.Handle, 0, 0, 401, 401, Img.Canvas.Handle, 0, 0, WHITENESS);
end;

procedure TMainForm.DrawArc;
Var
 R: TRect;
begin
 R.TopLeft := Point(-400, 0);
 R.BottomRight := Point(400, 800);
 Img.Canvas.Brush.Color := clWhite;
 Img.Canvas.Pen.Color := clBlack;
 Img.Canvas.Ellipse(R);
end;

procedure TMainForm.DrawCircle;
begin
 Img.Canvas.Brush.Color := clWhite;
 Img.Canvas.Pen.Color := clBlack;
 Img.Canvas.Ellipse(Img.ClientRect);
end;

function TMainForm.DrawPt(X, Y: Integer): Boolean;
Var
 Range: Integer;
 Center: TPoint;
begin
 case UseArc.Checked of
  False:
   begin
    Range := 200;
    Center := Point(200, 200);
   end;
  True:
   begin
    Range := 400;
    Center := Point(0, 400);
   end;
 end;

 Result := InRange(Range, Center, Point(X, Y));

 case BigPoints of
  False:
   case Result of
     False: Img.Canvas.Pixels[X, Y] := clBlack;
     True: Img.Canvas.Pixels[X, Y] := clRed;
    end;
  True:
   begin
    case Result of
     False: Img.Canvas.Pen.Color := clBlack;
     True: Img.Canvas.Pen.Color := clRed;
    end;
    Img.Canvas.Brush.Color := Img.Canvas.Pen.Color;
    Img.Canvas.Ellipse(X - 2, Y - 2, X + 2, Y + 2);
   end;
 end;
end;

procedure TMainForm.DrawPoints;
Var
 I: Integer;
begin
 for I := 1 to NbPoints do
  begin
   if EndApp then break;
   if RealTime then Application.ProcessMessages;
   if DrawPt(random(401), random(401)) then asm INC NbIn end; // Utilisation de l'asm pour aller encore plus vite :)
  end;
end;

function TMainForm.ProcessPi: Single;
begin
 Result := (NbIn/NbPoints)*4;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 EndApp := True;
end;

procedure TMainForm.HelpBtnClick(Sender: TObject);
begin
 MessageDlg(HelpText, mtInformation, [mbOK], 0);
end;

end.

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//////  RAISONNEMENT POUR TROUVER UNE VALEUR APPROXIMATIVE DE PI  //////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

{On utilise ici la statistique : on peut concevoir que la totalité des points
représente ici l'aire du carré, et que les points dans le quadrant représentent
l'aire du quadrant - or on sait que l'aire d'un quadrant est celle d'un cercle
divisée par 4 - soit Pi/4. Si on considère que le carré a une aire de 1 (soit
des dimensions de 1x1). On peut donc en déduire que le rapport :

Points dans le quadrant                                L'aire du quadrant
_______________________  équivaut statistiquement à    __________________

     Points totaux                                      L'aire du carré


Comme l'aire du quadrant est égale à Pi/4, et que l'aire du carré est égale à 1
comme dit plus haut, alors :

Points dans le quadrant
_______________________    = Pi/4

     Points totaux



On a juste a effectuer la division des points dans le quadrant sur les points totaux
(notons le résultat R), on obtient alors :

R = Pi/4

Donc, 4R = Pi

Si l'on résume :

Points dans le quadrant
_______________________ x 4 = Pi

     Points totaux

Bien sûr ce ne sont que des statistiques : donc plus le nombre de points totaux (Offset)
est élevé, plus la statistique est précise.

}
