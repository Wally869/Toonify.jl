using Images, ImageView

include("my_structs.jl")
include("utils.jl")

config = init_parameters()

function toonify_image(path_img::String, config::parameters)
    steps_toonify = init_steps(config)

    rgb_img = load(path_img)

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
