/*
 * kinematic_model.cpp
 *
 *  Created on: Sep 28, 2017
 *      Author: jelavice
 */


#include "kinematic_model.h"


namespace dynamics {

using BASE = KinematicModel::BASE;




Eigen::Matrix<double, 2, 1> KinematicModel::getLinearVelocitiesB(const BASE::x_t& x) {

    // connetion is that this return velocities in the
    Eigen::Matrix<double, 2, 2> w_R_b;
    double yaw = x(2);
    BASE::x_t dx;
    dx = f(x, m_u);
    w_R_b << cos(yaw), -sin(yaw), sin(yaw), cos(yaw);
    Eigen::Matrix<double, 2, 1> linVelB = dx.block<2,1>(0,0);

    return w_R_b.transpose() * linVelB;
}

double KinematicModel::getAngularVelocity(const BASE::x_t& x) {
    BASE::x_t dx = f(x, m_u);
    return dx(2);
}


BASE::x_t KinematicModel::f(const BASE::x_t& x, const BASE::u_t& u) {

    BASE::x_t dx;

    m_u = u;

    double delta = u(0), v = u(1); //inputs
    double theta = x(2);

    dx(0) = v * cos(theta);
    dx(1) = v * sin(theta);
    dx(2) = v / m_par.L * tan(delta);

    return dx;

}


} /* dynamics */

