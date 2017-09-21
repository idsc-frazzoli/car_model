/*
 * test.cpp
 *
 *  Created on: Sep 19, 2017
 *      Author: jelavice
 */

#include <Eigen/Dense>
#include <iostream>
#include <random>
#include "three_state_model.h"

int main() {

    std::cout << "Testing Eigen shit now" << std::endl;
    srand(static_cast<unsigned int>(time(NULL))); //random generator for Eigen
    Eigen::Matrix<double, 2, 2> mat;
    mat = Eigen::Matrix<double,2,2>::Random();
    std::cout << mat << std::endl;

    std::cout << "Instantiating threeState model class now:" << std::endl;
    dynamics::ThreeStateModel threeStateModel;
    dynamics::ThreeStateModel::ptr_t modelDerivedPtr = dynamics::ThreeStateModel::ptr_t(new dynamics::ThreeStateModel());
    dynamics::ThreeStateModel::BASE::ptr_t modelBasePtr = dynamics::ThreeStateModel::BASE::ptr_t(new dynamics::ThreeStateModel());

    dynamics::ThreeStateModel::BASE::x_t x;
    dynamics::ThreeStateModel::BASE::u_t u;
    x << 0.3, -1, 5;
    u << -10 * M_PI / 180, 100;

    std::cout << threeStateModel.f(x, u).transpose() << std::endl;
    //std::cout << modelDerivedPtr->f(x, u).transpose() << std::endl;
    //std::cout << modelBasePtr->f(x, u).transpose() << std::endl;

    std::cout << "All good" << std::endl;

    return 0;
}

