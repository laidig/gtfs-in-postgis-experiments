-- Calculate the sum total of scheduled kms of service for any service_id that includes "weekday" (case-insensitive)


select t.route_id, r.route_short_name, sum(l.shape_dist) from gtfs_shape_lengths l
inner join gtfs_trips t on t.shape_id = l.shape_id
inner join gtfs_routes r on r.route_id = t.route_id
where t.service_id ilike '%weekday%'
group by t.route_id, r.route_short_name limit 10
