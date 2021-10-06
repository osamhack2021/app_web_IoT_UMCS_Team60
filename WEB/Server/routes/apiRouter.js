const router = require('express').Router();
const managerRouter = require('./api/managerRouter');
const userRouter = require('./api/userRouter');
const watchmanRouter = require('./api/watchmanRouter');
const doomRouter = require('./api/doomRouter');
const outsideFacilityRouter = require('./api/outsideFacilityRouter');
const doomroomRouter = require('./api/doomroomRouter');
const doomfacilityRouter = require('./api/doomfacilityRouter');
const timetableRouter = require('./api/timetableRouter');
const accessRecordRouter = require('./api/accessRecordRouter');
const currentPositionRouter = require('./api/currentPositionRouter');
const outsideRequestRouter = require('./api/outsideRequestRouter');
const facilityRequestRouter = require('./api/facilityRequestRouter');
const anomalyRouter = require('./api/anomalyRouter');
const beaconRouter = require('./api/beaconRouter');

router.use('/manager', managerRouter); // /api/manager
router.use('/user', userRouter); // /api/user
router.use('/watchman', watchmanRouter); // /api/user
router.use('/doom', doomRouter); // /api/doom
router.use('/outside_facility', outsideFacilityRouter); // /api/outside_facility
router.use('/doomroom', doomroomRouter); // /api/doomroom
router.use('/doomfacility', doomfacilityRouter); // /api/doomfacility
router.use('/timetable', timetableRouter); // /api/timetable
router.use('/access_record', accessRecordRouter); // /api/access_record
router.use('/current_position', currentPositionRouter); // /api/current_position
router.use('/outside_request', outsideRequestRouter); // /api/outside_request
router.use('/facility_request', facilityRequestRouter); // /api/facility_request
router.use('/anomaly', anomalyRouter); // /api/anomaly
router.use('/beacon', beaconRouter); // /api/beacon

module.exports = router;