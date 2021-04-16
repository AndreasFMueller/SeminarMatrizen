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

% Draw circles
for x = 0.2 step 0.2 until 1.4:
  path p;
  p = (x,0);
  for a = 5 step 5 until 355:
    p := p--(x*cosd(a), x*sind(a));
  endfor;
  p := p--cycle;
  pickup pencircle scaled 1pt;
  draw p scaled unit withcolor red;
endfor;

% Define DGL
def dglField(expr x, y) =
  %(-0.5 * (x + y), -0.5 * (y - x))
  (-y, x)
enddef;

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
% X \in sl(2, R)
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

% Draw flow lines
for y = -1.4 step 0.2 until 1.4:
  path p;
  p = (-1.5,y) -- (1.5, y);
  pickup pencircle scaled 1pt;
  draw p scaled unit withcolor red;
endfor;

def dglField(expr x, y) =
  (y, 0)
enddef;

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
% Y \in sl(2, R)
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

% Draw flow lines
for x = -1.4 step 0.2 until 1.4:
  path p;
  p = (x, -1.5) -- (x, 1.5);
  pickup pencircle scaled 1pt;
  draw p scaled unit withcolor red;
endfor;

def dglField(expr x, y) =
  (0, x)
enddef;

% def dglFieldp(expr z) =
%   dglField(xpart z, ypart z)
% enddef;
% 
% def curve(expr z, l) =
%   path p;
%   p := z;
%   for t = 0 step 1 until l:
%     p := p--((point (length p) of p) shifted (0.01 * dglFieldp(point (length p) of p)));
%   endfor;
%   draw p scaled unit withcolor red;
% enddef;
%
% numeric outerlength;
% outerlength = 200;
% curve(( 0.1, 0), outerlength);
% curve(( 0.2, 0), outerlength);
%
% numeric innerlength;
% innerlength = 500;
% 
% for a = 0 step 30 until 330:
%   curve(0.05 * (cosd(a), sind(a)), innerlength);
% endfor;

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
% H \in sl(2, R)
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
drawarrow (z1 shifted (-25,0))--(z2 shifted (25,0));
drawarrow (z3 shifted (0,-10))--(z4 shifted (0,10));
label.top(btex $x_1$ etex, z2 shifted (25,0));
label.rt(btex $x_2$ etex, z4 shifted (0,10));

def dglField(expr x, y) =
  (x, -y)
enddef;

def dglFieldp(expr z) =
  dglField(xpart z, ypart z)
enddef;

def curve(expr z, l) =
  path p;
  p := z;
  for t = 0 step 1 until l:
    p := p--((point (length p) of p) shifted (0.01 * dglFieldp(point (length p) of p)));
  endfor;
  draw p scaled unit withcolor red;
enddef;

for i = -1 step 2 until 1:
  for k = -1 step 2 until 1:
    curve((1.3 * i,  1.5 * k), 18);
    curve((1.1 * i,  1.5 * k), 35);
    curve((0.9 * i,  1.5 * k), 55);
    curve((0.7 * i,  1.5 * k), 80);
    curve((0.5 * i,  1.5 * k), 114);
    curve((0.3 * i,  1.5 * k), 165);
    curve((0.1 * i,  1.5 * k), 275);
  endfor;
endfor;

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
