# Two-Body Lagrange Points Visualization

A Julia script for visualizing the effective potential and Lagrange points in a two-body gravitational system using contour plots.

## Overview

This project calculates and visualizes the five Lagrange points (L1-L5) in a simplified two-body system by plotting the effective potential in a rotating reference frame. The effective potential combines:

- **Gravitational potential**: From two finite-size spherical masses
- **Centrifugal potential**: From the rotating reference frame

## Features

- **Finite-size bodies**: Uses uniform density spheres to avoid singularities
- **All 5 Lagrange points**: Shows equilibrium points including the stable L4/L5 triangular points
- **Configurable parameters**: Easy to adjust mass ratios, radii, and separation distances
- **High-quality visualization**: Filled contour plots with proper scaling and labels

## Physics Background

In the restricted three-body problem, Lagrange points are positions where the gravitational forces of two massive bodies and the centrifugal force in the rotating frame balance out. The effective potential is:

```
V_eff = V_gravitational + V_centrifugal
V_eff = -M₁/r₁ - M₂/r₂ - ½ω²r²
```

Where:
- `M₁, M₂` are the masses of the two bodies
- `r₁, r₂` are distances from each mass
- `ω` is the angular velocity of the rotating system
- `r` is the distance from the rotation axis

## System Parameters

- **Mass ratio**: 10:1 (Primary:Secondary)
- **Primary body**: Mass = 10, Radius = 0.5
- **Secondary body**: Mass = 1, Radius = 0.1
- **Separation distance**: 2.0 units
- **Coordinate range**: x ∈ [-4, 4], y ∈ [-3, 3]

## Requirements

- Julia (version 1.6+)
- Plots.jl package

## Installation

1. Clone this repository:
```bash
git clone https://github.com/crewsdw/two-body-lagrange-points.git
cd two-body-lagrange-points
```

2. Install required Julia packages:
```julia
using Pkg
Pkg.add("Plots")
```

## Usage

Run the script from Julia:

```bash
julia earth_moon_isopotential.jl
```

Or from the Julia REPL:
```julia
include("earth_moon_isopotential.jl")
```

The script will:
1. Calculate the effective potential field on a 2D grid
2. Generate a filled contour plot showing isopotential lines
3. Mark the positions and radii of both masses
4. Save the plot as `two_body_isopotential.png`
5. Display the plot (if running in an interactive environment)

## Output

The visualization shows:
- **Filled contours**: Isopotential surfaces (darker = lower potential)
- **Red circle**: Primary mass (M=10, R=0.5)
- **Orange circle**: Secondary mass (M=1, R=0.1)
- **Cross markers**: Mass centers
- **Lagrange points**: Visible as saddle points and local extrema

### Lagrange Points Identification

- **L1**: Between the two masses (saddle point)
- **L2**: Beyond the smaller mass (saddle point)  
- **L3**: Beyond the larger mass (saddle point)
- **L4, L5**: Forming equilateral triangles with the two masses (local maxima in effective potential)

## Customization

You can easily modify the system parameters by editing the constants at the top of the script:

```julia
const M1 = 10.0  # Primary mass
const M2 = 1.0   # Secondary mass  
const R = 2.0    # Separation distance
const R1 = 0.5   # Primary body radius
const R2 = 0.1   # Secondary body radius
```

## Mathematical Details

### Gravitational Potential (Uniform Density Spheres)

For points outside the sphere (r ≥ R):
```
V = -M/r
```

For points inside the sphere (r < R):
```  
V = -M(3R² - r²)/(2R³)
```

### Rotating Reference Frame

The system rotates with angular velocity:
```
ω² = (M₁ + M₂)/R³
```

The centrifugal potential is:
```
V_centrifugal = -½ω²r²
```

## License

This project is open source and available under the MIT License.

## Contributing

Feel free to submit issues, fork the repository, and create pull requests for any improvements.