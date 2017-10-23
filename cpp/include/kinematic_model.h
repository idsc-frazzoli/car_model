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

    KinematicModel(): m_u(BASE::u_t(0,0)) {}

    BASE::x_t f(const BASE::x_t& x, const BASE::u_t& u) override;

    Eigen::Matrix<double, 2, 1> getLinearVelocitiesB (const BASE::x_t& x);

    double getAngularVelocity (const BASE::x_t& x);

    virtual ~KinematicModel() {
    }

private:

    //TODO fix this no const
    const parameters::KinematicModel m_par;

    BASE::u_t m_u;

};


} /*dynamics*/



#endif /* DYNAMICS_KINEMATIC_MODEL_H_ */
