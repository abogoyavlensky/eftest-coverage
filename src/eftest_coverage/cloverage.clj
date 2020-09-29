(ns eftest-coverage.cloverage
  "Wrapper for running `cloverage` with `eftest` test runner."
  (:require [cloverage.coverage :as cov]
            [blog.util.runner :as runner]))

; This is based on https://github.com/circleci/circleci.test/blob/master/src/circleci/test/cloverage.clj

(defmethod cov/runner-fn :blog.util
  [args]
  (fn [namespaces]
    (let [results (runner/run-tests args)]
      (apply require (map symbol namespaces))
      {:errors (reduce + ((juxt :error :fail) results))})))
