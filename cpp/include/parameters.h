/*
 * parameters.h
 *
 *  Created on: Sep 19, 2017
 *      Author: jelavice
 */

#ifndef PARAMETERS_H_
#define PARAMETERS_H_

namespace parameters {

//TODO put this in a config file
struct ThreeStateModel { //naming conflict

    //mass [kg]
    static constexpr const double m = 1412;

    // yawing moment of inertia [kgm2]
    static constexpr const double Iz = 1536.7 + 427.7084; // sprung mass inertia + unsprung mass inertia

    // front axle distance from COG [m]
    static constexpr const double a = 1.015;

    // rear axle distanc from COG [m]
    static constexpr const double b = 1.895;

    // pacejka model parameters
    static constexpr const double B1 = 13.8509;
    static constexpr const double C1 = 1.367;
    static constexpr const double D1 = 0.9622;
    static constexpr const double B2 = 14.1663;
    static constexpr const double C2 = 1.3652;
    static constexpr const double D2 = 0.9744;
    static constexpr const double B = (B1 + B2) / 2;
    static constexpr const double C = (C1 + C2) / 2;
    static constexpr const double D = (D1 + D2) / 2;

    // gravitational acceleration [m/s2]
    static constexpr const double g = 9.81;

    // tire road friction coefficient
    const double muF = 0.55;
    const double muR = 0.53;

    //FzF and FzR
    static constexpr const double FzF =  m * g * b / (a + b);
    static constexpr const double FzR = m *g * a/ (a+b);
};

} /* parameters*/

#endif /* PARAMETERS_H_ */
