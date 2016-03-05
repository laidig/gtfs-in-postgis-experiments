drop table if exists gtfs_stop_time_counts;
	
create table gtfs_stop_time_counts
as 
select c.service_id, s.stop_id, floor(arrival_time_seconds/3600) as hour, count(floor(arrival_time_seconds/3600)) from gtfs_stop_times st
inner join gtfs_stops s on s.stop_id = st.stop_id
inner join gtfs_trips t on t.trip_id = st.trip_id
inner join gtfs_calendar c on t.service_id = c.service_id
where c.monday='1'
group by c.service_id, s.stop_id, floor(arrival_time_seconds/3600)
;
