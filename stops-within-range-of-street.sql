-- example searching for the first stop on a trip withinin a 1000 ft range of the long island expressway 
-- 
-- streets table (NYC DCP LION) is projected in state plane feet (hence the transform)

-- because of the multiple minimums, this is a wrapped query that returns with an ordered row number 
with times_and_distances as (
select distinct s.stop_id, s.stop_name, t.route_id, t.direction_id, t.trip_id,
	min(st.arrival_time) as arrival_time, 
	min(round(st_distance(l.geom, ST_transform(s.the_geom, 2263)))) as distance,
	row_number()
	
OVER (PARTITION BY t.trip_id order by t.route_id, t.direction_id, min(st.arrival_time)) as rnum

from gtfs_stops s
INNER JOIN lion l on ST_Dwithin(l.geom, ST_transform(s.the_geom, 2263),1000)
INNER JOIN gtfs_stop_times st on s.stop_id = st.stop_id
INNER JOIN gtfs_trips t on t.trip_id = st.trip_id
where 
	l.street ='LONG ISLAND EXPRESSWAY'
	-- school days only
	and 	(t.service_id like '%SD%'
		-- older service_id format
		or t.service_id like '%EE')
group by s.stop_id, s.stop_name, t.route_id, t.direction_id, t.trip_id
 )
 -- to force the 1:1 relation, select from that query result only row #1-- 
select * from times_and_distances 
 where rnum =1 
 order by route_id, direction_id, arrival_time;
