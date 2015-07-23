drop table if exists gtfs_dist_to_previous;

create table gtfs_dist_to_previous as

select distinct
t.route_id, d.stop_id, d.stop_sequence, round(dist_along_shape) as dist_along_shape
, t.trip_headsign, t.shape_id, s.stop_name, 
 dist_along_shape - lag(dist_along_shape) 
   over (order by t.route_id, t.shape_id, d.stop_sequence, d.stop_id) 
   as dist_to_previous

 from gtfs_stop_distances_along_shape d 
inner join gtfs_trips t on t.shape_id = d.shape_id  
inner join gtfs_stops s on d.stop_id = s.stop_id

order by t.route_id, t.shape_id, d.stop_sequence
;

select * from gtfs_dist_to_previous 
where (dist_to_previous > 0 or stop_sequence = 1); 