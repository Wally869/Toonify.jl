using Images, ImageView

include("my_structs.jl")
include("utils.jl")

#=
HueLevels = [0.0,140.0,160.0,240.0,240.0,360.0)]
SatLevels = [0.0,0.15,0.3,0.45,0.6,0.8,1.0]
ValLevels = [0.0,0.3,0.6,1.0]
=#

config = init_parameters()


function toonify_image(path::String, config::parameters)
    steps_toonify = init_steps(config)

    rgb_img = load(path)

    channels = extract_hsv_channels(rgb_img)
    adjust_channels!(channels, steps_toonify)
    hsv_img = colorview(HSV, channels)

    intensities = get_intensities(rgb_img)
    edges = find_edges(intensities)

    for i in 1:length(rgb_img)
        rgb_img[i] = (edges[i] >= config.edge_threshold) ? RGB(0, 0, 0) : RGB(hsv_img[i])
    end

    return rgb_img
end