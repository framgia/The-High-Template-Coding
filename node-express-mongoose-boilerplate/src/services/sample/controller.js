import moment from 'moment';

const calendar1 = async (req, res, next) => {
  try {
    res.json({
      mode: 'unavailable',
      date: [
        moment()
          .add(2, 'days')
          .format('YYYY-MM-DD'),
        moment()
          .add(4, 'days')
          .format('YYYY-MM-DD'),
        moment()
          .add(6, 'days')
          .format('YYYY-MM-DD'),
      ],
    });
  } catch (err) {
    next(err);
  }
};

const calendar2 = async (req, res, next) => {
  try {
    res.json({
      mode: 'available',
      date: [
        moment()
          .add(2, 'days')
          .format('YYYY-MM-DD'),
        moment()
          .add(4, 'days')
          .format('YYYY-MM-DD'),
        moment()
          .add(6, 'days')
          .format('YYYY-MM-DD'),
      ],
    });
  } catch (err) {
    next(err);
  }
};

const checkbox222 = async (req, res, next) => {
  try {
    res.json({
      data: [
        { value: '001', text: 'text1' },
        { value: '002', text: 'text2' },
        { value: '003', text: 'text3' },
      ],
    });
  } catch (err) {
    next(err);
  }
};

export default {
  calendar1,
  calendar2,
  checkbox222,
};
