create table gtfs_common_shapes
as

select route_id, shape_id, direction_id, count(trip_id)
from gtfs_trips
where service_id like '%EE'
group by route_id, shape_id, direction_id
-- a total hack for knocking out less common shapes
having count(trip_id) > 10
