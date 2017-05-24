Some implementation details about this model.

The model has a singularity when the velocity of the any of the four wheels is zero and become numerically unstable when the velocity is close to zero.

The proper way to go about this problem would be to include the dynamic model of the tire. However, the singularities here were circumvented by using a hack. Once the velocity is small enough we set the derivatives of all speeds (Ux, Uy, r, w1L, w1R, w2L, w2R) to zero by using a deadzone. Furthermore the velocity of the wheels is limited to positive values only in order to avoid singularities.
