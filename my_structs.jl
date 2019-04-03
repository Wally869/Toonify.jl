mutable struct parameters
    edge_threshold::Float32
    hue_level::Float32
    saturation_level::Float32
    value_level::Float32
end

function init_parameters()
    return parameters(0.2, 10., 5., 5.)
end

function set_edge_threshold!(params::parameters, edge_threshold::Float32)
    params.edge_threshold = edge_threshold
end

function set_hue_level!(params::parameters, hue_level::Float32)
    params.hue_level = hue_level
end

function set_saturation_level!(params::parameters, saturation_level::Float32)
    params.saturation_level = saturation_level
end

function set_value_level!(params::parameters, value_level::Float32)
    params.value_level = value_level
end




mutable struct steps
    hue_step::Float32
    saturation_step::Float32
    value_step::Float32
end

function init_steps()
    return steps(0., 0., 0.)
end

function init_steps(p::parameters)
    s = init_steps()
    adjust_all_steps!(s, p)
    return s
end

function adjust_hue_step!(s::steps, hue_level::Float32)
    s.hue_step = (hue_level > 0) ? 360 / hue_level : 0
end

function adjust_saturation_step!(s::steps, saturation_level::Float32)
    s.saturation_step = (saturation_level > 0) ? 1. / saturation_level : 0
end

function adjust_value_step!(s::steps, value_level::Float32)
    s.value_step = (value_level > 0) ? 1. / value_level : 0
end

function adjust_all_steps!(s::steps, p::parameters)
    adjust_hue_step!(s, p.hue_level)
    adjust_saturation_step!(s, p.saturation_level)
    adjust_value_step!(s, p.value_level)
end

function get_level_from_id(s::steps, id::Integer)
    if id > 3 || id < 0
        println("Error, returning 0.")
        return 0.
    else
        if id == 1
            return s.hue_step
        elseif id == 2
            return s.saturation_step
        else
            return s.value_step
        end
    end
end
