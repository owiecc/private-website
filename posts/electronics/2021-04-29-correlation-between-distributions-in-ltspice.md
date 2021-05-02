---
layout: article
title: Correlation between distributions in LTSpice
author: Szymon Bęczkowski
category: electronics
tags: [ltspice, distributions, monte-carlo]
---
These two distributions have a 0.75 correlation. Ask Jacob how to do it. 

.param d1 {gauss(1)}
.param d2 {gauss(1)}
.param g1 {0.2325+0.00375*d1}
.param vt1 {5.77673+0.06252*(-0.757325*d1+0.653038*d2)}
