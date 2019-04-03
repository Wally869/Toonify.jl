using Images, ImageView

include("my_structs.jl")

function extract_hsv_channels(img::Array)
    return float(channelview(HSV.(img)))
end

function adjust_channels!(channels, s)
    thresholds = [360., 1., 1.]
    for id_channel in 1:3
        channels[id_channel] = adjust_value.(channels[id_channel], get_level_from_id(s, id_channel),
                                                thresholds[id_channel])
    end
end

function adjust_value(channel_val, step_val, threshold)
    return min(((channel_val / step_val) + 0.5) * step_val, threshold)
end

function apply_array(pix)
    return [pix]
end

function get_intensities(img)
    arr_img = apply_array.(img)
    arr_avg = sum.(channelview.(arr_img)) / 3
    return arr_avg
end

function find_edges(intensities)
    out_intensities = deepcopy(intensities)
    for i in 2:(size(intensities)[1] - 1)
        for j in 2:(size(intensities)[2] - 1)
            out_intensities[i, j] = (abs(intensities[i-1, j] - intensities[i+1, j]) + abs(intensities[i, j+1] - intensities[i, j-1]) + 
                                        abs(intensities[i-1, j-1] - intensities[i+1, j+1]) +abs(intensities[i-1, j+1] - intensities[i+1, j-1])) / 4
        end
    end
    return 5 * clamp01.(out_intensities)
end


function set_edges(pix_val, edge_val, edge_threshold)
    return (edge_val >= edge_threshold) ? RGB(0, 0, 0) : RGB(pix_val)
end