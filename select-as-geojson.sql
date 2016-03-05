select s.route_id, s.shape_id, ST_asgeoJSON(ST_simplify(g.the_geom,0.00001), 6,2)
from gtfs_common_shapes s
inner join gtfs_shape_geoms g on s.shape_id = g.shape_id
