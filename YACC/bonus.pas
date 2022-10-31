program test;
var 
  i, j: integer;
begin
    i := 2;
    j := 5;

    (*if-then-else*)
    if (i > j) then
        Write('then')
    else Write('else');

    (*if-then-"if-then-else"-else*)
    if (i > j) then
        if (i > j) then
            Write('nest then')
        else Write('nest else')
    else Write('else');

    (*if-then-"if-then"-else*)
    if (i > j) then
        if (i > j) then
            Write('nest then')
    else Write('nest else');
    
    (*if-then-"if-then-else"*)
    if (i > j) then
        if (i > j) then
            Write('nest then')
        else Write('nest else');

end.
