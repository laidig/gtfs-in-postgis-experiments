-- Calculate the sum total of scheduled kms of service for any service_id that includes "saturday" (case-insensitive)
-- Does not take into account calendar_dates (one-off holiday service_ids sometimes contain "saturday")
-- Assumes that service_ids only in calendars are the ones to calculate on.

-- Note that the id 'total' is the sum of all service below.


select t.route_id as id, r.route_short_name as route, sum(l.shape_dist/1000) as sched_kms 
from gtfs_shape_lengths l

inner join gtfs_trips t on t.shape_id = l.shape_id
inner join gtfs_routes r on r.route_id = t.route_id
inner join gtfs_calendar c on t.service_id = c.service_id

where c.service_id ilike '%sat%'

group by t.route_id, r.route_short_name

union all

select 'total' as id, 'total_' as name,
sum(l.shape_dist/1000) as sched_kms

from gtfs_shape_lengths l

inner join gtfs_trips t on t.shape_id = l.shape_id
inner join gtfs_calendar c on t.service_id = c.service_id

where c.service_id ilike '%sat%'

order by sched_kms desc



