/*
 * Ctype_hatchback_dynamics.h
 *
 *  Created on: Sep 19, 2017
 *      Author: jelavice
 */

#ifndef DYNAMICS_THREE_STATE_MODEL_H_
#define DYNAMICS_THREE_STATE_MODEL_H_

#include "parameters.h"
#include "system_dynamics.h"
//#define DEBUG

namespace dynamics {

class ThreeStateModel: public SystemDynamics<3, 2> {

public:

    typedef SystemDynamics<3, 2> BASE;

    ThreeStateModel() {}

    BASE::x_t f(const BASE::x_t& x, const BASE::u_t& u) const override;

    virtual ~ThreeStateModel() {
    }



    double Fy_F(const BASE::x_t& x, double delta) const;
    double Fy_R(const BASE::x_t& x, double FxR) const;
    double a_F(const BASE::x_t& x, double delta) const;
    double a_R(const BASE::x_t& x) const;
    double F_yPaj(double slip, double Fx, double Fz, double mu) const;

    //TODO fix this. No const
    const parameters::ThreeStateModel m_par;

};

} /* dynamics*/

#endif /* DYNAMICS_THREE_STATE_MODEL_H_ */
