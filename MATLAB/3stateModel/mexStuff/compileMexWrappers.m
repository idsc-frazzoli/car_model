%script for compiling mex file
clc
clear all
cd ../../..
cppSourceDir = [pwd '/cpp'];
cd MATLAB
cd 3stateModel
cd mexStuff

includeDirs = ['-I' cppSourceDir '/include '];
includeDirs = [includeDirs '-I/usr/local/include/eigen3 '];
sourceFiles = [cppSourceDir '/src/mexes/threeStateModelMex.cpp '];
sourceFiles = [sourceFiles cppSourceDir '/src/three_state_model.cpp'];

% make sure you compile with g++ version <= 4.9
!g++ -v

eval (['mex -v ' includeDirs sourceFiles]);

