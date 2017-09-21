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

BASE::x_t ThreeStateModel::f(const BASE::x_t& x, const BASE::u_t& u) {

    m_x = x;
    if (x.size() > 3)
        throw std::runtime_error("This is a three state model, vector should be size 3");

    if (u.size() > 2)
        throw std::runtime_error("This model has two inputs, vector should be size 2");

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

double ThreeStateModel::Fy_F(const BASE::x_t& x, double delta) {

#ifdef DEBUG
    std::cout << "a_F: " << a_F(x,delta) << std::endl;
    std::cout << "FzF: " << Fz_F() << std::endl;
    std::cout << "muF: " << m_par.muF << std::endl;
#endif

    static double const FzF = Fz_F();
    return F_yPaj(a_F(x, delta), 0.0, FzF, m_par.muF);
}

double ThreeStateModel::Fy_R(const BASE::x_t& x, double FxR) {

#ifdef DEBUG
    std::cout << "a_R: " << a_R(x) << std::endl;
    std::cout << "FxR: " << FxR << std::endl;
    std::cout << "FzR: " << Fz_R() << std::endl;
    std::cout << "muR: " << m_par.muR << std::endl;
#endif
    static double const FzR = Fz_R();
    return F_yPaj(a_R(x), FxR, FzR, m_par.muR);
}

double ThreeStateModel::a_F(const BASE::x_t& x, double delta) {
    //beta - x(0)
    // r   - x(1)
    // Ux  - x(2)
    return atan(x(0) + m_par.a * x(1) / x(2)) - delta;
}

double ThreeStateModel::a_R(const BASE::x_t& x) {
    //beta - x(0)
    // r   - x(1)
    // Ux  - x(2)
    return atan(x(0) - m_par.b * x(1) / x(2));
}

double ThreeStateModel::F_yPaj(double slip, double Fx, double Fz, double mu) {
    double eps;
    if (mu * Fz < Fx)
        return 0;
    else
        eps = std::sqrt(std::pow(mu * Fz, 2) - std::pow(Fx, 2)) / (mu * Fz);

    return -eps * Fz * mu * m_par.D * std::sin(m_par.C * atan(m_par.B * slip));
}

double ThreeStateModel::Fz_F() {
    return m_par.m * m_par.g * m_par.b / (m_par.a + m_par.b);
}

double ThreeStateModel::Fz_R() {
    return m_par.m * m_par.g * m_par.a / (m_par.a + m_par.b);
}

} /* dynamics*/
