% VL_KMEANS  Cluster data using k-means
%   [C, A] = VL_KMEANS(X, NUMCENTERS) clusters the columns of the
%   matrix X in NUMCENTERS centers C using k-means. X may be either
%   SINGLE or DOUBLE. C has the same number of rows of X and NUMCENTER
%   columns, with one column per center. A is a UINT32 row vector
%   specifying the assignments of the data X to the NUMCENTER
%   centers.
%
%   [C, A, ENERGY] = VL_KMEANS(...) returns the energy of the solution
%   (or an upper bound for the ELKAN algorithm) as well.
%
%   KMEANS() supports different initialization and optimization
%   methods and different clustering distances. Specifically, the
%   following options are supported:
%
%   Verbose::
%     Increase the verbosity level (may be specified multiple times).
%
%   Distance:: [L2]
%     Use either L1 or L2 distance.
%
%   Initialization::
%     Use either random data points (RANDSEL) or k-means++ (PLUSPLUS)
%     to initialize the centers.
%
%   Algorithm:: [LLOYD]
%     Use either the standard LLOYD or the accelerated
%     ELKAN algorithm for optimization.
%
%   NumRepetitions:: [1]
%     Number of time to restart k-means. The solution with minimal
%     energy is returned.
%
%   Example::
%     VL_KMEANS(X, 10, 'verbose', 'distance', 'l1', 'algorithm',
%     'elkan') clusters the data point X using 10 centers, l1
%     distance, and the Elkan's algorithm.
%
%   See also: VL_HELP().

% Authors: Andrea Vedaldi

% Copyright (C) 2007-12 Andrea Vedaldi and Brian Fulkerson.
% All rights reserved.
%
% This file is part of the VLFeat library and is made available under
% the terms of the BSD license (see the COPYING file).

