/* jenner-check autoexec: cap rows + recreate ma505.outplant from a balanced
   sample of Datasets/mock_outplanting_data.csv (16 per species across both
   sampling dates), inlined so the lesson's ma505.outplant reference resolves
   with no external files. */
options obs=100;
libname ma505 ".";

data ma505.outplant;
    length id $ 4;
    length Date $ 7;
    length Species $ 20;
    infile datalines dsd missover;
    input id $ Date $ Species $ Height;
datalines;
Ix1,2020-04,Ixora triantha,18.24837174
Ix2,2020-04,Ixora triantha,20.14564036
Ix3,2020-04,Ixora triantha,10.16109386
Ix4,2020-04,Ixora triantha,13.85884683
Ix5,2020-04,Ixora triantha,18.88063785
Ix6,2020-04,Ixora triantha,23.44881818
Ix7,2020-04,Ixora triantha,19.46324873
Ix8,2020-04,Ixora triantha,15.05734182
Pa1,2020-04,Pandanus tectorius,40.35601109
Pa2,2020-04,Pandanus tectorius,31.48095835
Pa3,2020-04,Pandanus tectorius,32.39973446
Pa4,2020-04,Pandanus tectorius,37.67098553
Pa5,2020-04,Pandanus tectorius,21.55711269
Pa6,2020-04,Pandanus tectorius,29.70387337
Pa7,2020-04,Pandanus tectorius,33.79435586
Pa8,2020-04,Pandanus tectorius,49.57205389
Pr1,2020-04,Premna serratifolia,28.24514657
Pr2,2020-04,Premna serratifolia,38.78475025
Pr3,2020-04,Premna serratifolia,38.93653151
Pr4,2020-04,Premna serratifolia,11.99619644
Pr5,2020-04,Premna serratifolia,29.36127213
Pr6,2020-04,Premna serratifolia,27.42668469
Pr7,2020-04,Premna serratifolia,41.39902442
Pr8,2020-04,Premna serratifolia,32.19323074
Ix1,2021-09,Ixora triantha,40.02379794
Ix2,2021-09,Ixora triantha,34.75511152
Ix3,2021-09,Ixora triantha,29.79800844
Ix4,2021-09,Ixora triantha,45.77133235
Ix5,2021-09,Ixora triantha,47.42620297
Ix6,2021-09,Ixora triantha,-11.23167047
Ix7,2021-09,Ixora triantha,35.4988227
Ix8,2021-09,Ixora triantha,27.1836848
Pa1,2021-09,Pandanus tectorius,93.36954569
Pa2,2021-09,Pandanus tectorius,149.4295045
Pa3,2021-09,Pandanus tectorius,120.5091739
Pa4,2021-09,Pandanus tectorius,117.7162177
Pa5,2021-09,Pandanus tectorius,32.1855191
Pa6,2021-09,Pandanus tectorius,152.1192682
Pa7,2021-09,Pandanus tectorius,145.7983917
Pa8,2021-09,Pandanus tectorius,47.75845987
Pr1,2021-09,Premna serratifolia,124.5352375
Pr2,2021-09,Premna serratifolia,119.5180514
Pr3,2021-09,Premna serratifolia,71.9736944
Pr4,2021-09,Premna serratifolia,118.4032411
Pr5,2021-09,Premna serratifolia,67.97971264
Pr6,2021-09,Premna serratifolia,156.8118869
Pr7,2021-09,Premna serratifolia,79.69565694
Pr8,2021-09,Premna serratifolia,154.8774597
;
run;
