using LinearAlgebra
using DataStructures
using Graphs

#Arrays
arr1 = rand(Float32, 5)
arr2 = rand(Float32, 5)
arr3 = rand(Float32, 3, 3)
arr4 = rand(Float32, 3, 3)

darr = dot(arr1,arr2)
marr = arr3 * arr4
println("The dot product of arrays is ", darr)
println("The matrix multiplication of arrays is ", marr)

#Linked Lists
list1 = rand(Float32, 4)

list1 = list(rand(1:10), rand(1:10), rand(1:10), rand(1:10))
list2 = list(rand(1:10), rand(1:10), rand(1:10), rand(1:10))

dlist = dot(list1, list2)
println("The dot product of linked lists is ", dlist)

#Stacks & Queues
stack1 = Stack{Int}()
empty!(stack1)
push!(stack1, rand(1:10), rand(1:10), rand(1:10), rand(1:10))

stack2 = Stack{Int}()
push!(stack2, rand(1:10), rand(1:10), rand(1:10), rand(1:10))
q1 = Queue{Int}()
i = 1
while i < 5
    enqueue!(q1, rand(1:10))
    global i += 1
end
q2 = Queue{Int}()
i = 1
while i < 5
    enqueue!(q2, rand(1:10))
    global i += 1
end

dstack = dot(stack1, stack2)
println("The dot product of stacks is ", dstack)

dq = dot(q1, q2)
println("The dot product of queues is ", dq)

#Hash Tables
dc1 = Dict(1=>rand(1:10), 2=>rand(1:10), 3=>rand(1:10), 4=>rand(1:10))
dc2 = Dict(1=>rand(1:10), 2=>rand(1:10), 3=>rand(1:10), 4=>rand(1:10))

ddc = dot(dc1, dc2) - 30
println("The dot product of hash tables is ", ddc)

#Trees, Graphs & Sets
struct Element
    name::String
    data::Int64
    loe
end

leaf1 = Element("leaf1", rand(1:10), nothing)
leaf2 = Element("leaf2", rand(1:10), nothing)
leaf3 = Element("leaf3", rand(1:10), nothing)
stem1 = Element("stem1", rand(1:10), [leaf1, leaf2])
stem2 = Element("stem2", rand(1:10), [leaf3])
tree = Element("tree", rand(1:10), [stem1, stem2])

import AbstractTrees: children, printnode, print_tree, Leaves
children(el::Element) = something(el.loe, [])
printnode(io::IO, el::Element) = print(io, el.name, ' ', el.data)
print_tree(tree)

graph = SimpleGraph(9);
add_edge!(graph, 1, 3);
add_edge!(graph, 6, 3);
add_edge!(graph, 6, 9);
h = SimpleGraphFromIterator(edges(graph));
collect(edges(h))

set1 = Set([1, 2, 3, 4, 5])
set2 = Set([6, 7, 8, 9, 10])

dset = dot(set1,set2)
println("The dot product of sets is ", dset)


#Standard algorithm
mat1 = [rand(1:10) rand(1:10); rand(1:10) rand(1:10)]
mat2 = [rand(1:10) rand(1:10); rand(1:10) rand(1:10)]

g1 = mat1[1] * mat2[1]
g2 = mat1[1] * mat2[3]
g3 = mat1[3] * mat2[2]
g4 = mat1[3] * mat2[4]
g5 = mat1[2] * mat2[1]
g6 = mat1[2] * mat2[3]
g7 = mat1[4] * mat2[2]
g8 = mat1[4] * mat2[4]

b11 = g1 + g3
b12 = g2 + g4
b21 = g5 + g7
b22 = g6 + g8
 
#Strassen's algorithm
h1 = (mat1[1] + mat1[4]) * (mat2[1] + mat2[4])
h2 = (mat1[2] + mat1[4]) * mat2[1]
h3 = mat1[1] * (mat2[3] - mat2[4])
h4 = mat1[4] * (-mat2[1] + mat2[2])
h5 = (mat1[1] + mat1[3]) * mat2[4]
h6 = (-mat1[1] + mat1[2]) * (mat2[1] + mat2[3])
h7 = (mat1[3] - mat1[4]) * (mat2[2] + mat2[4])

c11 = h1 + h4 - h5 + h7
c12 = h3 + h5
c21 = h2 + h4
c22 = h1 - h2 + h3 + h6

mat1 * mat2

#Flowchart
num1 = rand(1:10)
num2 = rand(1:10)
num3 = rand(1:10)
if num1 > num2 && num1 > num3
    println("Number1 is the largest with value ", num1)
elseif num1 > num2 && num1 < num3
    println("Number3 is the largest with value ", num3)
elseif num1 < num2 && num2 > num3
    println("Number2 is the largest with value ", num2)
elseif num1 < num2 && num2 < num3
    println("Number3 is the largest with value ", num3)
end

#Nassi-Shneiderman
#=  table_reviewed
    if table_clean
        use_table
    else
        spray_table
        wipe_table
        use_table
    end
=#

#O(n) Algorithm


#Pure Functional Programming Functions
v2 = map(x -> x * x, [1,3,4])
v3 = map((x,y) -> x + y, [1,3], [5,8])

function dotProd(x,y)
    v = map((x,y) -> x * y, x, y)
    return sum(v)
end

dotProd(arr1, arr2)

#Fast Fourier Transform
