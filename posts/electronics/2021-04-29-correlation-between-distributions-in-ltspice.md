---
layout: article
title: Correlation between distributions in LTSpice
author: Szymon Bęczkowski
category: electronics
tags: [ltspice, distributions, monte-carlo]
---
These two distributions have a 0.75 correlation. Ask Jacob how to do it. 

The Cholesky decomposition is commonly used in the Monte Carlo method for simulating systems with multiple correlated variables. The covariance matrix is decomposed to give the lower-triangular L. Applying this to a vector of uncorrelated samples u produces a sample vector Lu with the covariance properties of the system being modeled.(Wikipedia)

.param d1 {gauss(1)}
.param d2 {gauss(1)}
.param g1 {0.2325+0.00375*d1}
.param vt1 {5.77673+0.06252*(-0.757325*d1+0.653038*d2)}
