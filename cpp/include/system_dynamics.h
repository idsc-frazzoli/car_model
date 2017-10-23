/*
 * car_dynamics.h
 *
 *  Created on: Sep 19, 2017
 *      Author: jelavice
 */

#ifndef SYSTEM_DYNAMICS_H_
#define SYSTEM_DYNAMICS_H_

#include <Eigen/Dense>
#include <memory>

namespace dynamics {

template<int STATE_DIM, int INPUT_DIM>
class SystemDynamics {

public:

    typedef Eigen::Matrix<double, STATE_DIM, 1> x_t;	//state
    typedef Eigen::Matrix<double, INPUT_DIM, 1> u_t;	//controls
    static const int m_xDim = STATE_DIM;
    static const int m_uDim = INPUT_DIM;

    virtual x_t f(const x_t& _x, const u_t& _u) = 0;
    virtual ~SystemDynamics() {
    }
};

} /*dynamics*/

#endif /* SYSTEM_DYNAMICS_H_ */
