using SparseArrays

# Struct for Sparse matrix
    struct SparseMatrix
    rows::Int
    cols::Int
    nonzero::Dict{Tuple{Int,Int},Float16}
end

function SparseMatrix(rows::Int, cols::Int)
    nonzero = Dict{Tuple{Int,Int},Float64}()
    return SparseMatrix(rows, cols, nonzero)
end

function setelement!(A::SparseMatrix, i::Int, j::Int, x::Float64)
    if x != 0
        A.nonzero[(i, j)] = x
    else
        delete!(A.nonzero, (i, j))
    end
end

function getelement(A::SparseMatrix, i::Int, j::Int)
    if haskey(A.nonzero, (i, j))
        return A.nonzero[(i, j)]
    else
        return 0
    end
end

A = SparseMatrix(5,5)
for i = 1:7
    setelement!(A,rand(1:A.rows),rand(1:A.cols),rand(Float64))
end
A.nonzero

# COO format matrix multiplication
mat1 = rand(float.(0:3), 4, 4)
mat2 = rand(float.(0:3), 4, 4)

spMat1 = sparse(mat1)
spMat2 = sparse(mat2)
COOMat1 = findnz(spMat1) # With arrays of row, column pointer, and value.
COOMat2 = findnz(spMat2)
spaMat = spMat1 * spMat2
COO = findnz(spaMat)

# COO to CSR
function COOtoCSR(CSR,COO,mat)
    for i = 1:size(mat,2)
        if in(i,COO[2]) == true
            push!(CSR[2],findall(x->x==i, COO[2])[1])
        else
        end
    end
    return CSR
end

CSR1 = (COOMat1[1], [], COOMat1[3])
CSR2 = (COOMat2[1], [], COOMat2[3])
CSR = (COO[1], [], COO[3])

COOtoCSR(CSR1,COOMat1,mat1)
COOtoCSR(CSR2,COOMat2,mat2)
COOtoCSR(CSR,COO,spaMat)

# Example with different dimensions
example = [0	1	2	0	0	0	0
1	1	5	3	0	0	0
2	0	2	3	0	0	0
0	0	0	0	0	1	0
0	0	1	1	0	0	0
0	0	0	0	0	0	1]
spEx = sparse(example)
COOEx = findnz(spEx)
CSREx = (COOEx[1], [], COOEx[3])
COOtoCSR(CSREx,COOEx,example)
