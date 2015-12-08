 -- select trips starting within an hour. Corrects for times after midnight (hour < 24). Please check if this behavior is desired.

select 
	case when split_part(st.arrival_time,':',1)::integer >= 24 then split_part(st.arrival_time,':',1)::integer - 24
		else split_part(st.arrival_time,':',1)::integer END
		as hour,
	count(st.stop_sequence) from gtfs_stop_times st
inner join gtfs_trips t on t.trip_id = st.trip_id
inner join gtfs_routes r on t.route_id = r.route_id
where t.service_id = '1'
and st.stop_sequence='1'
group by hour
order by count desc;