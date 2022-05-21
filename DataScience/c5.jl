# to install dependecies : using Pkg; Pkg.add("[lib]")

using Statistics 
using StatsBase
using RDatasets
using Plots
using StatsPlots
using KernelDensity
using LinearAlgebra
using HypothesisTests
using PyCall
using MLBase


D = dataset("datasets", "faithful")
describe(D)

eruptions = D[!, :Eruptions]
scatter(eruptions, label = "eruptions")
waittime = D[!, :Waiting]
scatter!(waittime, label = "wait time")

boxplot(["eruption length"], eruptions, legend = false, size = (200,400), whisker_width = 1, ylabel = "time in minutes")
histogram(eruptions, bins=:sqrt,  label = "eruptions")

p = kde(eruptions)

#um plot com bins ruins
histogram(eruptions, label = "eruptions")
plot!(p.x,p.density .* length(eruptions), linewidth=3, color = 2, label = "kde fit")

#um plot com bins bons
histogram(eruptions, bins=:sqrt,  label = "eruptions")
plot!(p.x,p.density .* length(eruptions) .*0.2, linewidth=3, color = 2, label = "kde fit")

random = randn(100_000)
histogram(random)
p = kde(random)
plot!(p.x, p.density .* length(random) .*0.1, linewidth = 3, color = 2, label = "kde_fit")



