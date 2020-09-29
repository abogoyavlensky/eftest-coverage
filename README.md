# eftest-coverage

A tiny wrapper around [Eftest](https://github.com/weavejester/eftest) Clojure test runner
for getting test coverage using [Cloverage](https://github.com/cloverage/cloverage) instrumenting.

## Usage

TODO: add usage examples!


## Development

TODO: update to make commands!

Run the project's tests (they'll fail until you edit them):

```
$ clojure -M:dev:test:runner
```

Build a deployable jar of this library:

```
$ make build
```

Install it locally:

```
$ make install
```

Deploy it to Clojars -- needs `CLOJARS_USERNAME` and `CLOJARS_PASSWORD` environment variables:

```
$ make deploy
```

## Inspired by

- https://github.com/metosin/bat-test
- https://github.com/circleci/circleci.test
- https://github.com/FundingCircle/fc4-framework

## License

Copyright © 2020 Andrey Bogoyavlensky

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version.
