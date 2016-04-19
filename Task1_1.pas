Type TMatrix = array[1..3,1..3] of real;
Type TVector = array[1..3] of real;
Type
TLineEquation=class( Object )
Private
n : integer;
FMatrix : TMatrix;
FVector,
FDecision : TVector;
Protected
Function	GetDimension : integer; virtual;
begin

end;
Procedure	SetDimension( aDimension : integer ); virtual;
begin

end;
Public
Constructor	Create;
var i,j:integer;
begin
n:=3;
for i:=1 to n do
begin
  for j:=1 to n do
    FMatrix[i,j] := i+j;
  FVector[i] := i;
  FDecision[i] :=0;
end;
FMatrix[3,3] := 10;
end;
Destructor	Destroy; 
begin

end;
Procedure	Run; virtual;
var i,j,k:integer;
    h, tmp,mul:real;
begin
n := 3;
for k:=1 to 3 do
  writeln(FMatrix[k,1]:7,FMatrix[k,2]:7,FMatrix[k,3]:7);
writeln('====');
for i:=1 to n do
  begin
    write('i=',i,' original ',FVector[i], ' ');
    FVector[i] := FVector[i]/FMatrix[i,i];
    write(' mul = ', FMatrix[i,i], ' ');
    write('normalized ',FVector[i], ' ');
    for j:=n downto i do begin
      FMatrix[i,j] := FMatrix[i,j]/FMatrix[i,i];
      end;
    for k:=i+1 to n do begin
      FVector[k] := FVector[k] - FMatrix[k,i]*FVector[i];
      for j:=n downto 1 do begin
        FMatrix[k,j] := FMatrix[k,j] - FMatrix[k,i]*FMatrix[i,j];
      end;
    end;
    writeln('after sub ',FVector[i]);
    for k:=1 to n do begin
      for j:=1 to n do
        write (FMatrix[k,j]:4:2, ' ');
        writeln(FVector[k]:4:2);
    end
  end;
writeln('====');
for i:=n downto 1 do begin
  tmp := 0;
  for j:=n downto i+1 do begin
    tmp := tmp + FDecision[j]*FMatrix[i,j];
  end;
  FDecision[i] := FVector[i] - tmp;
end;

end;

Procedure	SaveToFile( const aFileName : string ); virtual;
begin

end;
Procedure	LoadFromFile( const aFileName : string ); virtual;
begin

end;
Property 	Matrix   : TMatrix read FMatrix;
Property 	Vector   : TVector read FVector;
Property 	Decision : TVector read FDecision;
Property	Dimension: Integer read GetDimension write SetDimension;
End;
var  solver : TLineEquation;
  i,j:integer;
BEGIN
writeln('T_T');
solver := new TLineEquation();
for i:=1 to 3 do
  writeln(solver.Matrix[i,1]:7:2,solver.Matrix[i,2]:7:2,solver.Matrix[i,3]:7:2 ,solver.Vector[i]:7:2);
solver.Run();
for i:=1 to 3 do
  writeln(solver.Matrix[i,1]:7:2,solver.Matrix[i,2]:7:2,solver.Matrix[i,3]:7:2 ,solver.Vector[i]:7:2, solver.Decision[i]:7:2);
END.