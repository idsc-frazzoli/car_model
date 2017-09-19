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

namespace car_dynamics {


class ThreeStateModel : public CarDynamics<3,2> {

	typedef CarDynamics<3, 2> 					BASE;
	typedef std::unique_ptr<ThreeStateModel>    ptr_t;

public:

	ThreeStateModel(BASE::x_t x0) {
		x_ = x0;
	}

	ThreeStateModel() {
		x_ = BASE::x_t::Zero();
	}

	virtual BASE::x_t f(const BASE::x_t& x, const BASE::u_t& u) {

		if (x.size() > 3)
			throw std::runtime_error("This is a three state model, vector should be size 3");

		if (u.size() > 2)
			throw std::runtime_error("This model has two inputs, vector should be size 2");


		double beta = x(0);
		double r = x(1);
		double Ux = x(2);
		double delta = u(0);
		double FxR = u(1);

		double FyF = Fy_F(beta, r, Ux, delta);
		double FyR = Fy_R(beta, r, Ux, FxR);

		double dbeta = (FyF + FyR) / (par_.m * Ux) - r;
		double dr = (par_.a * FyF - par_.b * FyR) / par_.Iz;
		double dUx = (FxR - FyF * std::sin(delta)) / par_.m + r * Ux * beta;

		BASE::x_t dx;
		dx << beta, r, Ux;
		return dx;

	}

	virtual ~ThreeStateModel(){}

private:

	double Fy_F(const BASE::x_t x, double delta) { return double(0);}
	double Fy_R(const BASE::x_t x, double delta) { return double(0);}
	double a_F() {};
	double a_R() {};
	double F_yPaj() {};
	double Fz_F() {};
	double Fz_R() {};


	parameters::ThreeStateModel par_;



};

} /* car_dynamics*/


#endif /* THREE_STATE_MODEL_H_ */
