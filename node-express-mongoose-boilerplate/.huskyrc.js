module.exports = {
  hooks: {
    'pre-commit': 'lint-staged',
    // 'pre-push':
    //   'git log -1 | grep -q "\\[skip ci\\]" || ( npm run lint && npm run test )',
  },
};
