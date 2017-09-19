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
	//ThreeStateModel<3,1> threeStateModel;



	return 0;
}



