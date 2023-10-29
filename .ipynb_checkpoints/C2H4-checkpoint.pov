#include "colors.inc"
#include "finish.inc"

global_settings {assumed_gamma 1 max_trace_level 6}
background {color White transmit 1.0}
camera {orthographic
  right -3.02*x up 2.36*y
  direction 1.00*z
  location <0,0,50.00> look_at <0,0,0>}


light_source {<  2.00,   3.00,  40.00> color White
  area_light <0.70, 0, 0>, <0, 0.70, 0>, 3, 3
  adaptive 1 jitter}
// no fog
#declare simple = finish {phong 0.7}
#declare pale = finish {ambient 0.5 diffuse 0.85 roughness 0.001 specular 0.200 }
#declare intermediate = finish {ambient 0.3 diffuse 0.6 specular 0.1 roughness 0.04}
#declare vmd = finish {ambient 0.0 diffuse 0.65 phong 0.1 phong_size 40.0 specular 0.5 }
#declare jmol = finish {ambient 0.2 diffuse 0.6 specular 1 roughness 0.001 metallic}
#declare ase2 = finish {ambient 0.05 brilliance 3 diffuse 0.6 metallic specular 0.7 roughness 0.04 reflection 0.15}
#declare ase3 = finish {ambient 0.15 brilliance 2 diffuse 0.6 metallic specular 1.0 roughness 0.001 reflection 0.0}
#declare glass = finish {ambient 0.05 diffuse 0.3 specular 1.0 roughness 0.001}
#declare glass2 = finish {ambient 0.01 diffuse 0.3 specular 1.0 reflection 0.25 roughness 0.001}
#declare Rcell = 0.050;
#declare Rbond = 0.100;

#macro atom(LOC, R, COL, TRANS, FIN)
  sphere{LOC, R texture{pigment{color COL transmit TRANS} finish{FIN}}}
#end
#macro constrain(LOC, R, COL, TRANS FIN)
union{torus{R, Rcell rotate 45*z texture{pigment{color COL transmit TRANS} finish{FIN}}}
     torus{R, Rcell rotate -45*z texture{pigment{color COL transmit TRANS} finish{FIN}}}
     translate LOC}
#end

// no cell vertices
atom(<  0.67,   0.00,  -0.00>, 0.40, rgb <0.56, 0.56, 0.56>, 0.0, ase3) // #0
atom(< -0.67,   0.00,  -0.00>, 0.40, rgb <0.56, 0.56, 0.56>, 0.0, ase3) // #1
atom(<  1.24,   0.92,   0.00>, 0.20, rgb <1.00, 1.00, 1.00>, 0.0, ase3) // #2
atom(<  1.24,  -0.92,   0.00>, 0.20, rgb <1.00, 1.00, 1.00>, 0.0, ase3) // #3
atom(< -1.24,   0.92,  -0.00>, 0.20, rgb <1.00, 1.00, 1.00>, 0.0, ase3) // #4
atom(< -1.24,  -0.92,  -0.00>, 0.20, rgb <1.00, 1.00, 1.00>, 0.0, ase3) // #5
cylinder {<  0.67,  -0.12,  -0.00>, <  0.00,  -0.12,  -0.00>, Rbond texture{pigment {color rgb <0.56, 0.56, 0.56> transmit 0.0} finish{ase3}}}
cylinder {< -0.67,  -0.12,  -0.00>, <  0.00,  -0.12,  -0.00>, Rbond texture{pigment {color rgb <0.56, 0.56, 0.56> transmit 0.0} finish{ase3}}}
cylinder {<  0.67,   0.12,  -0.00>, <  0.00,   0.12,  -0.00>, Rbond texture{pigment {color rgb <0.56, 0.56, 0.56> transmit 0.0} finish{ase3}}}
cylinder {< -0.67,   0.12,  -0.00>, <  0.00,   0.12,  -0.00>, Rbond texture{pigment {color rgb <0.56, 0.56, 0.56> transmit 0.0} finish{ase3}}}
cylinder {<  0.67,   0.00,  -0.00>, <  0.95,   0.46,  -0.00>, Rbond texture{pigment {color rgb <0.56, 0.56, 0.56> transmit 0.0} finish{ase3}}}
cylinder {<  1.24,   0.92,   0.00>, <  0.95,   0.46,  -0.00>, Rbond texture{pigment {color rgb <1.00, 1.00, 1.00> transmit 0.0} finish{ase3}}}
cylinder {<  0.67,   0.00,  -0.00>, <  0.95,  -0.46,  -0.00>, Rbond texture{pigment {color rgb <0.56, 0.56, 0.56> transmit 0.0} finish{ase3}}}
cylinder {<  1.24,  -0.92,   0.00>, <  0.95,  -0.46,  -0.00>, Rbond texture{pigment {color rgb <1.00, 1.00, 1.00> transmit 0.0} finish{ase3}}}
cylinder {< -0.67,   0.00,  -0.00>, < -0.95,   0.46,  -0.00>, Rbond texture{pigment {color rgb <0.56, 0.56, 0.56> transmit 0.0} finish{ase3}}}
cylinder {< -1.24,   0.92,  -0.00>, < -0.95,   0.46,  -0.00>, Rbond texture{pigment {color rgb <1.00, 1.00, 1.00> transmit 0.0} finish{ase3}}}
cylinder {< -0.67,   0.00,  -0.00>, < -0.95,  -0.46,  -0.00>, Rbond texture{pigment {color rgb <0.56, 0.56, 0.56> transmit 0.0} finish{ase3}}}
cylinder {< -1.24,  -0.92,  -0.00>, < -0.95,  -0.46,  -0.00>, Rbond texture{pigment {color rgb <1.00, 1.00, 1.00> transmit 0.0} finish{ase3}}}
// no constraints
