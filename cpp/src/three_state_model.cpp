/*
 * three_state_model.cpp
 *
 *  Created on: Sep 19, 2017
 *      Author: jelavice
 */

#include "three_state_model.h"
#include <cmath>
#include <iostream>

namespace dynamics {

using BASE = ThreeStateModel::BASE;

Eigen::Matrix<double, 2, 1> ThreeStateModel::getLinearVelocitiesB(const BASE::x_t& x) const {
//    double Ux = x(2);
//    double beta = x(0);
//    double Uy = tan(beta) * Ux;
    return Eigen::Matrix<double, 2, 1>(x(2), tan(x(0)) * x(2));
}

double ThreeStateModel::getAngularVelocity(const BASE::x_t& x) const {
    return x(1);
}

BASE::x_t ThreeStateModel::f(const BASE::x_t& x, const BASE::u_t& u) {

    double beta = x(0);
    double r = x(1);
    double Ux = x(2);
    double delta = u(0);
    double FxR = u(1);

    double FyF = Fy_F(x, delta);
    double FyR = Fy_R(x, FxR);

#ifdef DEBUG
    std::cout << "Beta in:  " << beta << std::endl;
    std::cout << "r in:     " << r << std::endl;
    std::cout << "Ux in:    " << Ux << std::endl;
    std::cout << "delta in: " << delta << std::endl;
    std::cout << "FxR in:   " << FxR << std::endl << std::endl;
    std::cout << "FyF :     " << FyF << std::endl;
    std::cout << "FyR :     " << FyR << std::endl;
#endif

    double dbeta = (FyF + FyR) / (m_par.m * Ux) - r;
    double dr = (m_par.a * FyF - m_par.b * FyR) / m_par.Iz;
    double dUx = (FxR - FyF * std::sin(delta)) / m_par.m + r * Ux * beta;

    BASE::x_t dx;
    dx << dbeta, dr, dUx;
    return dx;

}

double ThreeStateModel::Fy_F(const BASE::x_t& x, double delta) const {

#ifdef DEBUG
    std::cout << "a_F: " << a_F(x,delta) << std::endl;
    std::cout << "FzF: " << Fz_F() << std::endl;
    std::cout << "muF: " << m_par.muF << std::endl;
#endif

    return F_yPaj(a_F(x, delta), 0.0, m_par.FzF, m_par.muF);
}

double ThreeStateModel::Fy_R(const BASE::x_t& x, double FxR) const {

#ifdef DEBUG
    std::cout << "a_R: " << a_R(x) << std::endl;
    std::cout << "FxR: " << FxR << std::endl;
    std::cout << "FzR: " << Fz_R() << std::endl;
    std::cout << "muR: " << m_par.muR << std::endl;
#endif

    return F_yPaj(a_R(x), FxR, m_par.FzR, m_par.muR);
}

double ThreeStateModel::a_F(const BASE::x_t& x, double delta) const {
    //beta - x(0)
    // r   - x(1)
    // Ux  - x(2)
    return atan(x(0) + m_par.a * x(1) / x(2)) - delta;
}

double ThreeStateModel::a_R(const BASE::x_t& x) const {
    //beta - x(0)
    // r   - x(1)
    // Ux  - x(2)
    return atan(x(0) - m_par.b * x(1) / x(2));
}

double ThreeStateModel::F_yPaj(double slip, double Fx, double Fz, double mu) const {
    double eps;
    if (mu * Fz < Fx)
        return 0;
    else
        eps = std::sqrt(std::pow(mu * Fz, 2) - std::pow(Fx, 2)) / (mu * Fz);

    return -eps * Fz * mu * m_par.D * std::sin(m_par.C * atan(m_par.B * slip));
}

} /* dynamics*/
