using Plots

# Simplified two-body system parameters
const M1 = 10.0  # Primary mass (arbitrary units)
const M2 = 1.0   # Secondary mass (mass ratio = 10)
const R = 2.0    # Separation distance (arbitrary units)
const R1 = 0.5   # Primary body radius
const R2 = 0.1   # Secondary body radius

function effective_potential(x, y)
    """
    Calculate effective potential in rotating reference frame for two-body system.
    Includes gravitational potential + centrifugal potential.
    Uses finite-size spherical bodies to avoid singularities.
    Origin at barycenter, primary at (-μ*R, 0), secondary at ((1-μ)*R, 0)
    where μ = M2/(M1 + M2)
    """
    μ = M2 / (M1 + M2)
    
    # Primary mass position (relative to barycenter)
    x1 = -μ * R
    y1 = 0.0
    
    # Secondary mass position (relative to barycenter) 
    x2 = (1 - μ) * R
    y2 = 0.0
    
    # Distance from point to each mass center
    r1 = sqrt((x - x1)^2 + (y - y1)^2)
    r2 = sqrt((x - x2)^2 + (y - y2)^2)
    
    # Gravitational potential for uniform density spheres
    # Outside sphere: -M/r
    # Inside sphere: -M*(3*R^2 - r^2)/(2*R^3)
    
    # Primary body potential
    if r1 >= R1
        V1 = -M1 / r1  # Outside primary
    else
        V1 = -M1 * (3*R1^2 - r1^2) / (2*R1^3)  # Inside primary
    end
    
    # Secondary body potential
    if r2 >= R2
        V2 = -M2 / r2  # Outside secondary
    else
        V2 = -M2 * (3*R2^2 - r2^2) / (2*R2^3)  # Inside secondary
    end
    
    # Gravitational potential
    V_grav = V1 + V2
    
    # Centrifugal potential in rotating frame
    # ω² = G(M1 + M2)/R³, but we use normalized units where G(M1+M2) = M1+M2
    ω² = (M1 + M2) / R^3
    r_squared = x^2 + y^2  # Distance from rotation axis (z-axis)
    V_centrifugal = -0.5 * ω² * r_squared
    
    # Total effective potential
    potential = V_grav + V_centrifugal
    
    return potential
end

function plot_isopotential_contours()
    """
    Create filled contour plot of isopotential surfaces in two-body system
    """
    # Create coordinate grid centered on barycenter
    x_range = range(-4.0, 4.0, length=200)
    y_range = range(-3.0, 3.0, length=150)
    
    # Calculate effective potential at each grid point
    println("Calculating effective potential field (gravitational + centrifugal)...")
    potential_grid = [effective_potential(x, y) for y in y_range, x in x_range]
    
    # Create filled contour plot
    println("Creating contour plot...")
    plt = contourf(x_range, y_range, potential_grid, 
                   levels=50,
                   color=:viridis,
                   xlabel="x (distance units)",
                   ylabel="y (distance units)",
                   title="Effective Potential: Two-Body System (Mass Ratio 10:1)",
                   aspect_ratio=:equal)
    
    # Mark mass positions
    μ = M2 / (M1 + M2)
    x1 = -μ * R  # Primary mass position
    x2 = (1 - μ) * R  # Secondary mass position
    
    # Draw bodies with their actual radii
    θ = range(0, 2π, length=100)
    
    # Primary body circle
    x1_circle = x1 .+ R1 * cos.(θ)
    y1_circle = 0 .+ R1 * sin.(θ)
    plot!(x1_circle, y1_circle, color=:red, linewidth=2, label="Primary (M=10, R=0.5)")
    
    # Secondary body circle  
    x2_circle = x2 .+ R2 * cos.(θ)
    y2_circle = 0 .+ R2 * sin.(θ)
    plot!(x2_circle, y2_circle, color=:orange, linewidth=2, label="Secondary (M=1, R=0.1)")
    
    # Mark centers
    scatter!([x1], [0], marker=:+, markersize=8, color=:red, markerstrokewidth=3, label="")
    scatter!([x2], [0], marker=:+, markersize=6, color=:orange, markerstrokewidth=3, label="")
    
    # Add colorbar
    plot!(colorbar_title="Effective Potential")
    
    return plt
end

# Generate and display the plot
println("Two-Body Effective Potential Analysis (Rotating Frame)")
println("====================================================")
println("Primary mass: $(M1), radius: $(R1)")
println("Secondary mass: $(M2), radius: $(R2)") 
println("Mass ratio: $(M1/M2):1")
println("Separation distance: $(R)")
μ = M2 / (M1 + M2)
ω² = (M1 + M2) / R^3
println("Mass parameter μ: $(round(μ, digits=3))")
println("Angular velocity² ω²: $(round(ω², digits=3))")

plot_result = plot_isopotential_contours()

# Save the plot
savefig(plot_result, "two_body_isopotential.png")
println("Plot saved as 'two_body_isopotential.png'")

# Display the plot (if running in interactive environment)
display(plot_result)