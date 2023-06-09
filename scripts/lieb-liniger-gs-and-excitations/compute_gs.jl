using CircularCMPS
using JLD2
using TensorKit, LinearAlgebra

c, μ, L = 1, 1.426, 16

function fE(ψ::CMPSData)
    OH = kinetic(ψ) + c*point_interaction(ψ) - μ * particle_density(ψ)
    expK, _ = finite_env(K_mat(ψ, ψ), L)
    return real(tr(expK * OH))
end

function fN(ψ::CMPSData)
    ON = particle_density(ψ)
    expK, _ = finite_env(K_mat(ψ, ψ), L)
    return real(tr(expK * ON))
end

ψ1 = CMPSData(rand, 4, 1)
ψ1, E, grad, numfg, history = lieb_liniger_ground_state(c, μ, L, ψ1)
_, α1 = finite_env(K_mat(ψ1, ψ1), L)
ψ1 = rescale(ψ1, -real(α1), L)

@show fE(ψ1), fN(ψ1)
@save "data/cmps_c$(c)_mu$(μ)_L$(L).jld2" ψ1 

ψ2 = expand(ψ1, 8, L)
ψ2, E2, grad, numfg, history = lieb_liniger_ground_state(c, μ, L, ψ2)
_, α2 = finite_env(K_mat(ψ2, ψ2), L)
ψ2 = rescale(ψ2, -real(α2), L)

@show fE(ψ2), fN(ψ2)
@save "data/cmps_c$(c)_mu$(μ)_L$(L).jld2" ψ1 ψ2  

ψ3 = expand(ψ2, 12, L)
ψ3, E3, grad, numfg, history = lieb_liniger_ground_state(c, μ, L, ψ3)
_, α3 = finite_env(K_mat(ψ3, ψ3), L)
ψ3 = rescale(ψ3, -real(α3), L)

@show fE(ψ3), fN(ψ3)
@save "data/cmps_c$(c)_mu$(μ)_L$(L).jld2" ψ1 ψ2 ψ3  

ψ4 = expand(ψ3, 16, L)
ψ4, E4, grad, numfg, history = lieb_liniger_ground_state(c, μ, L, ψ4)
_, α4 = finite_env(K_mat(ψ4, ψ4), L)
ψ4 = rescale(ψ4, -real(α4), L)

@show fE(ψ4), fN(ψ4)
@save "data/cmps_c$(c)_mu$(μ)_L$(L).jld2" ψ1 ψ2 ψ3 ψ4  

ψ5 = expand(ψ4, 20, L)
ψ5, E5, grad, numfg, history = lieb_liniger_ground_state(c, μ, L, ψ5)
_, α5 = finite_env(K_mat(ψ5, ψ5), L)
ψ5 = rescale(ψ5, -real(α5), L)

@show fE(ψ5), fN(ψ5)
@save "data/cmps_c$(c)_mu$(μ)_L$(L).jld2" ψ1 ψ2 ψ3 ψ4 ψ5  

