/*
 * kinematic_model.h
 *
 *  Created on: Sep 28, 2017
 *      Author: jelavice
 */

#ifndef DYNAMICS_KINEMATIC_MODEL_H_
#define DYNAMICS_KINEMATIC_MODEL_H_

#include "parameters.h"
#include "system_dynamics.h"

namespace dynamics {


class KinematicModel: public SystemDynamics<3, 2> {

public:

    typedef SystemDynamics<3, 2> BASE;

    KinematicModel() {}

    BASE::x_t f(const BASE::x_t& x, const BASE::u_t& u) override;

    virtual ~KinematicModel() {
    }

private:

    parameters::KinematicModel m_par;

};


} /*dynamics*/



#endif /* DYNAMICS_KINEMATIC_MODEL_H_ */
