/**
 * DyCE_fn_clearWaypoints
 * © 2019 TheOneWhoKnocks
 *
 */
private["_groups"];
_groups = _this;
{
	deleteWaypoint _x;
}forEach (waypoints _groups);
true