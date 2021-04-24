%
% Stroemungsfelder linearer Differentialgleichungen
%
% (c) 2015 Prof Dr Andreas Mueller, Hochschule Rapperswil
% 2021-04-14, Roy Seitz, Copied for SeminarMatrizen
%
verbatimtex
\documentclass{book}
\usepackage{times}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsfonts}
\usepackage{txfonts}
\begin{document}
etex;

input TEX;

TEXPRE("%&latex" & char(10) &
"\documentclass{book}" &
"\usepackage{times}" &
"\usepackage{amsmath}" &
"\usepackage{amssymb}" &
"\usepackage{amsfonts}" &
"\usepackage{txfonts}" &
"\begin{document}");
TEXPOST("\end{document}");

%
% Vektorfeld in der Ebene mit Lösungskurve
% so(2)
%
beginfig(1)

% Scaling parameter
numeric unit;
unit := 150;

% Some points
z1 = (-1.5,    0) * unit;
z2 = ( 1.5,    0) * unit;
z3 = (   0, -1.5) * unit;
z4 = (   0,  1.5) * unit;

pickup pencircle scaled 1pt;
drawarrow (z1 shifted (-10,0))--(z2 shifted (10,0));
drawarrow (z3 shifted (0,-10))--(z4 shifted (0,10));
label.top(btex $x_1$ etex, z2 shifted (10,0));
label.rt(btex $x_2$ etex, z4 shifted (0,10));

% % Draw circles
% for x = 0.2 step 0.2 until 1.4:
%   path p;
%   p = (x,0);
%   for a = 5 step 5 until 355:
%     p := p--(x*cosd(a), x*sind(a));
%   endfor;
%   p := p--cycle;
%   pickup pencircle scaled 1pt;
%   draw p scaled unit withcolor red;
% endfor;

% Define DGL
def dglField(expr x, y) =
  %(-0.5 * (x + y), -0.5 * (y - x))
  (-y, x)
enddef;

pair A;
A := (1, 0);
draw A scaled unit withpen pencircle scaled 8bp withcolor red;

% Draw arrows for each grid point
pickup pencircle scaled 0.5pt;
for x = -1.5 step 0.1 until 1.55:
  for y = -1.5 step 0.1 until 1.55:
    drawarrow ((x, y) * unit)
      --(((x,y) * unit) shifted (8 * dglField(x,y)))
        withcolor blue;
  endfor;
endfor;

endfig;

%
% Vektorfeld in der Ebene mit Lösungskurve
% Euler(1)
%
beginfig(2)

numeric unit;
unit := 150;

z0 = (   0,    0);
z1 = (-1.5,    0) * unit;
z2 = ( 1.5,    0) * unit;
z3 = (   0, -1.5) * unit;
z4 = (   0,  1.5) * unit;

pickup pencircle scaled 1pt;
drawarrow (z1 shifted (-10,0))--(z2 shifted (10,0));
drawarrow (z3 shifted (0,-10))--(z4 shifted (0,10));
label.top(btex $x_1$ etex, z2 shifted (10,0));
label.rt(btex $x_2$ etex, z4 shifted (0,10));

def dglField(expr x, y) =
  (-y, x)
enddef;

def dglFieldp(expr z) =
  dglField(xpart z, ypart z)
enddef;

def curve(expr z, l, s) =
  path p;
  p := z;
  for t = 0 step 1 until l:
    p := p--((point (length p) of p) shifted (s * dglFieldp(point (length p) of p)));
  endfor;
  draw p scaled unit withcolor red;
enddef;

pair A;
A := (1, 0);
draw A scaled unit withpen pencircle scaled 8bp withcolor red;
curve(A, 0, 1);

% Draw arrows for each grid point
pickup pencircle scaled 0.5pt;
for x = -1.5 step 0.1 until 1.55:
  for y = -1.5 step 0.1 until 1.55:
    drawarrow ((x, y) * unit)
      --(((x,y) * unit) shifted (8 * dglField(x,y)))
        withcolor blue;
  endfor;
endfor;

endfig;

%
% Vektorfeld in der Ebene mit Lösungskurve
% Euler(2)
%
beginfig(3)

numeric unit;
unit := 150;

z0 = (   0,    0);
z1 = (-1.5,    0) * unit;
z2 = ( 1.5,    0) * unit;
z3 = (   0, -1.5) * unit;
z4 = (   0,  1.5) * unit;

pickup pencircle scaled 1pt;
drawarrow (z1 shifted (-10,0))--(z2 shifted (10,0));
drawarrow (z3 shifted (0,-10))--(z4 shifted (0,10));
label.top(btex $x_1$ etex, z2 shifted (10,0));
label.rt(btex $x_2$ etex, z4 shifted (0,10));

def dglField(expr x, y) =
  (-y, x)
enddef;

def dglFieldp(expr z) =
  dglField(xpart z, ypart z)
enddef;

def curve(expr z, l, s) =
  path p;
  p := z;
  for t = 0 step 1 until l:
    p := p--((point (length p) of p) shifted (s * dglFieldp(point (length p) of p)));
  endfor;
  draw p scaled unit withcolor red;
enddef;

pair A;
A := (1, 0);
draw A scaled unit withpen pencircle scaled 8bp withcolor red;
curve(A, 1, 0.5);

% Draw arrows for each grid point
pickup pencircle scaled 0.5pt;
for x = -1.5 step 0.1 until 1.55:
  for y = -1.5 step 0.1 until 1.55:
    drawarrow ((x, y) * unit)
      --(((x,y) * unit) shifted (8 * dglField(x,y)))
        withcolor blue;
  endfor;
endfor;

endfig;

%
% Vektorfeld in der Ebene mit Lösungskurve
% Euler(3)
%
beginfig(4)

numeric unit;
unit := 150;

z0 = (   0,    0);
z1 = (-1.5,    0) * unit;
z2 = ( 1.5,    0) * unit;
z3 = (   0, -1.5) * unit;
z4 = (   0,  1.5) * unit;

pickup pencircle scaled 1pt;
drawarrow (z1 shifted (-10,0))--(z2 shifted (10,0));
drawarrow (z3 shifted (0,-10))--(z4 shifted (0,10));
label.top(btex $x_1$ etex, z2 shifted (10,0));
label.rt(btex $x_2$ etex, z4 shifted (0,10));

def dglField(expr x, y) =
  (-y, x)
enddef;

def dglFieldp(expr z) =
  dglField(xpart z, ypart z)
enddef;

def curve(expr z, l, s) =
  path p;
  p := z;
  for t = 0 step 1 until l:
    p := p--((point (length p) of p) shifted (s * dglFieldp(point (length p) of p)));
  endfor;
  draw p scaled unit withcolor red;
enddef;

pair A;
A := (1, 0);
draw A scaled unit withpen pencircle scaled 8bp withcolor red;
curve(A, 3, 0.25);

% Draw arrows for each grid point
pickup pencircle scaled 0.5pt;
for x = -1.5 step 0.1 until 1.55:
  for y = -1.5 step 0.1 until 1.55:
    drawarrow ((x, y) * unit)
      --(((x,y) * unit) shifted (8 * dglField(x,y)))
        withcolor blue;
  endfor;
endfor;

endfig;

%
% Vektorfeld in der Ebene mit Lösungskurve
% Euler(4)
%
beginfig(5)

numeric unit;
unit := 150;

z0 = (   0,    0);
z1 = (-1.5,    0) * unit;
z2 = ( 1.5,    0) * unit;
z3 = (   0, -1.5) * unit;
z4 = (   0,  1.5) * unit;

pickup pencircle scaled 1pt;
drawarrow (z1 shifted (-10,0))--(z2 shifted (10,0));
drawarrow (z3 shifted (0,-10))--(z4 shifted (0,10));
label.top(btex $x_1$ etex, z2 shifted (10,0));
label.rt(btex $x_2$ etex, z4 shifted (0,10));

def dglField(expr x, y) =
  (-y, x)
enddef;

def dglFieldp(expr z) =
  dglField(xpart z, ypart z)
enddef;

def curve(expr z, l, s) =
  path p;
  p := z;
  for t = 0 step 1 until l:
    p := p--((point (length p) of p) shifted (s * dglFieldp(point (length p) of p)));
  endfor;
  draw p scaled unit withcolor red;
enddef;

pair A;
A := (1, 0);
draw A scaled unit withpen pencircle scaled 8bp withcolor red;
curve(A, 7, 0.125);

% Draw arrows for each grid point
pickup pencircle scaled 0.5pt;
for x = -1.5 step 0.1 until 1.55:
  for y = -1.5 step 0.1 until 1.55:
    drawarrow ((x, y) * unit)
      --(((x,y) * unit) shifted (8 * dglField(x,y)))
        withcolor blue;
  endfor;
endfor;

endfig;

%
% Vektorfeld in der Ebene mit Lösungskurve
% Euler(5)
%
beginfig(6)

numeric unit;
unit := 150;

z0 = (   0,    0);
z1 = (-1.5,    0) * unit;
z2 = ( 1.5,    0) * unit;
z3 = (   0, -1.5) * unit;
z4 = (   0,  1.5) * unit;

pickup pencircle scaled 1pt;
drawarrow (z1 shifted (-10,0))--(z2 shifted (10,0));
drawarrow (z3 shifted (0,-10))--(z4 shifted (0,10));
label.top(btex $x_1$ etex, z2 shifted (10,0));
label.rt(btex $x_2$ etex, z4 shifted (0,10));

def dglField(expr x, y) =
  (-y, x)
enddef;

def dglFieldp(expr z) =
  dglField(xpart z, ypart z)
enddef;

def curve(expr z, l, s) =
  path p;
  p := z;
  for t = 0 step 1 until l:
    p := p--((point (length p) of p) shifted (s * dglFieldp(point (length p) of p)));
  endfor;
  draw p scaled unit withcolor red;
enddef;

pair A;
A := (1, 0);
draw A scaled unit withpen pencircle scaled 8bp withcolor red;
curve(A, 99, 0.01);

% Draw arrows for each grid point
pickup pencircle scaled 0.5pt;
for x = -1.5 step 0.1 until 1.55:
  for y = -1.5 step 0.1 until 1.55:
    drawarrow ((x, y) * unit)
      --(((x,y) * unit) shifted (8 * dglField(x,y)))
        withcolor blue;
  endfor;
endfor;

endfig;


end;
