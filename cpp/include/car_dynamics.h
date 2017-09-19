/*
 * car_dynamics.h
 *
 *  Created on: Sep 19, 2017
 *      Author: jelavice
 */

#ifndef CAR_DYNAMICS_H_
#define CAR_DYNAMICS_H_

#include <Eigen/Dense>



template<int STATE_DIM, int INPUT_DIM>
class CarDynamics {

public:
	typedef Eigen::Matrix<double, STATE_DIM, 1> 	x_t;	//state
	typedef x_t										dx_t;	//state derivative
	typedef Eigen::Matrix<double, INPUT_DIM, 1> 	u_t;	//controls

	virtual dx_t& f(x_t& _x, u_t& _u) = 0;

	virtual ~CarDynamics(){}

protected:

	u_t u_;
	x_t x_;
	dx_t dx_;
};



#endif /* CPP_INCLUDE_CAR_DYNAMICS_H_ */
