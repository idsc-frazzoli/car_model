/*
 * kinematic_model.cpp
 *
 *  Created on: Sep 28, 2017
 *      Author: jelavice
 */


#include "kinematic_model.h"


namespace dynamics {

using BASE = KinematicModel::BASE;

BASE::x_t KinematicModel::f(const BASE::x_t& x, const BASE::u_t& u){

    BASE::x_t dx;

    double delta = u(0), v = u(1); //inputs
    double theta = x(2);

    dx(0) =  v * cos(theta);
    dx(2) = v * sin(theta);
    dx(3) = v/m_par.L * tan(delta);

    return dx;

}


} /* dynamics */

