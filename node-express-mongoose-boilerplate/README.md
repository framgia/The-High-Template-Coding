# RESTful API Node Server Boilerplate

A boilerplate/template project for quickly building production-ready RESTful APIs using Node.js, ExpressJs, and Mongoose.

## Architecture

- Application Framework: [ExpressJs](https://expressjs.com/)
- Database: [MongoDB](https://www.mongodb.com)
- Cache: [Redis](https://redis.io)
- Dependency Management: [Yarn](https://yarnpkg.com)
- Unit Testing Framework: [Jest](https://jestjs.io)
- API Specification Management: [Apiary](https://apiary.io) ([API Blueprint](https://apiblueprint.org))
- Deployment: [Docker](https://www.docker.com) / [Amazon ECR](https://aws.amazon.com/ecr/)

## Repository Layout

- `config`: application configuration files
- `data`: MongoDB/Redis/FileStore data
- `src`: application source codes
- `test`: application unit test codes

## Getting Started

### Installation

Clone the repo:

```bash
git clone https://github.com/toanhm-1842/node-express-mongoose-boilerplate.git
cd node-express-mongoose-boilerplate
```

Install dependencies:

```bash
yarn install
```

### Commands

Running:

```bash
yarn start
```

Testing:

```bash
# run all tests
yarn test

Linting:

```bash
# run ESLint
yarn lint

# fix ESLint errors
yarn lint:fix

# run prettier
yarn prettier

# fix prettier errors
yarn prettier:fix
```

