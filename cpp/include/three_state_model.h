/*
 * Ctype_hatchback_dynamics.h
 *
 *  Created on: Sep 19, 2017
 *      Author: jelavice
 */

#ifndef THREE_STATE_MODEL_H_
#define THREE_STATE_MODEL_H_

#include "parameters.h"
#include <memory>

#include "system_dynamics.h"
//#define DEBUG

namespace dynamics {

class ThreeStateModel: public SystemDynamics<3, 2> {

public:

    typedef SystemDynamics<3, 2> BASE;

    ThreeStateModel() {}

    BASE::x_t f(const BASE::x_t& x, const BASE::u_t& u) override;

    virtual ~ThreeStateModel() {
    }

private:

    double Fy_F(const BASE::x_t& x, double delta);
    double Fy_R(const BASE::x_t& x, double FxR);
    double a_F(const BASE::x_t& x, double delta);
    double a_R(const BASE::x_t& x);
    double F_yPaj(double slip, double Fx, double Fz, double mu);

    parameters::ThreeStateModel m_par;

};

} /* dynamics*/

#endif /* THREE_STATE_MODEL_H_ */
