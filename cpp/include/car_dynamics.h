/*
 * car_dynamics.h
 *
 *  Created on: Sep 19, 2017
 *      Author: jelavice
 */

#ifndef CAR_DYNAMICS_H_
#define CAR_DYNAMICS_H_

#include <Eigen/Dense>
#include <memory>

namespace car_dynamics {

template<int STATE_DIM, int INPUT_DIM>
class CarDynamics {

public:
    typedef Eigen::Matrix<double, STATE_DIM, 1> x_t;	//state
    typedef Eigen::Matrix<double, INPUT_DIM, 1> u_t;	//controls
    typedef std::unique_ptr<CarDynamics<STATE_DIM, INPUT_DIM> > ptr_t;

    virtual x_t f(const x_t& _x, const u_t& _u) = 0;
    virtual ~CarDynamics() {
    }

protected:

    x_t x_;
};

} /* car_dynamics*/

#endif /* CPP_INCLUDE_CAR_DYNAMICS_H_ */
