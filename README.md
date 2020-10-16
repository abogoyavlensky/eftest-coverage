# eftest-coverage

[![Clojars Project](https://img.shields.io/clojars/v/abogoyavlensky/eftest-coverage.svg)](https://clojars.org/abogoyavlensky/eftest-coverage)

A tiny wrapper around [Eftest](https://github.com/weavejester/eftest) Clojure test runner
for getting test coverage using [Cloverage](https://github.com/cloverage/cloverage) instrumentation.

## Installation

*project.clj :dependencies*

```clojure
[abogoyavlensky/eftest-coverage "0.1.0"]
```

*deps.edn :deps*

```clojure
abogoyavlensky/eftest-coverage {:mvn/version "0.1.0"}
```

## Usage examples

### Run directly (configurable Eftest)

*deps.edn with -M option*

```clojure
{
 ...
 :aliases {:test
           {:extra-paths ["test"]
            :extra-deps {abogoyavlensky/eftest-coverage {:mvn/version "VERSION"}}
            :main-opts   ["-m" "eftest-coverage.runner"
                          "-p" "src"
                          "-s" "test"]}}}
```

Then run:

```shell
clojure -M:test
```

### Run via Cloverage (only default settings for Eftest)

Running via Cloverage you **don't have ability to configure the Eftest** runner.
Just run Eftest with coverage as is with default settings.
Cloverage's configuration is **fully** available in both cases.

*deps.edn*

```clojure
{...
 :aliases {:test
           {:extra-paths ["test"]
            :extra-deps {abogoyavlensky/eftest-coverage {:mvn/version "VERSION"}}
            :main-opts   ["-m" "cloverage.coverage"
                          "-p" "src"
                          "-s" "test"
                          "--runner" ":eftest-coverage"]}}}
```

```shell
clojure -M:test
```


*project.clj*
```
{...
 [[abogoyavlensky/eftest-coverage "VERSION"]]
 :plugins [[lein-cloverage "1.1.2"]]
 ...
}
```

```shell
lein cloverage --runner :eftest-coverage
```

## Configuration


### Cloverage options
All options for Cloverage available **exactly** as in [origin library](https://github.com/cloverage/cloverage/tree/4a793d34cc603c9ff67e00baa9b485833694a9ff#leiningen-project-options).
The runner option has reasonable default value:

```
--runner :eftest-coverage
```


### Eftest options
All options for Eftest are available
**exactly** as in [origin library](https://github.com/weavejester/eftest#usage) with prefix `--eftest-...`:


|Option|Value|Default|
|------|-----|-------|
|--eftest-fail-fast?|false, true|false|
|--eftest-capture-output?|false, true|true|
|--eftest-multithread?|true, false, :namespaces, :vars| true|
|--eftest-thread-count|*int number > 0*|*calculated if --eftest-multithread? is enabled*|
|--eftest-randomize-seed|*int number >= 0*|0|
|--eftest-report|*path to report function*|eftest.report.progress/report|
|--eftest-test-warn-time|*int time in milliseconds*|nil|


:information_source: *Keeping Eftest's semantic of boolean options with `?` sign at the end
to have full compatibility with origin library.*


### efest-coverage extra options
Also eftest-coverage has a couple extra options for convenience.

|Option|Value|Default|Description|
|------|-----|-------|-----------|
|--eftest-report-to-file|*path to a file*|nil|Redirect Eftest reporting output to a file.|
|--[no-]coverage|boolean flag|--coverage|Run test runner without coverage instrumenting. (enabled by default)|

### Config example with some eftest options enabled

*deps.edn*

```clojure
{...
 :aliases {:test
           {:extra-paths ["test"]
            :extra-deps {abogoyavlensky/eftest-coverage {:mvn/version "VERSION"}}
            :main-opts   ["-m" "eftest-coverage.runner"
                          "-p" "src"
                          "-s" "test"
                          "--eftest-test-warn-time" "100"
                          "--eftest-multithread?" "false"
                          "--eftest-fail-fast?" "true"
                          "--eftest-report" "eftest.report.junit/report"
                          "--eftest-report-to-file" "target/eftest/junit.xml"]}}}
```

## Development

Build a deployable jar of this library:

```
$ make build
```

Install it locally:

```
$ make install
```

Deploy it to Clojars. Needs `CLOJARS_USERNAME` and `CLOJARS_PASSWORD` environment variables:

```
$ make deploy
```

## Heavily inspired by

- https://github.com/metosin/bat-test
- https://github.com/circleci/circleci.test
- https://github.com/FundingCircle/fc4-framework

## Roadmap

- [ ] Add ability to use -X option of Clojure CLI.
- [ ] Add lein-eftest-coverage plugin with ability to configure Eftest runner.
- [ ] Add ability to configure `:only` and metadata selectors for particular tests.

## License

Copyright © 2020 Andrey Bogoyavlensky

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version.
