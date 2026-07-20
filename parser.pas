program BlcParser;

{$mode objfpc}{$H+}

uses
    Classes, SysUtils, Crt;

type
    { TLexer }
    TLexer = class
    end;

function Term(var src: string; var i: integer): integer; forward;
function NextChar(var src: string; var i: integer): char; forward;

function Expression(var src: string; var i: integer): integer;
var
    v: integer;
    t: char;
begin
    v := Term(src, i);
    t := NextChar(src, i);
    while (t in ['+', '-']) do begin
        i := i + 1;
        if t = '+' then
            v := v + Term(src, i)
        else if t = '-' then
            v := v - Term(src, i);
        t := NextChar(src, i);
    end;
    Expression := v;
end;

function Term(var src: string; var i: integer): integer;
begin
    Result := 0;
    while (i <= Length(src)) and (src[i] in ['0'..'9']) do begin
        Result := Result * 10 + (Ord(src[i]) - Ord('0'));
        i := i + 1;
    end;
end;

function NextChar(var src: string; var i: integer): char;
begin
    if i <= Length(src) then
        Result := src[i]
    else
        Result := #0;
end;

var
    s: string;
    idx: integer;
    loopRead: boolean;

begin
    loopRead := true;

    while loopRead = true do
        begin
            ReadLn(s);
            idx := 1;
            WriteLn('Result: ', Expression(s, idx));
            ReadKey;
        end;
end.
