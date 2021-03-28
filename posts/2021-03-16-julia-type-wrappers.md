---
layout: article
title: Julia type wrappers
author: Szymon Bęczkowski
category: programming
tags: [julia, type-system]
---
A quick example is simple type wrappers in Julia. An example of this from the standard library is the Diagonal type. A Diagonal matrix is a matrix which is zero off of its diagonal, so it makes sense to represent a diagonal matrix by an array which is simply that diagonal. We can thus create a type which holds an array:     

```julia
@inline function LinearAlgebra.mul!(w::AbstractVector, D::MyDiagonal, v)
  d = D.diag
  for i in eachindex(w)    
    w[i] = d[i] * v[i]  
  end
end
```

Notice that the parametric typing makes this a strictly typed type which the compiler will specialize on when it knows the input. Now for this to be useful we want this to act like a diagonal matrix. To do so, we define a few overloads for arithmetic. For example, multiplication of a vector by a diagonal matrix is the same as element-wise multiplication between the diagonal and said vector. 