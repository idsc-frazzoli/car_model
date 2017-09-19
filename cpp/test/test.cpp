/*
 * test.cpp
 *
 *  Created on: Sep 19, 2017
 *      Author: jelavice
 */

#include <Eigen/Dense>
#include <iostream>
#include "three_state_model.h"

int main() {

    std::cout << "Instantiating Eigen shit now" << std::endl;

    Eigen::Matrix<double, 2, 2> mat;
    mat = Eigen::Matrix<double, 2, 2>::Random();
    std::cout << mat << std::endl;

    std::cout << "Instantiating threeState model class now:" << std::endl;
    car_dynamics::ThreeStateModel threeStateModel;
    car_dynamics::ThreeStateModel::ptr_t modelDerivedPtr = car_dynamics::ThreeStateModel::ptr_t(new car_dynamics::ThreeStateModel());
    car_dynamics::ThreeStateModel::BASE::ptr_t modelBasePtr = car_dynamics::ThreeStateModel::BASE::ptr_t(new car_dynamics::ThreeStateModel());

    car_dynamics::ThreeStateModel::BASE::x_t x;
    car_dynamics::ThreeStateModel::BASE::u_t u;
    x << 0.5, 0.2, 4;
    u << 10 * M_PI / 180, 1100;

    std::cout << threeStateModel.f(x, u).transpose() << std::endl;
    std::cout << modelDerivedPtr->f(x, u).transpose() << std::endl;
    std::cout << modelBasePtr->f(x, u).transpose() << std::endl;

    std::cout << "All good" << std::endl;

    return 0;
}

