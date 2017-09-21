#include <iostream>
#include <math.h>
#include "mex.h"
#include "three_state_model.h"
#include <Eigen/Dense>

using x_t = dynamics::ThreeStateModel::BASE::x_t;
using u_t = dynamics::ThreeStateModel::BASE::u_t;

static void wrapper(double* x, double* u, double* retX, bool cleanUp = false) {
    static dynamics::ThreeStateModel *modelPtr = NULL;

    x_t xEig;
    u_t uEig;

    //convert Double arrays to Eigen types
    for (int i = 0; i < xEig.size(); i++) {
        xEig(i) = x[i];
    }

    for (int i = 0; i < uEig.size(); i++) {
        uEig(i) = u[i];
    }

    if (modelPtr == NULL && cleanUp == false)
        modelPtr = new dynamics::ThreeStateModel(xEig); // Create a  MyData object

    if (modelPtr == NULL && cleanUp == true) {
        flush(std::cout);
        return;
    }

    x_t temp = modelPtr->f(xEig, uEig);

    //convert Eigen types back to double
    for (int i = 0; i < temp.size(); i++)
        retX[i] = temp(i);

    if (cleanUp == true && modelPtr != NULL) {
        delete (modelPtr);
        modelPtr = NULL;
    }

    flush(std::cout);
    return;
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    double *xin, *uin, *retX;
    bool *bin;

    int M = mxGetM(prhs[0]);
    int N = mxGetN(prhs[0]);
    if (N > 1 && M > 1)
        mexErrMsgIdAndTxt("MATLAB:mexcpp:nargin", "First argument should be a vector, not a matrix.");
    if (mxGetN(prhs[0]) > 1 && mxGetM(prhs[0]) > 1)
        mexErrMsgIdAndTxt("MATLAB:mexcpp:nargin", "Second argument should be a vector, not a matrix.");

    //convert the state to row vector
    static int nRows = std::max(M, N);

    /* Check for proper number of arguments */

    if (nrhs == 3) {
        xin = (double *) mxGetPr(prhs[0]);
        uin = (double *) mxGetPr(prhs[1]);
        bin = (bool *) mxGetPr(prhs[2]);

        /* create the output matrix */
        plhs[0] = mxCreateDoubleMatrix(nRows, 1, mxREAL);

        /* get a pointer to the real data in the output matrix */
        retX = mxGetPr(plhs[0]);
        wrapper(xin, uin, retX, bin);
    } else if (nrhs == 2) {
        xin = (double *) mxGetPr(prhs[0]);
        uin = (double *) mxGetPr(prhs[1]);

        /* create the output matrix */
        plhs[0] = mxCreateDoubleMatrix(nRows, 1, mxREAL);

        /* get a pointer to the real data in the output matrix */
        retX = mxGetPr(plhs[0]);
        wrapper(xin, uin, retX);
    } else {
        mexErrMsgIdAndTxt("MATLAB:mexcpp:nargin", "MEXCPP requires at least two input arguments.");
    }

    if (nlhs > 1) {
        mexErrMsgIdAndTxt("MATLAB:mexcpp:nargout", "MEXCPP requires one output argument.");
    }

    return;
}
