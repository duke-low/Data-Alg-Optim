using LinearAlgebra
using Base
using RowEchelon

# Algorithm written from the video
function gElim(A::Array{Float64,2}, b::Array{Float64,1})
    n,m = size(A)
    for j = 1:n-1
        pivot = j
        for i = j+1:n
            if abs(A[i,j]) > abs(A[pivot,j])
                pivot = i
            end
        end
        if pivot != j
            A[pivot,:], A[j,:] = A[j,:], A[pivot,:]
            b[pivot], b[j] = b[j], b[pivot]
        end
        for i = j+1:n
            factor = A[i,j] / A[j,j]
            A[i,:] -= factor * A[j,:]
            b[i] -= factor * b[j]
        end
    end
    x = zeros(n)
    for i = n:-1:1
        x[i] = (b[i] - dot(A[i,i+1:n], x[i+1:n])) / A[i,i]
    end
    return x
end

mat1 = float.([1 -2 1; 2 1 -3; 4 -7 1])
vec1 = float.([0, 5, -1])
println("x1 = ", gElim(mat1,vec1))

mat2 = float.(rand(1:10, 3,3))
vec2 = float.(rand(1:10, 3))
println("x2 = ", gElim(mat2,vec2))

# Algorithm translated from Numerical Recipes in C
function gaussj(a::Array{Float64,2}, n::Int, b::Array{Float64,1}, m::Int)
    indxc = Vector{Int}(undef, n)
    indxr = Vector{Int}(undef, n)
    ipiv = Vector{Int}(undef, n)
    i = 0; icol = 0; irow = 0; j = 0; k = 0; l = 0; ll = 0;
    big = 0.0; dum = 0.0; pivinv = 0.0; temp = 0.0
    for j in 1:n
        ipiv[j] = 0
    end
    for i in 1:n
        big = 0.0
        for j in 1:n
            if ipiv[j] != 1
                for k in 1:n
                    if ipiv[k] == 0
                        if abs(a[j,k]) >= big
                            big = abs(a[j,k])
                            irow = j
                            icol = k
                        end
                    end
                end
            end
        end
        ipiv[icol] += 1
        if irow != icol
            for l in 1:n
                temp = a[irow,l]
                a[irow,l] = a[icol,l]
                a[icol,l] = temp
            end
            for l in 1:m
                temp = b[irow,l]
                b[irow,l] = b[icol,l]
                b[icol,l] = temp
            end
        end
        indxr[i] = irow
        indxc[i] = icol
        if a[icol,icol] == 0.0
            error("gaussj: Singular Matrix")
        end
        pivinv = 1.0 / a[icol,icol]
        a[icol,icol] = 1.0
        for l in 1:n
            a[icol,l] *= pivinv
        end
        for l in 1:m
            b[icol,l] *= pivinv
        end
        for ll in 1:n
            if ll != icol
                dum = a[ll,icol]
                a[ll,icol] = 0.0
                for l in 1:n
                    a[ll,l] -= a[icol,l]*dum
                end
                for l in 1:m
                    b[ll,l] -= b[icol,l]*dum
                end
            end
        end
    end
    for l in n:-1:1
        if indxr[l] != indxc[l]
            for k in 1:n
                temp = a[k,indxr[l]]
                a[k,indxr[l]] = a[k,indxc[l]]
                a[k,indxc[l]] = temp
            end
        end
    end
    return b
end

mat3 = float.([1 -2 1; 2 1 -3; 4 -7 1])
vec3 = float.([0, 5, -1])
println("x3 = ", gaussj(mat3, size(mat3,1), vec3, 1))
