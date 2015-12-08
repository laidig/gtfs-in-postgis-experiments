select  concat(r.route_short_name, ' ', r.route_long_name) as Route,
	case when split_part(st.arrival_time,':',1)::integer >= 24 then split_part(st.arrival_time,':',1)::integer - 24
		else split_part(st.arrival_time,':',1)::integer END
		as Hour,
	count(st.stop_sequence),

	-- remove this line if you don't care about direction
	t.direction_id
	from gtfs_stop_times st
	
inner join gtfs_trips t on t.trip_id = st.trip_id
inner join gtfs_routes r on t.route_id = r.route_id
where t.service_id = '1'
and st.stop_sequence='1'
-- and split_part(st.arrival_time,':',1) = '07'
-- remove direction_id if you don't care about direction
group by Route, Hour, direction_id
order by count desc