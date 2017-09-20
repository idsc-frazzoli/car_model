/*
 * Ctype_hatchback_dynamics.h
 *
 *  Created on: Sep 19, 2017
 *      Author: jelavice
 */

#ifndef THREE_STATE_MODEL_H_
#define THREE_STATE_MODEL_H_

#include "car_dynamics.h"
#include "parameters.h"
#include <memory>
//#define DEBUG

namespace car_dynamics {

class ThreeStateModel: public CarDynamics<3, 2> {

public:

    typedef CarDynamics<3, 2> BASE;
    typedef std::unique_ptr<ThreeStateModel> ptr_t;

    ThreeStateModel(const BASE::x_t& x0) {
        x_ = x0;
    }

    ThreeStateModel() {
        x_ = BASE::x_t::Zero();
    }

    virtual BASE::x_t f(const BASE::x_t& x, const BASE::u_t& u) override;

    BASE::x_t f(const BASE::u_t& u) {
        return f(x_, u);
    }
    ;

    virtual ~ThreeStateModel() {
    }

private:

    double Fy_F(const BASE::x_t& x, double delta);
    double Fy_R(const BASE::x_t& x, double FxR);
    double a_F(const BASE::x_t& x, double delta);
    double a_R(const BASE::x_t& x);
    double F_yPaj(double slip, double Fx, double Fz, double mu);
    double Fz_F();
    double Fz_R();

    parameters::ThreeStateModel par_;

};

} /* car_dynamics*/

#endif /* THREE_STATE_MODEL_H_ */
