/*
 * Ctype_hatchback_dynamics.h
 *
 *  Created on: Sep 19, 2017
 *      Author: jelavice
 */

#ifndef THREE_STATE_MODEL_H_
#define THREE_STATE_MODEL_H_

#include "car_dynamics.h"


template <int STATE_DIM, int INPUT_DIM>
class ThreeStateModel : public CarDynamics<STATE_DIM, INPUT_DIM>{

	typedef CarDynamics<STATE_DIM, INPUT_DIM> BASE;
	typedef typename BASE::x_t x_t;
	typedef typename BASE::dx_t dx_t;
	typedef typename BASE::u_t u_t;

public:

	virtual x_t& f(x_t& _x, u_t& _u) { dx_t dx; return dx;}

	virtual ~ThreeStateModel(){}


};


#endif /* THREE_STATE_MODEL_H_ */
