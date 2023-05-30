using Plots

function double_pendulum!(θ, ω, L1, L2, m1, m2, g, Δt, t_end)
    N = Int64(t_end / Δt)
    θ₁, θ₂ = θ
    ω₁, ω₂ = ω
    x1 = L1 * sin(θ₁)
    y1 = -L1 * cos(θ₁)
    x2 = x1 + L2 * sin(θ₂)
    y2 = y1 - L2 * cos(θ₂)
    x = [0, x1, x2]
    y = [0, y1, y2]
    plot(x, y, xlims=(-(L1+L2), L1+L2), ylims=(-(L1+L2), L1+L2), aspect_ratio=:equal, legend=false)
    for i = 1:N
        α = m2 * L1 * L2 * sin(θ₂ - θ₁)
        β = m2 * L2^2 + m1 * L1^2 + m2 * L1^2 * (1 - cos(θ₂ - θ₁)^2)
        ω₁_new = (m2 * L1 * ω₁^2 * sin(θ₂ - θ₁) * cos(θ₂ - θ₁) + m2 * g * sin(θ₂) * cos(θ₂ - θ₁) + m2 * L2 * ω₂^2 * sin(θ₂ - θ₁) - (m1 + m2) * g * sin(θ₁)) / β
        ω₂_new = (-m2 * L2 * ω₂^2 * sin(θ₂ - θ₁) * cos(θ₂ - θ₁) + (m1 + m2) * (g * sin(θ₁) * cos(θ₂ - θ₁) - L1 * ω₁^2 * sin(θ₂ - θ₁) - g * sin(θ₂))) / β
        θ₁ += ω₁ * Δt
        θ₂ += ω₂ * Δt
        ω₁ = ω₁_new
        ω₂ = ω₂_new
        x1 = L1 * sin(θ₁)
        y1 = -L1 * cos(θ₁)
        x2 = x1 + L2 * sin(θ₂)
        y2 = y1 - L2 * cos(θ₂)
        x = [0, x1, x2]
        y = [0, y1, y2]
        plot!(x, y)
    end
end

L1 = 1.0
L2 = 0.5
m1 = 1.0
m2 = 0.5
g = 9.81
Δt = 0.01
t_end = 10.0
θ = [π/2, π/2]
ω = [0.0, 0.0]

double_pendulum!(θ, ω, L1, L2, m1, m2, g, Δt, t_end)
