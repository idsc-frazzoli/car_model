%script for compiling mex file
clc
mex -I/home/jelavice/IDSC/car_model/cpp/include -I/usr/local/include/eigen3 threeStateModelMexWrapper.cpp /home/jelavice/IDSC/car_model/cpp/src/three_state_model.cpp