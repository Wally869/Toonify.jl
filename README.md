# Toonify.jl
Implementation in Julia of the Toonify post-processing filter by Geeks3d
A Phaser.js demonstration can be found [here](https://codepen.io/rexrainbow/full/ErWNXa)

# Dependencies
Images, ImageView

# Usage
Loading main_toonify.jl creates a struct called parameters:
```julia
mutable struct parameters
    edge_threshold::Float32
    hue_level::Float32
    saturation_level::Float32
    value_level::Float32
end
```

Default parameters are: 0.2, 10, 5., 5.
and can be changed separately or by using set_all_parameters!
```julia
function set_all_parameters!(params::parameters, edge_threshold::Float32, hue_level::Float32, 
                            saturation_level::Float32, value_level::Float32)
    set_edge_threshold!(params, edge_threshold)
    set_hue_level!(params, hue_level)
    set_saturation_level!(params, saturation_level)
    set_value_level!(params, value_level)
end
```

Usage is straightforward: load main_toonify, modify the parameters if you want to, then call toonify_image
```julia
julia> include("main_toonify.jl")
toonify_image (generic function with 1 method)

julia> config
parameters(0.2f0, 10.0f0, 5.0f0, 5.0f0)

julia> out_img = toonify_img("./Images/classroom.png", config);

```

# Acknowledgement
GLSL code was taken from [Geeks3D](https://www.geeks3d.com/20140523/glsl-shader-library-toonify-post-processing-filter/)
I also used the code developped by Rex for Phaser.js, see the documentation and sources [here](https://rexrainbow.github.io/phaser3-rex-notes/docs/site/shader-toonify/)
