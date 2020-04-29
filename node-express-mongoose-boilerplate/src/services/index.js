import express from 'express';
import sample from './sample';

const router = express.Router();

router.use('/api/sample', sample);

export default router;
