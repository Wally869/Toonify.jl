# Toonify.jl
Implementation in Julia of the Toonify post-processing filter by Geeks3d

Dependencies

Images
ImageView

Usage

```julia
julia> include("main_toonify.jl")
toonify_image (generic function with 1 method)

julia> config
parameters(0.2f0, 10.0f0, 5.0f0, 5.0f0)

julia> out_img = toonify_img("./Images/classroom.png", config);

```
