import express from 'express';
import controller from './controller';

const router = express.Router();

router.get('/calendar1', controller.calendar1);
router.get('/calendar2', controller.calendar2);
router.get('/checkbox222', controller.checkbox222);

export default router;
